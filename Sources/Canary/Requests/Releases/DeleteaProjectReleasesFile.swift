import Foundation
import Prch

public extension Releases {
  /** Delete a file for a given release. */
  enum DeleteaProjectReleasesFile {
    public static let service = Service<Response>(id: "Delete a Project Release's File", tag: "Releases", method: "DELETE", path: "/api/0/projects/{organization_slug}/{project_slug}/releases/{version}/files/{file_id}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        DeleteaProjectReleasesFile.service
      }

      public struct Options {
        /** The slug of the organization the release belongs to. */
        public var organizationSlug: String

        /** The slug of the project. */
        public var projectSlug: String

        /** The version identifier of the release. */
        public var version: String

        /** The ID of the file to delete. */
        public var fileId: String

        public init(organizationSlug: String, projectSlug: String, version: String, fileId: String) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.version = version
          self.fileId = fileId
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, projectSlug: String, version: String, fileId: String) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, version: version, fileId: fileId)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)").replacingOccurrences(of: "{" + "version" + "}", with: "\(options.version)").replacingOccurrences(of: "{" + "file_id" + "}", with: "\(options.fileId)")
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<Void, Void> {
        switch self {
        case let .status204:
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
      case status204

      /** Forbidden */
      case status403

      /** Not Found */
      case status404

      public var success: Void? {
        switch self {
        case .status204: return ()
        default: return nil
        }
      }

      public var statusCode: Int {
        switch self {
        case .status204: return 204
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status204: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder _: ResponseDecoder) throws {
        switch statusCode {
        case 204: self = .status204
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
