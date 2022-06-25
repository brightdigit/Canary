import Foundation
import Prch

public extension Releases {
  /** Retrieve files changed in a release's commits */
  enum RetrieveFilesChangedInaReleasesCommits {
    public static let service = Service<Response>(id: "Retrieve Files Changed in a Release's Commits", tag: "Releases", method: "GET", path: "/api/0/organizations/{organization_slug}/releases/{version}/commitfiles/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        RetrieveFilesChangedInaReleasesCommits.service
      }

      public struct Options {
        /** The slug of the organization the release belongs to. */
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
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, version: String) {
        let options = Options(organizationSlug: organizationSlug, version: version)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "version" + "}", with: "\(options.version)")
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<Void, Void> {
        switch self {
        case .status200:
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
      case status200

      /** Forbidden */
      case status403

      /** Not Found */
      case status404

      public var success: Void? {
        switch self {
        case .status200: return ()
        default: return nil
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
