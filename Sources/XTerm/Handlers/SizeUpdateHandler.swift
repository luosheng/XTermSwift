//
//  File.swift
//  
//
//  Created by Luo Sheng on 2022/9/3.
//

import Foundation
import WebKit

public struct Size {
  var cols: Int
  var rows: Int
}

protocol SizeUpdateHandlerDelegate {
  func didUpdateSize(_ size: Size)
}

class SizeUpdateHandler: NSObject, WKScriptMessageHandler {
  
  var delegate: SizeUpdateHandlerDelegate?
  
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard let body = message.body as? Dictionary<String, Int>,
          let cols = body["cols"],
          let rows = body["rows"] else {
      return
    }
    self.delegate?.didUpdateSize(Size(cols: cols, rows: rows))
  }
  
}
