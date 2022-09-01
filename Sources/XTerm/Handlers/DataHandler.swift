//
//  File.swift
//  
//
//  Created by Luo Sheng on 2022/9/1.
//

import Foundation
import WebKit

protocol DataHandlerDelegate {
  func onData(_ data: String)
}

class DataHandler: NSObject, WKScriptMessageHandler {
  var delegate: DataHandlerDelegate?
  
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard let body = message.body as? String else {
      return
    }
    delegate?.onData(body)
  }
  
}
