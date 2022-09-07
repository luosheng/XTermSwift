import WebKit

public protocol XTermViewDelegate {
  func onData(_ data: String)
  func didUpdateSize(_ size: TermSize)
}

@available(macOS 12.0, *)
open class XTermView: NSView, WKUIDelegate, DataHandlerDelegate, SizeUpdateHandlerDelegate, ReadyHandlerDelegate {
  
  public var size = TermSize(cols: 0, rows: 0)
  public var delegate: XTermViewDelegate?
  
  private var webView: WKWebView!
  private var userContentController = WKUserContentController()
  private var ready = false
  private var pendingTasks: [() -> Void] = []
  
  public override init(frame frameRect: NSRect) {
    super.init(frame: .zero)
    setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  private func setup() {
    let configuration = WKWebViewConfiguration()
    configuration.userContentController = userContentController
    
    self.setupHandlers()
    
    webView = WKWebView(frame: .zero, configuration: configuration)
    webView.autoresizingMask = [.width, .height]
    webView.uiDelegate = self
    self.addSubview(webView)
    
    guard let resourceURL = Bundle.module.resourceURL else {
      return
    }
    let indexURL = resourceURL.appendingPathComponent("index.html")
    webView.loadFileRequest(URLRequest(url: indexURL), allowingReadAccessTo: resourceURL)
  }
  
  private func setupHandlers() {
    let dataHandler = DataHandler(with: self)
    self.userContentController.add(dataHandler, name: dataHandler.getName())
    
    let sizeUpdateHandler = SizeUpdateHandler(with: self)
    self.userContentController.add(sizeUpdateHandler, name: sizeUpdateHandler.getName())
    
    let readyHandler = ReadyHandler(with: self)
    self.userContentController.add(readyHandler, name: readyHandler.getName())
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
      self.webView.callAsyncJavaScript("term.write(data)", arguments: ["data": data], in: nil, in: .page)
    }
  }
  
  public func clear() async {
    execute {
      Task {
        self.webView.callAsyncJavaScript("term.clear()", arguments: [:], in: nil, in: .page)
      }
    }
  }
  
  public func applyTheme(theme: Theme) async {
    execute {
      self.webView.callAsyncJavaScript("term.setOption('theme', theme)", arguments: ["theme": theme.toJSON()], in: nil, in: .page)
    }
  }
  
  // MARK: - WKUIDelegate
  
  public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
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
