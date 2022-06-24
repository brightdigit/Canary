import Foundation
import Prch

public extension Projects {
  /** Return a list of values associated with this key.  The `query`
   parameter can be used to to perform a "contains" match on
   values.
   When [paginated](/api/pagination) can return at most 1000 values. */
  enum ListaTagsValues {
    public static let service = Service<Response>(id: "List a Tag's Values", tag: "Projects", method: "GET", path: "/api/0/projects/{organization_slug}/{project_slug}/tags/{key}/values/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ListaTagsValues.service
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** The slug of the project. */
        public var projectSlug: String

        /** The tag key to look up. */
        public var key: String

        public init(organizationSlug: String, projectSlug: String, key: String) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.key = key
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, projectSlug: String, key: String) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, key: key)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)").replacingOccurrences(of: "{" + "key" + "}", with: "\(options.key)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Return a list of values associated with this key.  The `query`
       parameter can be used to to perform a "contains" match on
       values.
       When [paginated](/api/pagination) can return at most 1000 values. */
      public struct Status200: Model {
        public var name: String

        public init(name: String) {
          self.name = name
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          name = try container.decode("name")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(name, forKey: "name")
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
