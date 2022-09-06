//
//  File.swift
//  
//
//  Created by Luo Sheng on 2022/9/6.
//

import Foundation

public typealias HTMLColor = String

public struct Theme: Codable {
  public var background: HTMLColor?
  public var black: HTMLColor?
  public var blue: HTMLColor?
  public var brightBlack: HTMLColor?
  public var brightBlue: HTMLColor?
  public var brightCyan: HTMLColor?
  public var brightGreen: HTMLColor?
  public var brightMagenta: HTMLColor?
  public var brightRed: HTMLColor?
  public var brightWhite: HTMLColor?
  public var brightYellow: HTMLColor?
  public var cursor: HTMLColor?
  public var cursorAccent: HTMLColor?
  public var cyan: HTMLColor?
  public var foreground: HTMLColor?
  public var green: HTMLColor?
  public var magenta: HTMLColor?
  public var red: HTMLColor?
  public var selection: HTMLColor?
  public var white: HTMLColor?
  public var yellow: HTMLColor?
}

extension Theme {
  
  public static func from(jsonString: String) -> Theme {
    let decoder = JSONDecoder()
    guard let data = jsonString.data(using: .utf8),
          let theme = try? decoder.decode(Theme.self, from: data) else {
      return Theme()
    }
    return theme
  }
  
  public func toJSON() -> [String : String] {
    let encoder = JSONEncoder()
    return (try? JSONSerialization.jsonObject(with: encoder.encode(self))) as? [String : String] ?? [:]
  }
}
