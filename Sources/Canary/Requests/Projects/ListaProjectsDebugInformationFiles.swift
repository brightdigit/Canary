import Foundation
import Prch

public extension Projects {
  /** Retrieve a list of debug information files for a given project. */
  enum ListaProjectsDebugInformationFiles {
    public static let service = APIService<Response>(id: "List a Project's Debug Information Files", tag: "Projects", method: "GET", path: "/api/0/projects/{organization_slug}/{project_slug}/files/dsyms/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:read"])])

    public final class Request: APIRequest<Response> {
      public struct Options {
        /** The slug of the organization the file belongs to. */
        public var organizationSlug: String

        /** The slug of the project to list the DIFs of. */
        public var projectSlug: String

        public init(organizationSlug: String, projectSlug: String) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: ListaProjectsDebugInformationFiles.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, projectSlug: String) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)")
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public typealias SuccessType = Void

      /** Success */
      case status200

      /** Forbidden */
      case status403

      /** The requested resource does not exist */
      case status404

      public var success: Void? {
        switch self {
        case .status200: return ()
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

      public init(statusCode: Int, data: Data, decoder _: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = .status200
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
