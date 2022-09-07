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

class DataHandler: NSObject, BaseHandler {
  var delegate: DataHandlerDelegate?
  
  required init(with delegate: DataHandlerDelegate?) {
    self.delegate = delegate
  }
  
  func getName() -> String {
    return "dataHandler"
  }
  
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    guard let body = message.body as? String else {
      return
    }
    delegate?.onData(body)
  }
  
}
