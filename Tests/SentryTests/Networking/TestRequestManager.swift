import Foundation

// Even if we don't run this test below OSX 10.12 we expect the actual
// implementation to be thread safe.
@available(OSX 10.12, *)
public class TestRequestManager: NSObject, RequestManager {
  private var nextResponse: () -> HTTPURLResponse? = { nil }
  public var isReady: Bool

  private var _requests: [URLRequest] = []
  public var requests: [URLRequest] {
    var result: [URLRequest] = []
    semaphore.wait()
    result.append(contentsOf: _requests)
    semaphore.signal()
    return result
  }

  private let queue = DispatchQueue(label: "TestRequestManager", qos: .background, attributes: [])

  private let semaphore = DispatchSemaphore(value: 1)
  private let group = DispatchGroup()

  public required init(session _: URLSession) {
    isReady = true
  }

  var responseDelay = 0.0
  public func add(_ request: URLRequest, completionHandler: SentryRequestOperationFinished? = nil) {
    semaphore.wait()
    _requests.append(request)
    semaphore.signal()

    let response = nextResponse()
    group.enter()
    queue.asyncAfter(deadline: .now() + responseDelay) {
      if let handler = completionHandler {
        handler(response, nil)
      }
      self.group.leave()
    }
  }

  public func waitForAllRequests() {
    group.waitWithTimeout()
  }

  func returnResponse(response: HTTPURLResponse?) {
    nextResponse = { response }
  }

  func returnResponse(response: @escaping () -> HTTPURLResponse?) {
    nextResponse = response
  }
}
