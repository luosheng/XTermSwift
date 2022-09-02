//
//  File.swift
//  
//
//  Created by Luo Sheng on 2022/9/3.
//

import Foundation
import WebKit

class SizeUpdateHandler: NSObject, WKScriptMessageHandler {
  
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    print(message.body)
  }
  
}
