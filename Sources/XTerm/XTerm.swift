import WebKit

protocol XTermViewDelegate {
  func onData(_ data: String)
}

protocol XTermHandler: WKScriptMessageHandler {
  var delegate: XTermViewDelegate? { get set }
}

@available(macOS 12.0, *)
public class XTermView: NSView {
  
  private var webView: WKWebView!
  var delegate: XTermViewDelegate? {
    didSet {
      for i in 0..<handlers.count {
        handlers[i].delegate = delegate
      }
    }
  }
  var handlers: [XTermHandler] = []
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
    webView = WKWebView(frame: .zero, configuration: configuration)
    webView.autoresizingMask = [.width, .height]
    self.addSubview(webView)
    
    guard let resourceURL = Bundle.module.resourceURL else {
      return
    }
    let indexURL = resourceURL.appendingPathComponent("index.html")
    webView.loadFileRequest(URLRequest(url: indexURL), allowingReadAccessTo: resourceURL)
  }
  
  private func addHandler(_ handler: XTermHandler, name: String) {
    self.userContentController.add(handler, name: name)
    self.handlers.append(handler)
  }
  
  public func write(_ data: String) {
    self.webView.callAsyncJavaScript("term.write(data)", arguments: ["data": data], in: nil, in: .page) { _ in
      
    }
  }
  
}
