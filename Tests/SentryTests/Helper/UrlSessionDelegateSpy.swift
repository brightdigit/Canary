import Foundation

class UrlSessionDelegateSpy: NSObject, URLSessionDelegate {
  var delegateCalled = false

  func urlSession(_: URLSession, didReceive _: URLAuthenticationChallenge, completionHandler _: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    delegateCalled = true
  }
}
