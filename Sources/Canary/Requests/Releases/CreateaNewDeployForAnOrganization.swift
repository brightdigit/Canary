import Foundation
import Prch

public extension Releases {
  /** Create a deploy. */
  enum CreateaNewDeployForAnOrganization {
    public static let service = Service<Response>(id: "Create a New Deploy for an Organization", tag: "Releases", method: "POST", path: "/api/0/organizations/{organization_slug}/releases/{version}/deploys/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        CreateaNewDeployForAnOrganization.service
      }

      /** Create a deploy. */
      public struct Body: Model {
        /** The environment you're deploying to. */
        public var environment: String

        /** An optional date that indicates when the deploy ended. If not provided, the current time is used. */
        public var dateFinished: Date?

        /** An optional date that indicates when the deploy started. */
        public var dateStarted: Date?

        /** The optional name of the deploy. */
        public var name: String?

        /** The optional URL that points to the deploy. */
        public var url: String?

        public init(environment: String, dateFinished: Date? = nil, dateStarted: Date? = nil, name: String? = nil, url: String? = nil) {
          self.environment = environment
          self.dateFinished = dateFinished
          self.dateStarted = dateStarted
          self.name = name
          self.url = url
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          environment = try container.decode("environment")
          dateFinished = try container.decodeIfPresent("dateFinished")
          dateStarted = try container.decodeIfPresent("dateStarted")
          name = try container.decodeIfPresent("name")
          url = try container.decodeIfPresent("url")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(environment, forKey: "environment")
          try container.encodeIfPresent(dateFinished, forKey: "dateFinished")
          try container.encodeIfPresent(dateStarted, forKey: "dateStarted")
          try container.encodeIfPresent(name, forKey: "name")
          try container.encodeIfPresent(url, forKey: "url")
        }
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** The version identifier of the release. */
        public var version: String

        public init(organizationSlug: String, version: String) {
          self.organizationSlug = organizationSlug
          self.version = version
        }
      }

      public var options: Options

      public var body: Body?

      public init(body: Body?, options: Options, encoder _: RequestEncoder? = nil) {
        self.body = body
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, version: String, body: Body? = nil) {
        let options = Options(organizationSlug: organizationSlug, version: version)
        self.init(body: body, options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "version" + "}", with: "\(options.version)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Create a deploy. */
      public struct Status201: Model {
        public var environment: String

        public var name: String?

        public var dateStarted: Date?

        public var dateFinished: Date

        public var url: String?

        public var id: String

        public init(environment: String, name: String?, dateStarted: Date?, dateFinished: Date, url: String?, id: String) {
          self.environment = environment
          self.name = name
          self.dateStarted = dateStarted
          self.dateFinished = dateFinished
          self.url = url
          self.id = id
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          environment = try container.decode("environment")
          name = try container.decodeIfPresent("name")
          dateStarted = try container.decodeIfPresent("dateStarted")
          dateFinished = try container.decode("dateFinished")
          url = try container.decodeIfPresent("url")
          id = try container.decode("id")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(environment, forKey: "environment")
          try container.encodeIfPresent(name, forKey: "name")
          try container.encodeIfPresent(dateStarted, forKey: "dateStarted")
          try container.encode(dateFinished, forKey: "dateFinished")
          try container.encodeIfPresent(url, forKey: "url")
          try container.encode(id, forKey: "id")
        }
      }

      public typealias SuccessType = Status201

      /** Success */
      case status201(Status201)

      /** Already Reported */
      case status208

      /** Forbidden */
      case status403

      /** Not Found */
      case status404

      public var success: Status201? {
        switch self {
        case let .status201(response): return response
        default: return nil
        }
      }

      public var response: Any {
        switch self {
        case let .status201(response): return response
        default: return ()
        }
      }

      public var statusCode: Int {
        switch self {
        case .status201: return 201
        case .status208: return 208
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status201: return true
        case .status208: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 201: self = try .status201(decoder.decode(Status201.self, from: data))
        case 208: self = .status208
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
