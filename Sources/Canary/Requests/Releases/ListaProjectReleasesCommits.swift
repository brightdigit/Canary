import Foundation
import Prch

public extension Releases {
  /** List a project release's commits. */
  enum ListaProjectReleasesCommits {
    public static let service = APIService<Response>(id: "List a Project Release's Commits", tag: "Releases", method: "GET", path: "/api/0/projects/{organization_slug}/{project_slug}/releases/{version}/commits/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      public struct Options {
        /** The slug of the organization the release belongs to. */
        public var organizationSlug: String

        /** The slug of the project the release belongs to. */
        public var projectSlug: String

        /** The version identifier of the release. */
        public var version: String

        public init(organizationSlug: String, projectSlug: String, version: String) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.version = version
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: ListaProjectReleasesCommits.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, projectSlug: String, version: String) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, version: version)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)").replacingOccurrences(of: "{" + "version" + "}", with: "\(options.version)")
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** List a project release's commits. */
      public struct Status200: Model {
        public var dateCreated: DateTime

        public var id: String

        public var message: String?

        public init(dateCreated: DateTime, id: String, message: String?) {
          self.dateCreated = dateCreated
          self.id = id
          self.message = message
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          dateCreated = try container.decode("dateCreated")
          id = try container.decode("id")
          message = try container.decodeIfPresent("message")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(id, forKey: "id")
          try container.encodeIfPresent(message, forKey: "message")
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
