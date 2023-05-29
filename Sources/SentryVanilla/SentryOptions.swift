public class SentryOptions {
  public var dsn: String?
  private var _integrations = [any SentryIntegration]()

  public var beforeSend: ((inout SentryEvent) -> SentryEvent?)?

  public var integrations: [any SentryIntegration]! { _integrations }
}

public extension SentryOptions {
  func add(integration: any SentryIntegration) {
    _integrations.append(integration)
  }
}

public protocol SentryIntegration {
  func register(hub: Hub, options: SentryOptions)
}
