import Foundation

extension Sentry.Thread {
  override open func isEqual(_ object: Any?) -> Bool {
    if let other = object as? Sentry.Thread {
      return threadId == other.threadId &&
        name == other.name &&
        stacktrace == other.stacktrace &&
        crashed == other.crashed &&
        current == other.current
    } else {
      return false
    }
  }

  override open var description: String {
    "\(serialize())"
  }
}

extension Sentry.Stacktrace {
  override open func isEqual(_ object: Any?) -> Bool {
    if let other = object as? Sentry.Stacktrace {
      return frames == other.frames &&
        registers == other.registers
    } else {
      return false
    }
  }

  override open var description: String {
    "\(serialize())"
  }
}

extension Sentry.Frame {
  override open func isEqual(_ object: Any?) -> Bool {
    if let other = object as? Sentry.Frame {
      return symbolAddress == other.symbolAddress &&
        fileName == other.fileName &&
        function == other.function &&
        module == other.module &&
        package == other.package &&
        imageAddress == other.imageAddress &&
        platform == other.platform &&
        instructionAddress == other.instructionAddress &&
        lineNumber == other.lineNumber &&
        columnNumber == other.columnNumber &&
        inApp == other.inApp
    } else {
      return false
    }
  }

  override open var description: String {
    "\(serialize())"
  }
}
