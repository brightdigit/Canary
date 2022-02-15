import Foundation
import Prch

public extension SCIM {
  /** Delete a team with a SCIM Group DELETE Request. */
  enum DeleteAnIndividualTeam {
    public static let service = APIService<Response>(id: "Delete an Individual Team", tag: "SCIM", method: "DELETE", path: "/api/0/organizations/{organization_slug}/scim/v2/Groups/{team_id}", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["team: admin"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** The id of the team you'd like to delete. */
        public var teamId: Int

        public init(organizationSlug: String, teamId: Int) {
          self.organizationSlug = organizationSlug
          self.teamId = teamId
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: DeleteAnIndividualTeam.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, teamId: Int) {
        let options = Options(organizationSlug: organizationSlug, teamId: teamId)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "team_id" + "}", with: "\(options.teamId)")
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
      case status204

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
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status204: return true
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder _: ResponseDecoder) throws {
        switch statusCode {
        case 204: self = .status204
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
