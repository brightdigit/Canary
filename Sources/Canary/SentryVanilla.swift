//
//  File.swift
//  
//
//  Created by Leo Dion on 11/20/21.
//

import Foundation

import struct SentryVanilla.SentryEvent
import class SentryVanilla.Scope
import class SentryVanilla.Sentry
typealias SentryVanillaScope = SentryVanilla.Scope
typealias SentryVanillaSDK = SentryVanilla.Sentry

extension SentryVanilla.SentryEvent {
  init(error: Error) {
    self.init(message: error.localizedDescription)
//    self = [self initWithLevel:kSentryLevelError];
//    self.error = error;
//    return self;
    //    NSString *exceptionValue = [NSString stringWithFormat:@"Code: %ld", (long)error.code];
    //    SentryException *exception = [[SentryException alloc] initWithValue:exceptionValue
    //                                                                   type:error.domain];
    //
    //    // Sentry uses the error domain and code on the mechanism for gouping
    //    SentryMechanism *mechanism = [[SentryMechanism alloc] initWithType:@"NSError"];
    //    SentryMechanismMeta *mechanismMeta = [[SentryMechanismMeta alloc] init];
    //    mechanismMeta.error = [[SentryNSError alloc] initWithDomain:error.domain code:error.code];
    //    mechanism.meta = mechanismMeta;
    //    // The description of the error can be especially useful for error from swift that
    //    // use a simple enum.
    //    mechanism.desc = error.description;
    //
    //    NSDictionary<NSString *, id> *userInfo = [error.userInfo sentry_sanitize];
    //    mechanism.data = userInfo;
    //    exception.mechanism = mechanism;
    //    event.exceptions = @[ exception ];
    //
    //    // Once the UI displays the mechanism data we can the userInfo from the event.context.
    //    [self setUserInfo:userInfo withEvent:event];
    //
    //    return event;
  }
}
