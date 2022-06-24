import Foundation
import Prch

public extension Releases {
  /** Return a list of files for a given release. */
  enum ListAnOrganizationsReleaseFiles {
    public static let service = Service<Response>(id: "List an Organization's Release Files", tag: "Releases", method: "GET", path: "/api/0/organizations/{organization_slug}/releases/{version}/files/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public final class Request: DeprecatedRequest<Response, CanaryAPI> {
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
        super.init(service: ListAnOrganizationsReleaseFiles.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, version: String) {
        let options = Options(organizationSlug: organizationSlug, version: version)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "version" + "}", with: "\(options.version)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Return a list of files for a given release. */
      public struct Status200: Model {
        public var sha1: String

        public var dist: String?

        public var name: String

        public var dateCreated: Date

        public var headers: [String: AnyCodable]

        public var id: String

        public var size: Int

        public init(sha1: String, dist: String?, name: String, dateCreated: Date, headers: [String: AnyCodable], id: String, size: Int) {
          self.sha1 = sha1
          self.dist = dist
          self.name = name
          self.dateCreated = dateCreated
          self.headers = headers
          self.id = id
          self.size = size
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          sha1 = try container.decode("sha1")
          dist = try container.decodeIfPresent("dist")
          name = try container.decode("name")
          dateCreated = try container.decode("dateCreated")
          headers = try container.decodeAny("headers")
          id = try container.decode("id")
          size = try container.decode("size")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(sha1, forKey: "sha1")
          try container.encodeIfPresent(dist, forKey: "dist")
          try container.encode(name, forKey: "name")
          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encodeAny(headers, forKey: "headers")
          try container.encode(id, forKey: "id")
          try container.encode(size, forKey: "size")
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
