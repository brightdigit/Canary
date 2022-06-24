import Foundation
import Prch

public extension SCIM {
  /** Create a new Organization Member via a SCIM Users POST Request. `userName` should be set to the SAML field used for email, and active should be set to `true`. Sentry's SCIM API doesn't currently support setting users to inactive and the member will be deleted if inactive is set to `false`. The API also does not support setting secondary emails. */
  enum ProvisionaNewOrganizationMember {
    public static let service = Service<Response>(id: "Provision a New Organization Member", tag: "SCIM", method: "POST", path: "/api/0/organizations/{organization_slug}/scim/v2/Users", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["member:write"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ProvisionaNewOrganizationMember.service
      }

      /** Create a new Organization Member via a SCIM Users POST Request. `userName` should be set to the SAML field used for email, and active should be set to `true`. Sentry's SCIM API doesn't currently support setting users to inactive and the member will be deleted if inactive is set to `false`. The API also does not support setting secondary emails. */
      public struct Body: Model {
        public var schemas: [String]

        public var userName: String

        public var active: Bool

        public var displayName: String?

        public var emails: [Emails]?

        public var externalId: String?

        public var locale: String?

        /** Create a new Organization Member via a SCIM Users POST Request. `userName` should be set to the SAML field used for email, and active should be set to `true`. Sentry's SCIM API doesn't currently support setting users to inactive and the member will be deleted if inactive is set to `false`. The API also does not support setting secondary emails. */
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

        public init(schemas: [String], userName: String, active: Bool, displayName: String? = nil, emails: [Emails]? = nil, externalId: String? = nil, locale: String? = nil) {
          self.schemas = schemas
          self.userName = userName
          self.active = active
          self.displayName = displayName
          self.emails = emails
          self.externalId = externalId
          self.locale = locale
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          schemas = try container.decodeArray("schemas")
          userName = try container.decode("userName")
          active = try container.decode("active")
          displayName = try container.decodeIfPresent("displayName")
          emails = try container.decodeArrayIfPresent("emails")
          externalId = try container.decodeIfPresent("externalId")
          locale = try container.decodeIfPresent("locale")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(schemas, forKey: "schemas")
          try container.encode(userName, forKey: "userName")
          try container.encode(active, forKey: "active")
          try container.encodeIfPresent(displayName, forKey: "displayName")
          try container.encodeIfPresent(emails, forKey: "emails")
          try container.encodeIfPresent(externalId, forKey: "externalId")
          try container.encodeIfPresent(locale, forKey: "locale")
        }
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        public init(organizationSlug: String) {
          self.organizationSlug = organizationSlug
        }
      }

      public var options: Options

      public var body: Body

      public init(body: Body, options: Options, encoder _: RequestEncoder? = nil) {
        self.body = body
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, body: Body) {
        let options = Options(organizationSlug: organizationSlug)
        self.init(body: body, options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)")
      }
    }

    public enum Response: DeprecatedResponse, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Create a new Organization Member via a SCIM Users POST Request. `userName` should be set to the SAML field used for email, and active should be set to `true`. Sentry's SCIM API doesn't currently support setting users to inactive and the member will be deleted if inactive is set to `false`. The API also does not support setting secondary emails. */
      public struct Status201: Model {
        public var schemas: [String]

        public var id: String

        public var active: Bool

        public var userName: String

        public var name: Name

        public var meta: Meta

        public var emails: [Emails]

        /** Create a new Organization Member via a SCIM Users POST Request. `userName` should be set to the SAML field used for email, and active should be set to `true`. Sentry's SCIM API doesn't currently support setting users to inactive and the member will be deleted if inactive is set to `false`. The API also does not support setting secondary emails. */
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

        /** Create a new Organization Member via a SCIM Users POST Request. `userName` should be set to the SAML field used for email, and active should be set to `true`. Sentry's SCIM API doesn't currently support setting users to inactive and the member will be deleted if inactive is set to `false`. The API also does not support setting secondary emails. */
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

        /** Create a new Organization Member via a SCIM Users POST Request. `userName` should be set to the SAML field used for email, and active should be set to `true`. Sentry's SCIM API doesn't currently support setting users to inactive and the member will be deleted if inactive is set to `false`. The API also does not support setting secondary emails. */
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

      public typealias SuccessType = Status201

      /** Success */
      case status201(Status201)

      /** Bad input */
      case status400

      /** Forbidden */
      case status403

      /** User already exists in the database. */
      case status409

      public var success: Status201? {
        switch self {
        case let .status201(response): return response
        default: return nil
        }
      }

      public var response: Any {
        switch self {
        case let .status201(response): return response
        default: return ()
        }
      }

      public var statusCode: Int {
        switch self {
        case .status201: return 201
        case .status400: return 400
        case .status403: return 403
        case .status409: return 409
        }
      }

      public var successful: Bool {
        switch self {
        case .status201: return true
        case .status400: return false
        case .status403: return false
        case .status409: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 201: self = try .status201(decoder.decode(Status201.self, from: data))
        case 400: self = .status400
        case 403: self = .status403
        case 409: self = .status409
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
