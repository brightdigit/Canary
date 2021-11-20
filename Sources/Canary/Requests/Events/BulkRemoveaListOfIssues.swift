import Foundation
import Prch

public extension Events {
  /** Permanently remove the given issues. The list of issues to modify is given through the `id` query parameter.  It is repeated for each issue that should be removed.
   Only queries by 'id' are accepted.
   If any ids are out of scope this operation will succeed without any data mutation. */
  enum BulkRemoveaListOfIssues {
    public static let service = APIService<Response>(id: "Bulk Remove a List of Issues", tag: "Events", method: "DELETE", path: "/api/0/projects/{organization_slug}/{project_slug}/issues/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:admin"])])

    public final class Request: APIRequest<Response> {
      public struct Options {
        /** The slug of the organization the issues belong to. */
        public var organizationSlug: String

        /** The slug of the project the issues belong to. */
        public var projectSlug: String

        /** A list of IDs of the issues to be removed. This parameter shall be repeated for each issue. */
        public var id: Int?

        public init(organizationSlug: String, projectSlug: String, id: Int? = nil) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.id = id
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: BulkRemoveaListOfIssues.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, projectSlug: String, id: Int? = nil) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, id: id)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(self.options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(self.options.projectSlug)")
      }

      override public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let id = options.id {
          params["id"] = id
        }
        return params
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public typealias SuccessType = Void

      /** Success */
      case status204

      /** Forbidden */
      case status403

      /** Project not found */
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
