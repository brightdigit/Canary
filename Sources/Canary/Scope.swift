//
//  File.swift
//  
//
//  Created by Leo Dion on 11/20/21.
//

import Foundation

public struct Scope {
  public init(tags: [String : String]) {
    self.tags = tags
  }
  
  public let tags : [String: String]
  
  
}

extension Scope {
  func configure(_ scope: inout SentryVanilla.Scope) {
    scope.tags = self.tags
  }
}
