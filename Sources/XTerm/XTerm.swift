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
    
  }
  
}
