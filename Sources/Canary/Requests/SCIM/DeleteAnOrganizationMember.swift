import Foundation
import Prch

public extension SCIM {
  /** Delete an organization member with a SCIM User DELETE Request. */
  enum DeleteAnOrganizationMember {
    public static let service = Service<Response>(id: "Delete an Organization Member", tag: "SCIM", method: "DELETE", path: "/api/0/organizations/{organization_slug}/scim/v2/Users/{member_id}", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["member:admin"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        DeleteAnOrganizationMember.service
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** The id of the member you'd like to delete. */
        public var memberId: Int

        public init(organizationSlug: String, memberId: Int) {
          self.organizationSlug = organizationSlug
          self.memberId = memberId
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, memberId: Int) {
        let options = Options(organizationSlug: organizationSlug, memberId: memberId)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "member_id" + "}", with: "\(options.memberId)")
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<Void, Void> {
        switch self {
        case .status204:
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

      /** Unauthorized */
      case status401

      /** Forbidden */
      case status403

      /** Not Found. */
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
        case .status401: return 401
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status204: return true
        case .status401: return false
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder _: ResponseDecoder) throws {
        switch statusCode {
        case 204: self = .status204
        case 401: self = .status401
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
