import Foundation
import Prch

public extension Releases {
  /** Upload a new project release file. */
  enum UploadaNewProjectReleaseFile {
    public static let service = Service<Response>(id: "Upload a New Project Release File", tag: "Releases", method: "POST", path: "/api/0/projects/{organization_slug}/{project_slug}/releases/{version}/files/", hasBody: true, isUpload: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        UploadaNewProjectReleaseFile.service
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** The slug of the project. */
        public var projectSlug: String

        /** The version identifier of the release. */
        public var version: String

        /** The multipart encoded file. */
        public var file: File

        /** The name of the dist. */
        public var dist: String?

        /** This parameter can be supplied multiple times to attach headers to the file. Each header is a string in the format `key:value`. For instance it can be used to define a content type. */
        public var header: String?

        /** The name (full path) of the file. */
        public var name: String?

        public init(organizationSlug: String, projectSlug: String, version: String, file: File, dist: String? = nil, header: String? = nil, name: String? = nil) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.version = version
          self.file = file
          self.dist = dist
          self.header = header
          self.name = name
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, projectSlug: String, version: String, file: File, dist: String? = nil, header: String? = nil, name: String? = nil) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, version: version, file: file, dist: dist, header: header, name: name)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)").replacingOccurrences(of: "{" + "version" + "}", with: "\(options.version)")
      }

      public var formParameters: [String: Any] {
        var params: [String: Any] = [:]
        params["file"] = options.file.base64EncodedString(options:)
        if let dist = options.dist {
          params["dist"] = dist
        }
        if let header = options.header {
          params["header"] = header
        }
        if let name = options.name {
          params["name"] = name
        }
        return params
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI

      /** Upload a new project release file. */
      public struct Status201: Model {
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

      public typealias SuccessType = Status201

      /** Success */
      case status201(Status201)

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
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status201: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 201: self = try .status201(decoder.decode(Status201.self, from: data))
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
