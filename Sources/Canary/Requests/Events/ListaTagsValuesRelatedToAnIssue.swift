import Foundation
import Prch

public extension Events {
  /** Returns details for given tag key related to an issue.
   When [paginated](/api/pagination) can return at most 1000 values. */
  enum ListaTagsValuesRelatedToAnIssue {
    public static let service = Service<Response>(id: "List a Tag's Values Related to an Issue", tag: "Events", method: "GET", path: "/api/0/issues/{issue_id}/tags/{key}/values/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["event:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ListaTagsValuesRelatedToAnIssue.service
      }

      public struct Options {
        /** The ID of the issue to retrieve. */
        public var issueId: String

        /** The tag key to look the values up for. */
        public var key: String

        public init(issueId: String, key: String) {
          self.issueId = issueId
          self.key = key
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(issueId: String, key: String) {
        let options = Options(issueId: issueId, key: key)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "issue_id" + "}", with: "\(options.issueId)").replacingOccurrences(of: "{" + "key" + "}", with: "\(options.key)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Returns details for given tag key related to an issue.
       When [paginated](/api/pagination) can return at most 1000 values. */
      public struct Status200: Model {
        public var key: String

        public var value: String

        public init(key: String, value: String) {
          self.key = key
          self.value = value
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          key = try container.decode("key")
          value = try container.decode("value")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(key, forKey: "key")
          try container.encode(value, forKey: "value")
        }
      }

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** Forbidden */
      case status403

      public var success: [Status200]? {
        switch self {
        case let .status200(response): return response
        default: return nil
        }
      }

      public var response: Any {
        switch self {
        case let .status200(response): return response
        default: return ()
        }
      }

      public var statusCode: Int {
        switch self {
        case .status200: return 200
        case .status403: return 403
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status403: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
        case 403: self = .status403
        default: throw ClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
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
