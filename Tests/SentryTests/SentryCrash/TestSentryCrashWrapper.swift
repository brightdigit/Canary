import Foundation

class TestSentryCrashWrapper: SentryCrashAdapter {
  var internalCrashedLastLaunch = false
  override func crashedLastLaunch() -> Bool {
    internalCrashedLastLaunch
  }

  var internalActiveDurationSinceLastCrash: TimeInterval = 0
  override func activeDurationSinceLastCrash() -> TimeInterval {
    internalActiveDurationSinceLastCrash
  }

  var internalIsBeingTraced = false
  override func isBeingTraced() -> Bool {
    internalIsBeingTraced
  }
}
