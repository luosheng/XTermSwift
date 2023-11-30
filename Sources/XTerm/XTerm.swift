import WebKit

public protocol XTermViewDelegate {
  func onData(_ data: String)
  func didUpdateSize(_ size: TermSize)
}

@available(macOS 12.0, *)
open class XTermView: WKWebView, WKUIDelegate, DataHandlerDelegate, SizeUpdateHandlerDelegate,
  ReadyHandlerDelegate
{

  public var size = TermSize(cols: 0, rows: 0)
  public var delegate: XTermViewDelegate?

  private var userContentController = WKUserContentController()
  private var ready = false
  private var pendingTasks: [() -> Void] = []

  public init(theme: Theme) {
    let configuration = WKWebViewConfiguration()
    configuration.userContentController = userContentController
    super.init(frame: .zero, configuration: configuration)
    setup(theme: theme)
  }

  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setup(theme: Theme) {
    self.setupHandlers()
    self.autoresizingMask = [.width, .height]
    self.uiDelegate = self

    guard let resourceURL = Bundle.module.resourceURL else {
      return
    }
    let indexURL = resourceURL.appendingPathComponent("index.html")
    let indexURLWithHash = URL(
      string: theme.background ?? "#FFFFFF", relativeTo: indexURL)!
    self.loadFileRequest(URLRequest(url: indexURLWithHash), allowingReadAccessTo: resourceURL)

    Task {
      await setFont(
        fontFamily:
          "'SF Mono', SFMono-Regular, ui-monospace, 'DejaVu Sans Mono', Menlo, Consolas, monospace")
    }
  }

  private func setupHandlers() {
    self.addHandler(ReadyHandler(with: self))
    self.addHandler(SizeUpdateHandler(with: self))
    self.addHandler(DataHandler(with: self))
  }

  private func addHandler(_ handler: any BaseHandler) {
    self.userContentController.add(handler, name: handler.getName())
  }

  private func execute(_ task: @escaping () -> Void) {
    if self.ready {
      task()
    } else {
      pendingTasks.append(task)
    }
  }

  public func write(_ data: String) async {
    execute {
      self.callAsyncJavaScript(
        "terminal.write(data)", arguments: ["data": data], in: nil, in: .page)
    }
  }

  public func clear() async {
    execute {
      Task {
        self.callAsyncJavaScript("terminal.clear()", arguments: [:], in: nil, in: .page)
      }
    }
  }

  public func applyTheme(theme: Theme) async {
    execute {
      self.callAsyncJavaScript(
        "terminal.applyTheme(theme)", arguments: ["theme": theme.toJSON()], in: nil, in: .page)
    }
  }

  public func setFont(fontFamily: String, fontSize: CGFloat = 13.0) async {
    execute {
      self.callAsyncJavaScript(
        "terminal.setFont(fontFamily, fontSize)",
        arguments: ["fontFamily": fontFamily, "fontSize": fontSize],
        in: nil,
        in: .page
      )
    }
  }

  // MARK: - WKUIDelegate

  public func webView(
    _ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
    for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures
  ) -> WKWebView? {
    guard let url = navigationAction.request.url else {
      return nil
    }
    NSWorkspace.shared.open(url)
    return nil
  }

  // MARK: - DataHandlerDelegate

  func onData(_ data: String) {
    delegate?.onData(data)
  }

  // MARK: - SizeUpdateHandlerDelegate

  func didUpdateSize(_ size: TermSize) {
    self.size = size
    self.delegate?.didUpdateSize(size)
  }

  // MARK: - ReadyHandlerDelegate

  func onReady() {
    self.ready = true
    self.pendingTasks.forEach { task in
      task()
    }
  }

}
