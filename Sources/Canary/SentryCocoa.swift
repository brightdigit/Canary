//
//  File.swift
//  
//
//  Created by Leo Dion on 11/20/21.
//

#if canImport(Sentry)
import class Sentry.SentrySDK
import class Sentry.Scope
import class Sentry.SentrySDK

typealias SentryCocoaScope = Sentry.Scope
typealias SentryCocoaSDK = Sentry.SentrySDK


extension SentryCocoaScope {
  convenience init(scope: Scope) {
    self.init()
    self.setTags(scope.tags)
  }
}
#endif
