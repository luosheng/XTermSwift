//
//  TerminalView.swift
//  XTermDemo
//
//  Created by Luo Sheng on 2022/8/30.
//

import Foundation
import SwiftUI
import XTerm

struct TerminalView: NSViewRepresentable {
  
  func makeNSView(context: Context) -> some NSView {
    XTermView()
  }
  
  func updateNSView(_ nsView: NSViewType, context: Context) {
    
  }
}
