//
//  File.swift
//  
//
//  Created by Luo Sheng on 2022/9/7.
//

import Foundation
import WebKit

protocol ReadyHandlerDelegate {
  func onReady()
}

class ReadyHandler: NSObject, BaseHandler {
  
  var delegate: ReadyHandlerDelegate?
  
  required init(with delegate: ReadyHandlerDelegate?) {
    self.delegate = delegate
  }
  
  func getName() -> String {
    return "readyHandler"
  }
  
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    self.delegate?.onReady()
  }
  
}
