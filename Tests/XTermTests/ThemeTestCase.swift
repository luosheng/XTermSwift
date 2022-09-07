//
//  ThemeTestCase.swift
//  
//
//  Created by Luo Sheng on 2022/9/6.
//

import XCTest
import XTerm

final class ThemeTestCase: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testJSON() throws {
    let themeJSONString = """
{"background": "#123456"}
"""
    let theme = Theme.from(jsonString: themeJSONString)
    XCTAssertEqual(theme.background, "#123456")
    XCTAssertNil(theme.foreground)
    
    let dict = theme.toJSON()
    XCTAssertEqual(dict.count, 1)
    XCTAssertEqual(dict["background"], "#123456")
  }
  
}
