import WebKit

protocol XTermViewDelegate {
  func onData(_ data: String)
}

@available(macOS 12.0, *)
public class XTermView: NSView, DataHandlerDelegate, SizeUpdateHandlerDelegate {
  
  public var size = Size(cols: 0, rows: 0)
  
  private var webView: WKWebView!
  var delegate: XTermViewDelegate?
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
  
  public func getRows() async -> Int {
    guard let result = try? await self.webView.callAsyncJavaScript("return term.rows", contentWorld: .page) as? Int else {
      return 0
    }
    return result
  }
  
  public func getCols() async -> Int {
    guard let result = try? await self.webView.callAsyncJavaScript("return term.cols", contentWorld: .page) as? Int else {
      return 0
    }
    return result
  }
  
  // MARK: - DataHandlerDelegate

  func onData(_ data: String) {
    delegate?.onData(data)
  }
  
  // MARK: - SizeUpdateDelegate
  
  func didUpdateSize(_ size: Size) {
    self.size = size
  }
  
}
