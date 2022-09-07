//
//  File.swift
//  
//
//  Created by Luo Sheng on 2022/9/3.
//

import Foundation
import WebKit

public struct TermSize {
  public var cols: Int
  public var rows: Int
}

protocol SizeUpdateHandlerDelegate {
  func didUpdateSize(_ size: TermSize)
}

class SizeUpdateHandler: NSObject, BaseHandler {
  
  var delegate: SizeUpdateHandlerDelegate?
  
  func getName() -> String {
    return "sizeUpdateHandler"
  }
  
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard let body = message.body as? Dictionary<String, Int>,
          let cols = body["cols"],
          let rows = body["rows"] else {
      return
    }
    self.delegate?.didUpdateSize(TermSize(cols: cols, rows: rows))
  }
  
}
