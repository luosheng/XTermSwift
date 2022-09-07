//
//  File.swift
//  
//
//  Created by Luo Sheng on 2022/9/7.
//

import Foundation
import WebKit

protocol BaseHandler: WKScriptMessageHandler {
  associatedtype T
  init(with delegate: T)
  func getName() -> String
}
