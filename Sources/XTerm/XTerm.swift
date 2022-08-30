import WebKit

public class XTermView: WKWebView {
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setup()
  }
  
  public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
    super.init(frame: frame, configuration: configuration)
    
    setup()
  }
  
  private func setup() {
    guard let resourceURL = Bundle.module.resourceURL else {
      return
    }
    let indexURL = resourceURL.appendingPathComponent("index.html")
    if #available(macOS 12.0, *) {
      self.loadFileRequest(URLRequest(url: indexURL), allowingReadAccessTo: resourceURL)
    } else {
      // Fallback on earlier versions
    }
  }
  
}
