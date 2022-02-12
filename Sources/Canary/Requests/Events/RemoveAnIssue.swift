import Foundation
import Prch

public extension Events {
  /** Removes an individual issue. */
  enum RemoveAnIssue {
    public static let service = APIService<Response>(id: "Remove an Issue", tag: "Events", method: "DELETE", path: "/api/0/issues/{issue_id}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["event:admin"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      public struct Options {
        /** The ID of the issue to delete. */
        public var issueId: String

        public init(issueId: String) {
          self.issueId = issueId
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: RemoveAnIssue.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(issueId: String) {
        let options = Options(issueId: issueId)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "issue_id" + "}", with: "\(options.issueId)")
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      public typealias SuccessType = Void

      /** Success */
      case status202

      /** Forbidden */
      case status403

      /** The requested resource does not exist */
      case status404

      public var success: Void? {
        switch self {
        case .status202: return ()
        default: return nil
        }
      }

      public var response: Any {
        switch self {
        default: return ()
        }
      }

      public var statusCode: Int {
        switch self {
        case .status202: return 202
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status202: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder _: ResponseDecoder) throws {
        switch statusCode {
        case 202: self = .status202
        case 403: self = .status403
        case 404: self = .status404
        default: throw APIClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
        }
      }

      public var description: String {
        "\(statusCode) \(successful ? "success" : "failure")"
      }

      public var debugDescription: String {
        var string = description
        let responseString = "\(response)"
        if responseString != "()" {
          string += "\n\(responseString)"
        }
        return string
      }
    }
  }
}
