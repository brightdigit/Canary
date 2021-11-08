//
//  File.swift
//  
//
//  Created by Leo Dion on 10/29/21.
//

import Foundation
#if canImport(SentryCocoa)
import SentryCocoa
#endif

import SentryVanilla

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

#if canImport(SentryCocoa)
extension SentryCocoa.Scope {
  convenience init(scope: Scope) {
    self.init()
    self.setTags(scope.tags)
  }
}
#endif


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

//- (SentryEvent *)buildErrorEvent:(NSError *)error
//{
//    SentryEvent *event = [[SentryEvent alloc] initWithError:error];
//
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
//}

//struct CanaryUser {
//  let userID : String
//  let email: String?
//  let username: String?
//  let ipAddress: String?
//  let data: [String: Any]?
//}
//
//
//public enum Level : Int {
//case debug = 1,
//info,
//warning,
//error,
//fatal
//}
//
//public protocol CanaryEvent {
//  var id: UUID { get }
//  var message: String? { get }
//  var error: Error? { get }
//  var occuredAt: Date? { get }
//  var startedAt: Date? { get }
//  var level: Level? { get }
//  var platform: String? { get }
//  var logger: String? { get }
//  var serverName : String? { get }
//  var releaseName : String? { get }
//  var dist : String? { get }
//  var environment : String? { get }
//  var transaction : String? { get }
//  var type : String? { get }
//
//  var tags : [String : String]? { get }
//  var extra: [String : Any]? { get }
//  var sdk: [String : Any]? { get }
//  var modules : [String : String]? { get }
//  var fingerprint : [String]? { get }
//  var user: CanaryUser? { get }
//  var context: [String: [String: Any]]? {get }
//  /**
//   * Contains SentryThread if an crash occurred of it's an user reported exception
//   */
//  @property (nonatomic, strong) NSArray<SentryThread *> *_Nullable threads;
//
//  /**
//   * General information about the SentryException, usually there is only one
//   * exception in the array
//   */
//  @property (nonatomic, strong) NSArray<SentryException *> *_Nullable exceptions;
//
//  /**
//   * Separate SentryStacktrace that can be sent with the event, besides threads
//   */
//  @property (nonatomic, strong) SentryStacktrace *_Nullable stacktrace;
//
//  /**
//   * Containing images loaded during runtime
//   */
//  @property (nonatomic, strong) NSArray<SentryDebugMeta *> *_Nullable debugMeta;
//
//  /**
//   * This contains all breadcrumbs available at the time when the event
//   * occurred/will be sent
//   */
//  @property (nonatomic, strong) NSArray<SentryBreadcrumb *> *_Nullable breadcrumbs;
//
//  /**
//   * Init an SentryEvent will set all needed fields by default
//   * @return SentryEvent
//   */
//  - (instancetype)init;
//
//  /**
//   * Init an SentryEvent will set all needed fields by default
//   * @param level SentryLevel
//   * @return SentryEvent
//   */
//  - (instancetype)initWithLevel:(enum SentryLevel)level NS_DESIGNATED_INITIALIZER;
//
//  /**
//   * Initializes a SentryEvent with an NSError and sets the level to SentryLevelError.
//   *
//   * @param error The error of the event.
//   *
//   * @return The initialized SentryEvent.
//   */
//  - (instancetype)initWithError:(NSError *)error;
//}

public struct CanaryOptions {
  public init(dsn: String) {
    self.dsn = dsn
  }
  
  let dsn : String
}
public struct CanaryClient {
  public init() {
  }
  
  
  #if canImport(SentryCocoa)
  let sentry = SentryCocoa.SentrySDK.self
  #else
  let sentry = SentryVanilla.Sentry.self
  #endif

  public func start(withOptions options: CanaryOptions) throws {
    #if canImport(SentryCocoa)
    sentry.start { newOptions in
      newOptions.dsn = options.dsn
    }
    #else
    try sentry.start { newOptions in
      newOptions.dsn = options.dsn
    }
    #endif
    
  }
  
  public func captureError(_ error: Error, withScope scope: Scope) {
    #if canImport(SentryCocoa)
    self.sentry.capture(error: error, scope: .init(scope: scope))
    #else
    self.sentry.capture(event: .init(error: error), configureScope: scope.configure)
    #endif
  }
  

//
//  func captureEvent(
//  /**
//   * Captures a manually created event and sends it to Sentry.
//   *
//   * @param event The event to send to Sentry.
//   *
//   * @return The SentryId of the event or SentryId.empty if the event is not sent.
//   */
//  - (SentryId *)captureEvent:(SentryEvent *)event NS_SWIFT_NAME(capture(event:));
//
//  /**
//   * Captures a manually created event and sends it to Sentry.
//   *
//   * @param event The event to send to Sentry.
//   * @param scope The scope containing event metadata.
//   *
//   * @return The SentryId of the event or SentryId.empty if the event is not sent.
//   */
//  - (SentryId *)captureEvent:(SentryEvent *)event
//                   withScope:(SentryScope *)scope NS_SWIFT_NAME(capture(event:scope:));
//
//  /**
//   * Captures an error event and sends it to Sentry.
//   *
//   * @param error The error to send to Sentry.
//   *
//   * @return The SentryId of the event or SentryId.empty if the event is not sent.
//   */
//  - (SentryId *)captureError:(NSError *)error NS_SWIFT_NAME(capture(error:));
//
//  /**
//   * Captures an error event and sends it to Sentry.
//   *
//   * @param error The error to send to Sentry.
//   * @param scope The scope containing event metadata.
//   *
//   * @return The SentryId of the event or SentryId.empty if the event is not sent.
//   */
//  - (SentryId *)captureError:(NSError *)error
//                   withScope:(SentryScope *)scope NS_SWIFT_NAME(capture(error:scope:));
//
//  /**
//   * Captures an exception event and sends it to Sentry.
//   *
//   * @param exception The exception to send to Sentry.
//   *
//   * @return The SentryId of the event or SentryId.empty if the event is not sent.
//   */
//  - (SentryId *)captureException:(NSException *)exception NS_SWIFT_NAME(capture(exception:));
//
//  /**
//   * Captures an exception event and sends it to Sentry.
//   *
//   * @param exception The exception to send to Sentry.
//   * @param scope The scope containing event metadata.
//   *
//   * @return The SentryId of the event or SentryId.empty if the event is not sent.
//   */
//  - (SentryId *)captureException:(NSException *)exception
//                       withScope:(SentryScope *)scope NS_SWIFT_NAME(capture(exception:scope:));
//
//  /**
//   * Captures a message event and sends it to Sentry.
//   *
//   * @param message The message to send to Sentry.
//   *
//   * @return The SentryId of the event or SentryId.empty if the event is not sent.
//   */
//  - (SentryId *)captureMessage:(NSString *)message NS_SWIFT_NAME(capture(message:));
//
//  /**
//   * Captures a message event and sends it to Sentry.
//   *
//   * @param message The message to send to Sentry.
//   * @param scope The scope containing event metadata.
//   *
//   * @return The SentryId of the event or SentryId.empty if the event is not sent.
//   */
//  - (SentryId *)captureMessage:(NSString *)message
//                     withScope:(SentryScope *)scope NS_SWIFT_NAME(capture(message:scope:));
//
//  /**
//   * Captures a manually created user feedback and sends it to Sentry.
//   *
//   * @param userFeedback The user feedback to send to Sentry.
//   */
//  - (void)captureUserFeedback:(SentryUserFeedback *)userFeedback
//      NS_SWIFT_NAME(capture(userFeedback:));
//
//  - (void)captureSession:(SentrySession *)session NS_SWIFT_NAME(capture(session:));
//
//  - (void)captureEnvelope:(SentryEnvelope *)envelope NS_SWIFT_NAME(capture(envelope:));
//  func capture(event: SentryEvent, scope: Scope?)
//  func close()
}
