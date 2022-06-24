import Foundation
import Prch

public extension Releases {
  /** Delete a file for a given release. */
  enum DeleteAnOrganizationReleasesFile {
    public static let service = Service<Response>(id: "Delete an Organization Release's File", tag: "Releases", method: "DELETE", path: "/api/0/organizations/{organization_slug}/releases/{version}/files/{file_id}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public final class Request: DeprecatedRequest<Response, CanaryAPI> {
      public struct Options {
        /** The slug of the organization the release belongs to. */
        public var organizationSlug: String

        /** The version identifier of the release. */
        public var version: String

        /** The ID of the file to delete. */
        public var fileId: String

        public init(organizationSlug: String, version: String, fileId: String) {
          self.organizationSlug = organizationSlug
          self.version = version
          self.fileId = fileId
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: DeleteAnOrganizationReleasesFile.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, version: String, fileId: String) {
        let options = Options(organizationSlug: organizationSlug, version: version, fileId: fileId)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "version" + "}", with: "\(options.version)").replacingOccurrences(of: "{" + "file_id" + "}", with: "\(options.fileId)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
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

      public var response: Any {
        switch self {
        default: return ()
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
