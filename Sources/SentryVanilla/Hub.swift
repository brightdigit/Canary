import Foundation

public class Hub: ISentryClient {
  var client: SentryClient
  var scope = Scope()
  // https://github.com/apple/swift-corelibs-foundation/blob/76068b8caf54f250a7be5336a7c6bb97f55469f8/Sources/Foundation/NSLock.swift
  let scopeLock = NSLock() // Must unlock from the same thread

  public init(client: SentryClient, options: SentryOptions) {
    self.client = client

    for integration in options.integrations {
      integration.register(hub: self, options: options)
    }
  }

  public func close() {
    client.close()
  }

  public func capture(event: SentryEvent, configureScope: ((inout Scope) -> Void)? = nil) {
    var scope = self.scope // safe to copy?
    configureScope?(&scope)
    client.capture(event: event, scope: scope)
  }

  public func capture(message: String, configureScope: ((inout Scope) -> Void)? = nil) {
    var scope = self.scope // safe to copy?
    configureScope?(&scope)
    client.capture(message: message, scope: scope)
  }

  public func capture(event: SentryEvent, scope: Scope? = nil) {
    client.capture(event: event, scope: scope)
  }

  public func configure(scope: (inout Scope) -> Void) {
    scopeLock.lock()
    var clone = self.scope
    scope(&clone)
    self.scope = clone
    scopeLock.unlock()
  }
}

public class Scope {
  private var _eventProcessors = [EventProcessor]()

  public var tags = [String: String]()

  public var eventProcessors: [EventProcessor]! { _eventProcessors }
}

public protocol EventProcessor {
  func process(event: inout SentryEvent) -> SentryEvent?
}

public extension Scope {
  func add(eventProcessor: EventProcessor) {
    _eventProcessors.append(eventProcessor)
  }
}
