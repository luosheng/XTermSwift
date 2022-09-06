//
//  File.swift
//  
//
//  Created by Luo Sheng on 2022/9/6.
//

import Foundation

public typealias HTMLColor = String

public struct Theme: Codable {
  var background: HTMLColor?
  var black: HTMLColor?
  var blue: HTMLColor?
  var brightBlack: HTMLColor?
  var brightBlue: HTMLColor?
  var brightCyan: HTMLColor?
  var brightGreen: HTMLColor?
  var brightMagenta: HTMLColor?
  var brightRed: HTMLColor?
  var brightWhite: HTMLColor?
  var brightYellow: HTMLColor?
  var cursor: HTMLColor?
  var cursorAccent: HTMLColor?
  var cyan: HTMLColor?
  var foreground: HTMLColor?
  var green: HTMLColor?
  var magenta: HTMLColor?
  var red: HTMLColor?
  var selection: HTMLColor?
  var white: HTMLColor?
  var yellow: HTMLColor?
  
  public func toJSON() -> [String : String] {
    let encoder = JSONEncoder()
    return (try? JSONSerialization.jsonObject(with: encoder.encode(self))) as? [String : String] ?? [:]
  }
}
