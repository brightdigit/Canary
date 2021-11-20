public enum Sentry {
  private static var hub: Hub?

  public static func start(configure: (inout SentryOptions) -> Void) throws {
    print("Sentry Init")

    var options = SentryOptions()
    configure(&options)

    #if os(macOS)
      options.add(integration: MacOSIntegration())
    #elseif os(iOS)
      options.add(integration: IOSIntegration())
    #elseif os(watchOS)
      options.add(integration: WatchOSIntegration())
    #elseif os(tvOS)
      options.add(integration: TvOSIntegration())
    #elseif os(Linux)
      options.add(integration: LinuxIntegration())
    // crashpad
    #elseif os(Windows)
      options.add(integration: WindowsIntegration())
    // crashpad
    #else
      // throw PlatformNotSupported
    #endif

    #if os(macOS) || os(iOS) || os(tvOS)
      options.add(integration: PLCrashReporterIntegration())
    #endif

    hub = Hub(client: try SentryClient(options: options), options: options)
  }

  public static func close() {
    hub?.close()
  }

  public static func capture(message: String, configureScope: ((inout Scope) -> Void)? = nil) {
    hub?.capture(message: message, configureScope: configureScope)
  }

  public static func capture(event: SentryEvent, configureScope: ((inout Scope) -> Void)? = nil) {
    hub?.capture(event: event, configureScope: configureScope)
  }

  public static func configure(scope: (inout Scope) -> Void) {
    hub?.configure(scope: scope)
  }
}
