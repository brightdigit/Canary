import Foundation
import Prch

public extension Events {
  /** Returns details for given tag key related to an issue. */
  enum RetrieveTagDetails {
    public static let service = APIService<Response>(id: "Retrieve Tag Details", tag: "Events", method: "GET", path: "/api/0/issues/{issue_id}/tags/{key}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["event:read"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
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
        super.init(service: RetrieveTagDetails.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(issueId: String, key: String) {
        let options = Options(issueId: issueId, key: key)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "issue_id" + "}", with: "\(options.issueId)").replacingOccurrences(of: "{" + "key" + "}", with: "\(options.key)")
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Returns details for given tag key related to an issue. */
      public struct Status200: Model {
        public var key: String

        public var totalValues: Int

        public init(key: String, totalValues: Int) {
          self.key = key
          self.totalValues = totalValues
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          key = try container.decode("key")
          totalValues = try container.decode("totalValues")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(key, forKey: "key")
          try container.encode(totalValues, forKey: "totalValues")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Forbidden */
      case status403

      public var success: Status200? {
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
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
        case 403: self = .status403
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
