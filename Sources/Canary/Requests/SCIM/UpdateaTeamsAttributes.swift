import Foundation
import Prch

public extension SCIM {
  /** Update a team's attributes with a SCIM Group PATCH Request. Valid Operations are:
   * Renaming a team:
   ```json
   {
       "op": "replace",
       "value": {
           "id": 23,
           "displayName": "newName"
       }
   }
   ```
   * Adding a member to a team:
   ```json
   {
       "op": "add",
       "path": "members",
       "value": [
           {
               "value": 23,
               "display": "testexample@example.com"
           }
       ]
   }
   ```
   * Removing a member from a team:
   ```json
   {
       "op": "remove",
       "path": "members[value eq \"23\"]"
   }
   ```
   *  Replacing an entire member set of a team:
   ```json
   {
       "op": "replace",
       "path": "members",
       "value": [
           {
               "value": 23,
               "display": "testexample2@sentry.io"
           },
           {
               "value": 24,
               "display": "testexample3@sentry.io"
           }
       ]
   }
   ``` */
  enum UpdateaTeamsAttributes {
    public static let service = Service<Response>(id: "Update a Team's Attributes", tag: "SCIM", method: "PATCH", path: "/api/0/organizations/{organization_slug}/scim/v2/Groups/{team_id}", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["team:write"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        UpdateaTeamsAttributes.service
      }

      /** Update a team's attributes with a SCIM Group PATCH Request. Valid Operations are:
       * Renaming a team:
       ```json
       {
           "op": "replace",
           "value": {
               "id": 23,
               "displayName": "newName"
           }
       }
       ```
       * Adding a member to a team:
       ```json
       {
           "op": "add",
           "path": "members",
           "value": [
               {
                   "value": 23,
                   "display": "testexample@example.com"
               }
           ]
       }
       ```
       * Removing a member from a team:
       ```json
       {
           "op": "remove",
           "path": "members[value eq \"23\"]"
       }
       ```
       *  Replacing an entire member set of a team:
       ```json
       {
           "op": "replace",
           "path": "members",
           "value": [
               {
                   "value": 23,
                   "display": "testexample2@sentry.io"
               },
               {
                   "value": 24,
                   "display": "testexample3@sentry.io"
               }
           ]
       }
       ``` */
      public struct Body: Model {
        public var schemas: [String]

        public init(schemas: [String]) {
          self.schemas = schemas
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          schemas = try container.decodeArray("schemas")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(schemas, forKey: "schemas")
        }
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** The id of the team you'd like to query. */
        public var teamId: Int

        public init(organizationSlug: String, teamId: Int) {
          self.organizationSlug = organizationSlug
          self.teamId = teamId
        }
      }

      public var options: Options

      public var body: Body

      public init(body: Body, options: Options, encoder _: RequestEncoder? = nil) {
        self.body = body
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, teamId: Int, body: Body) {
        let options = Options(organizationSlug: organizationSlug, teamId: teamId)
        self.init(body: body, options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "team_id" + "}", with: "\(options.teamId)")
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

      public var response: Any {
        switch self {
        default: return ()
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
