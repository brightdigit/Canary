import Foundation
import Prch

public extension Events {
  /** Returns details for given tag key related to an issue. */
  enum RetrieveTagDetails {
    public static let service = Service<Response>(id: "Retrieve Tag Details", tag: "Events", method: "GET", path: "/api/0/issues/{issue_id}/tags/{key}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["event:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        RetrieveTagDetails.service
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

    public enum Response: Prch.Response {
      public var response: ClientResult<Status200, Void> {
        switch self {
        case let .status200(response):
          return .success(response)

        default:
          return .defaultResponse(statusCode, ())
        }
      }

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
