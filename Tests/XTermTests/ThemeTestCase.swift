//
//  ThemeTestCase.swift
//  
//
//  Created by Luo Sheng on 2022/9/6.
//

import XCTest
import XTerm

final class ThemeTestCase: XCTestCase {
  
  let themeJSONString = """
{"background": "#123456"}
"""
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testJSON() throws {
    let theme = Theme.from(jsonString: themeJSONString)
    XCTAssertEqual(theme.background, "#123456")
    XCTAssertNil(theme.foreground)
    
    let dict = theme.toJSON()
    XCTAssertEqual(dict.count, 1)
    XCTAssertEqual(dict["background"], "#123456")
  }
  
  func testVSCode() throws {
    let vscodeJson = """
{
    "workbench.colorCustomizations": {
        "terminal.foreground": "#8f93a2",
        "terminal.background": "#0f111a",
        "terminal.ansiBlack": "#546e7a",
        "terminal.ansiBlue": "#82aaff",
        "terminal.ansiCyan": "#89ddff",
        "terminal.ansiGreen": "#c3e88d",
        "terminal.ansiMagenta": "#c792ea",
        "terminal.ansiRed": "#ff5370",
        "terminal.ansiWhite": "#ffffff",
        "terminal.ansiYellow": "#ffcb6b",
        "terminal.ansiBrightBlack": "#546e7a",
        "terminal.ansiBrightBlue": "#82aaff",
        "terminal.ansiBrightCyan": "#89ddff",
        "terminal.ansiBrightGreen": "#c3e88d",
        "terminal.ansiBrightMagenta": "#c792ea",
        "terminal.ansiBrightRed": "#ff5370",
        "terminal.ansiBrightWhite": "#ffffff",
        "terminal.ansiBrightYellow": "#ffcb6b",
        "terminal.selectionBackground": "#1f2233",
        "terminalCursor.foreground": "#ffcc00"
    }
}
"""
    let theme = Theme.fromVSCode(jsonString: vscodeJson)
    XCTAssertEqual(theme.white, "#ffffff")
    XCTAssertEqual(theme.selection, "#1f2233")
  }
  
  func testDefaultColors() throws {
    XCTAssertEqual(Theme.defaultLight.background, "#ffffff")
    XCTAssertEqual(Theme.defaultDark.background, "#000000")
  }
}
