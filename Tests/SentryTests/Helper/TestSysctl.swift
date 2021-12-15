import Foundation

class TestSysctl: SentrySysctl {
  private var internalSystemBootTimestamp = Date(timeIntervalSinceReferenceDate: 0)

  override var systemBootTimestamp: Date {
    internalSystemBootTimestamp
  }

  public func setSystemUpTime(value: Date) {
    internalSystemBootTimestamp = value
  }

  private var internalProcessStartTimestamp = Date(timeIntervalSinceReferenceDate: 0)

  override var processStartTimestamp: Date {
    internalProcessStartTimestamp
  }

  public func setProcessStartTimestamp(value: Date) {
    internalProcessStartTimestamp = value
  }
}
