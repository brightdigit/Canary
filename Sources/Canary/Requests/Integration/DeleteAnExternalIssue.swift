import Foundation
import Prch

public extension Integration {
  /** Delete an external issue. */
  enum DeleteAnExternalIssue {
    public static let service = APIService<Response>(id: "Delete an External Issue", tag: "Integration", method: "DELETE", path: "/api/0/sentry-app-installations/{uuid}/external-issues/{external_issue_id}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["event:admin"])])

    public final class Request: APIRequest<Response> {
      public struct Options {
        /** The uuid of the integration platform integration. */
        public var uuid: String

        /** The id of the external issue. */
        public var externalIssueId: String

        public init(uuid: String, externalIssueId: String) {
          self.uuid = uuid
          self.externalIssueId = externalIssueId
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: DeleteAnExternalIssue.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(uuid: String, externalIssueId: String) {
        let options = Options(uuid: uuid, externalIssueId: externalIssueId)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "uuid" + "}", with: "\(options.uuid)").replacingOccurrences(of: "{" + "external_issue_id" + "}", with: "\(options.externalIssueId)")
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public typealias SuccessType = Void

      /** Success */
      case status204

      /** Forbidden */
      case status403

      /** External issue not found */
      case status404

      public var success: Void? {
        switch self {
        case .status204: return ()
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
        case .status204: return 204
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status204: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder _: ResponseDecoder) throws {
        switch statusCode {
        case 204: self = .status204
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
