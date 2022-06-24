import Foundation
import Prch

public extension Integration {
  /** Return a list of integration platform installations for a given organization. */
  enum ListAnOrganizationsIntegrationPlatformInstallations {
    public static let service = Service<Response>(id: "List an Organization's Integration Platform Installations", tag: "Integration", method: "GET", path: "/api/0/organizations/{organization_slug}/sentry-app-installations/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["org:read", "org:integrations"])])

    public final class Request: DeprecatedRequest<Response, CanaryAPI> {
      public struct Options {
        /** The organization short name. */
        public var organizationSlug: String

        public init(organizationSlug: String) {
          self.organizationSlug = organizationSlug
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: ListAnOrganizationsIntegrationPlatformInstallations.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String) {
        let options = Options(organizationSlug: organizationSlug)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Return a list of integration platform installations for a given organization. */
      public struct Status200: Model {
        public var app: App

        public var organization: Organization

        public var uuid: String

        public var status: String

        /** Return a list of integration platform installations for a given organization. */
        public struct App: Model {
          public var uuid: String

          public var slug: String

          public init(uuid: String, slug: String) {
            self.uuid = uuid
            self.slug = slug
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            uuid = try container.decode("uuid")
            slug = try container.decode("slug")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(uuid, forKey: "uuid")
            try container.encode(slug, forKey: "slug")
          }
        }

        /** Return a list of integration platform installations for a given organization. */
        public struct Organization: Model {
          public var slug: String

          public init(slug: String) {
            self.slug = slug
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            slug = try container.decode("slug")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(slug, forKey: "slug")
          }
        }

        public init(app: App, organization: Organization, uuid: String, status: String) {
          self.app = app
          self.organization = organization
          self.uuid = uuid
          self.status = status
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          app = try container.decode("app")
          organization = try container.decode("organization")
          uuid = try container.decode("uuid")
          status = try container.decode("status")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(app, forKey: "app")
          try container.encode(organization, forKey: "organization")
          try container.encode(uuid, forKey: "uuid")
          try container.encode(status, forKey: "status")
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
