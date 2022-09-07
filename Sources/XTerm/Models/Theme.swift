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

// MARK: - Plain JSON

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

// MARK: - VSCode style https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master/vscode

extension Theme {
  
  public static func fromVSCode(jsonString: String) -> Theme {
    var theme = Theme()
    guard let data = jsonString.data(using: .utf8),
          let object = try? JSONSerialization.jsonObject(with: data) as? [String : [String : String]],
          let colors = object["workbench.colorCustomizations"] else {
      return theme
    }
    
    theme.foreground = colors["terminal.foreground"]
    theme.background = colors["terminal.background"]
    theme.black = colors["terminal.ansiBlack"]
    theme.blue = colors["terminal.ansiBlue"]
    theme.cyan = colors["terminal.ansiCyan"]
    theme.green = colors["terminal.ansiGreen"]
    theme.magenta = colors["terminal.ansiMagenta"]
    theme.red = colors["terminal.ansiRed"]
    theme.white = colors["terminal.ansiWhite"]
    theme.yellow = colors["terminal.ansiYellow"]
    theme.brightBlack = colors["terminal.ansiBlack"]
    theme.brightBlue = colors["terminal.ansiBrightBlue"]
    theme.brightCyan = colors["terminal.ansiBrightCyan"]
    theme.brightGreen = colors["terminal.ansiBrightGreen"]
    theme.brightMagenta = colors["terminal.ansiBrightMagenta"]
    theme.brightRed = colors["terminal.ansiBrightRed"]
    theme.brightWhite = colors["terminal.ansiBrightWhite"]
    theme.brightYellow = colors["terminal.ansiBrightYellow"]
    theme.selection = colors["terminal.selectionBackground"]
    theme.cursor = colors["terminalCursor.foreground"]
    
    return theme
  }
  
}
