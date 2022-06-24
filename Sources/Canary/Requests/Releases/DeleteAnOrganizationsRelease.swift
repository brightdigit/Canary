import Foundation
import Prch

public extension Releases {
  /** Delete a release for a given organization. */
  enum DeleteAnOrganizationsRelease {
    public static let service = Service<Response>(id: "Delete an Organization's Release", tag: "Releases", method: "DELETE", path: "/api/0/organizations/{organization_slug}/releases/{version}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:releases"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        DeleteAnOrganizationsRelease.service
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

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      public typealias SuccessType = Void

      /** Success */
      case status204

      public var success: Void? {
        switch self {
        case .status204: return ()
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
        }
      }

      public var successful: Bool {
        switch self {
        case .status204: return true
        }
      }

      public init(statusCode: Int, data: Data, decoder _: ResponseDecoder) throws {
        switch statusCode {
        case 204: self = .status204
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
