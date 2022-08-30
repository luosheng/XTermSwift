import WebKit

public class XTermView: NSView {
  
  private var webView: WKWebView!
  
  public override init(frame frameRect: NSRect) {
    super.init(frame: .zero)
    setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  private func setup() {
    webView = WKWebView(frame: .zero)
    webView.autoresizingMask = [.width, .height]
    self.addSubview(webView)
    
    guard let resourceURL = Bundle.module.resourceURL else {
      return
    }
    let indexURL = resourceURL.appendingPathComponent("index.html")
    if #available(macOS 12.0, *) {
      webView.loadFileRequest(URLRequest(url: indexURL), allowingReadAccessTo: resourceURL)
    } else {
      // Fallback on earlier versions
    }
  }
  
}
