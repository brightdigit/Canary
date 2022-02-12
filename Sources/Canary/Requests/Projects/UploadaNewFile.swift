import Foundation
import Prch

public extension Projects {
  /** Upload a new debug information file for the given release.
   Unlike other API requests, files must be uploaded using the
   traditional multipart/form-data content-type.
   The file uploaded is a zip archive of an Apple .dSYM folder which
   contains the individual debug images.  Uploading through this endpoint
   will create different files for the contained images. */
  enum UploadaNewFile {
    public static let service = APIService<Response>(id: "Upload a New File", tag: "Projects", method: "POST", path: "/api/0/projects/{organization_slug}/{project_slug}/files/dsyms/", hasBody: true, isUpload: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:write"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      public struct Options {
        /** The slug of the organization the project belongs to. */
        public var organizationSlug: String

        /** The slug of the project to upload a file to. */
        public var projectSlug: String

        /** The multipart encoded file. */
        public var file: File

        public init(organizationSlug: String, projectSlug: String, file: File) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.file = file
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: UploadaNewFile.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, projectSlug: String, file: File) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, file: file)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(self.options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(self.options.projectSlug)")
      }

      override public var formParameters: [String: Any] {
        var params: [String: Any] = [:]
        params["file"] = options.file.base64EncodedString(options:)
        return params
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      public typealias SuccessType = Void

      /** Success */
      case status201

      /** Bad Input */
      case status400

      /** Forbidden */
      case status403

      /** The requested resource does not exist */
      case status404

      public var success: Void? {
        switch self {
        case .status201: return ()
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
        case .status201: return 201
        case .status400: return 400
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status201: return true
        case .status400: return false
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder _: ResponseDecoder) throws {
        switch statusCode {
        case 201: self = .status201
        case 400: self = .status400
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
