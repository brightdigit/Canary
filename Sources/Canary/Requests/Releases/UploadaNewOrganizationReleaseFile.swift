import Foundation
import Prch

public extension Releases {
  /** Upload a new organization release file. */
  enum UploadaNewOrganizationReleaseFile {
    public static let service = Service<Response>(id: "Upload a New Organization Release File", tag: "Releases", method: "POST", path: "/api/0/organizations/{organization_slug}/releases/{version}/files/", hasBody: true, isUpload: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        UploadaNewOrganizationReleaseFile.service
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

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

        public init(organizationSlug: String, version: String, file: File, dist: String? = nil, header: String? = nil, name: String? = nil) {
          self.organizationSlug = organizationSlug
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
      public init(organizationSlug: String, version: String, file: File, dist: String? = nil, header: String? = nil, name: String? = nil) {
        let options = Options(organizationSlug: organizationSlug, version: version, file: file, dist: dist, header: header, name: name)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "version" + "}", with: "\(options.version)")
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

    public enum Response: Prch.Response {
      public var response: ClientResult<Void, Void> {
        switch self {
        case .status201:
          return .success(())

        default:
          return .defaultResponse(statusCode, ())
        }
      }

      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      public typealias SuccessType = Void

      /** Success */
      case status201

      /** Forbidden */
      case status403

      /** Not Found */
      case status404

      public var success: Void? {
        switch self {
        case .status201: return ()
        default: return nil
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

      public init(statusCode: Int, data: Data, decoder _: ResponseDecoder) throws {
        switch statusCode {
        case 201: self = .status201
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
