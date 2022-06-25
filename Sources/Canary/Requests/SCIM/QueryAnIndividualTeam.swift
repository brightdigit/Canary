import Foundation
import Prch

public extension SCIM {
  /** Query an individual team with a SCIM Group GET Request.
   - Note that the members field will only contain up to 10000 members. */
  enum QueryAnIndividualTeam {
    public static let service = Service<Response>(id: "Query an Individual Team", tag: "SCIM", method: "GET", path: "/api/0/organizations/{organization_slug}/scim/v2/Groups/{team_id}", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["team: read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        QueryAnIndividualTeam.service
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

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, teamId: Int) {
        let options = Options(organizationSlug: organizationSlug, teamId: teamId)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "team_id" + "}", with: "\(options.teamId)")
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<Status200, Void> {
        switch self {
        case let .status200(response):
          return .success(response)

        default:
          return .defaultResponse(statusCode, ())
        }
      }

      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Query an individual team with a SCIM Group GET Request.
       - Note that the members field will only contain up to 10000 members. */
      public struct Status200: Model {
        public var schemas: [String]

        public var id: String

        public var displayName: String

        public var members: [Members]

        public var meta: Meta

        /** Query an individual team with a SCIM Group GET Request.
         - Note that the members field will only contain up to 10000 members. */
        public struct Members: Model {
          public var value: String

          public var display: String

          public init(value: String, display: String) {
            self.value = value
            self.display = display
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            value = try container.decode("value")
            display = try container.decode("display")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(value, forKey: "value")
            try container.encode(display, forKey: "display")
          }
        }

        /** Query an individual team with a SCIM Group GET Request.
         - Note that the members field will only contain up to 10000 members. */
        public struct Meta: Model {
          public var resourceType: String?

          public init(resourceType: String? = nil) {
            self.resourceType = resourceType
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            resourceType = try container.decodeIfPresent("resourceType")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(resourceType, forKey: "resourceType")
          }
        }

        public init(schemas: [String], id: String, displayName: String, members: [Members], meta: Meta) {
          self.schemas = schemas
          self.id = id
          self.displayName = displayName
          self.members = members
          self.meta = meta
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          schemas = try container.decodeArray("schemas")
          id = try container.decode("id")
          displayName = try container.decode("displayName")
          members = try container.decodeArray("members")
          meta = try container.decode("meta")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(schemas, forKey: "schemas")
          try container.encode(id, forKey: "id")
          try container.encode(displayName, forKey: "displayName")
          try container.encode(members, forKey: "members")
          try container.encode(meta, forKey: "meta")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Unauthorized */
      case status401

      /** Forbidden */
      case status403

      public var success: Status200? {
        switch self {
        case let .status200(response): return response
        default: return nil
        }
      }

      public var statusCode: Int {
        switch self {
        case .status200: return 200
        case .status401: return 401
        case .status403: return 403
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status401: return false
        case .status403: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
        case 401: self = .status401
        case 403: self = .status403
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
