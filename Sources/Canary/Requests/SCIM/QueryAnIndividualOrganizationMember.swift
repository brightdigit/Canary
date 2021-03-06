import Foundation
import Prch

public extension SCIM {
  /** Query an individual organization member with a SCIM User GET Request.
   - The `name` object will contain fields `firstName` and `lastName` with the values of `N/A`. Sentry's SCIM API does not currently support these fields but returns them for compatibility purposes. */
  enum QueryAnIndividualOrganizationMember {
    public static let service = Service<Response>(id: "Query an Individual Organization Member", tag: "SCIM", method: "GET", path: "/api/0/organizations/{organization_slug}/scim/v2/Users/{member_id}", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["member:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        QueryAnIndividualOrganizationMember.service
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** The id of the member you'd like to query. */
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
      /** Query an individual organization member with a SCIM User GET Request.
       - The `name` object will contain fields `firstName` and `lastName` with the values of `N/A`. Sentry's SCIM API does not currently support these fields but returns them for compatibility purposes. */
      public struct Status200: Model {
        public var schemas: [String]

        public var id: String

        public var active: Bool

        public var userName: String

        public var name: Name

        public var meta: Meta

        public var emails: [Emails]

        /** Query an individual organization member with a SCIM User GET Request.
         - The `name` object will contain fields `firstName` and `lastName` with the values of `N/A`. Sentry's SCIM API does not currently support these fields but returns them for compatibility purposes. */
        public struct Name: Model {
          public var familyName: String?

          public var givenName: String?

          public init(familyName: String? = nil, givenName: String? = nil) {
            self.familyName = familyName
            self.givenName = givenName
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            familyName = try container.decodeIfPresent("familyName")
            givenName = try container.decodeIfPresent("givenName")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(familyName, forKey: "familyName")
            try container.encodeIfPresent(givenName, forKey: "givenName")
          }
        }

        /** Query an individual organization member with a SCIM User GET Request.
         - The `name` object will contain fields `firstName` and `lastName` with the values of `N/A`. Sentry's SCIM API does not currently support these fields but returns them for compatibility purposes. */
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

        /** Query an individual organization member with a SCIM User GET Request.
         - The `name` object will contain fields `firstName` and `lastName` with the values of `N/A`. Sentry's SCIM API does not currently support these fields but returns them for compatibility purposes. */
        public struct Emails: Model {
          public var primary: Bool?

          public var type: String?

          public var value: String?

          public init(primary: Bool? = nil, type: String? = nil, value: String? = nil) {
            self.primary = primary
            self.type = type
            self.value = value
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            primary = try container.decodeIfPresent("primary")
            type = try container.decodeIfPresent("type")
            value = try container.decodeIfPresent("value")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(primary, forKey: "primary")
            try container.encodeIfPresent(type, forKey: "type")
            try container.encodeIfPresent(value, forKey: "value")
          }
        }

        public init(schemas: [String], id: String, active: Bool, userName: String, name: Name, meta: Meta, emails: [Emails]) {
          self.schemas = schemas
          self.id = id
          self.active = active
          self.userName = userName
          self.name = name
          self.meta = meta
          self.emails = emails
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          schemas = try container.decodeArray("schemas")
          id = try container.decode("id")
          active = try container.decode("active")
          userName = try container.decode("userName")
          name = try container.decode("name")
          meta = try container.decode("meta")
          emails = try container.decodeArray("emails")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(schemas, forKey: "schemas")
          try container.encode(id, forKey: "id")
          try container.encode(active, forKey: "active")
          try container.encode(userName, forKey: "userName")
          try container.encode(name, forKey: "name")
          try container.encode(meta, forKey: "meta")
          try container.encode(emails, forKey: "emails")
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
