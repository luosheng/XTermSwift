import WebKit

public protocol XTermViewDelegate {
  func onData(_ data: String)
}

@available(macOS 12.0, *)
open class XTermView: NSView, DataHandlerDelegate, SizeUpdateHandlerDelegate {
  
  public var size = TermSize(cols: 0, rows: 0)
  public var delegate: XTermViewDelegate?
  
  private var webView: WKWebView!
  var userContentController = WKUserContentController()
  
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
    self.addSubview(webView)
    
    guard let resourceURL = Bundle.module.resourceURL else {
      return
    }
    let indexURL = resourceURL.appendingPathComponent("index.html")
    webView.loadFileRequest(URLRequest(url: indexURL), allowingReadAccessTo: resourceURL)
  }
  
  private func setupHandlers() {
    let dataHandler = DataHandler()
    dataHandler.delegate = self
    self.userContentController.add(dataHandler, name: "xtermOnData")
    
    let sizeUpdateHandler = SizeUpdateHandler()
    sizeUpdateHandler.delegate = self
    self.userContentController.add(sizeUpdateHandler, name: "sizeUpdateHandler")
  }
  
  public func write(_ data: String) async {
    self.webView.callAsyncJavaScript("term.write(data)", arguments: ["data": data], in: nil, in: .page)
  }
  
  // MARK: - DataHandlerDelegate

  func onData(_ data: String) {
    delegate?.onData(data)
  }
  
  // MARK: - SizeUpdateDelegate
  
  func didUpdateSize(_ size: TermSize) {
    self.size = size
  }
  
}
