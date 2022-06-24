import Foundation
import Prch

public extension Integration {
  /** Create an external issue from an integration platform integration. */
  enum CreateAnExternalIssue {
    public static let service = Service<Response>(id: "Create an External Issue", tag: "Integration", method: "POST", path: "/api/0/sentry-app-installations/{uuid}/external-issues/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["event:write"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        CreateAnExternalIssue.service
      }

      /** Create an external issue from an integration platform integration. */
      public struct Body: Model {
        /** The ID of the Sentry issue to link the external issue to. */
        public var issueId: Int

        /** The URL of the external service to link the issue to. */
        public var webUrl: String

        /** The external service's project. */
        public var project: String

        /** A unique identifier of the external issue. */
        public var identifier: String

        public init(issueId: Int, webUrl: String, project: String, identifier: String) {
          self.issueId = issueId
          self.webUrl = webUrl
          self.project = project
          self.identifier = identifier
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          issueId = try container.decode("issueId")
          webUrl = try container.decode("webUrl")
          project = try container.decode("project")
          identifier = try container.decode("identifier")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(issueId, forKey: "issueId")
          try container.encode(webUrl, forKey: "webUrl")
          try container.encode(project, forKey: "project")
          try container.encode(identifier, forKey: "identifier")
        }
      }

      public struct Options {
        /** The uuid of the integration platform integration. */
        public var uuid: String

        public init(uuid: String) {
          self.uuid = uuid
        }
      }

      public var options: Options

      public var body: Body

      public init(body: Body, options: Options, encoder _: RequestEncoder? = nil) {
        self.body = body
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(uuid: String, body: Body) {
        let options = Options(uuid: uuid)
        self.init(body: body, options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "uuid" + "}", with: "\(options.uuid)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Create an external issue from an integration platform integration. */
      public struct Status200: Model {
        public var id: String

        public var issueId: String

        public var serviceType: String

        public var displayName: String

        public var webUrl: String

        public init(id: String, issueId: String, serviceType: String, displayName: String, webUrl: String) {
          self.id = id
          self.issueId = issueId
          self.serviceType = serviceType
          self.displayName = displayName
          self.webUrl = webUrl
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          id = try container.decode("id")
          issueId = try container.decode("issueId")
          serviceType = try container.decode("serviceType")
          displayName = try container.decode("displayName")
          webUrl = try container.decode("webUrl")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(id, forKey: "id")
          try container.encode(issueId, forKey: "issueId")
          try container.encode(serviceType, forKey: "serviceType")
          try container.encode(displayName, forKey: "displayName")
          try container.encode(webUrl, forKey: "webUrl")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Forbidden */
      case status403

      /** Not Found */
      case status404

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
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
        case 403: self = .status403
        case 404: self = .status404
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
