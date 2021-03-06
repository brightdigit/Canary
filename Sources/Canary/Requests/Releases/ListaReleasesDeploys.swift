import Foundation
import Prch

public extension Releases {
  /** Return a list of deploys for a given release. */
  enum ListaReleasesDeploys {
    public static let service = Service<Response>(id: "List a Release's Deploys", tag: "Releases", method: "GET", path: "/api/0/organizations/{organization_slug}/releases/{version}/deploys/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ListaReleasesDeploys.service
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

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, version: String) {
        let options = Options(organizationSlug: organizationSlug, version: version)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "version" + "}", with: "\(options.version)")
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<[Status200], Void> {
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
      /** Return a list of deploys for a given release. */
      public struct Status200: Model {
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

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** Forbidden */
      case status403

      /** Not Found */
      case status404

      public var success: [Status200]? {
        switch self {
        case let .status200(response): return response
        default: return nil
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
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
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
