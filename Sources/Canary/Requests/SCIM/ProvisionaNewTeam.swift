import Foundation
import Prch

public extension SCIM {
  /** Create a new team bound to an organization via a SCIM Groups POST Request. Note that teams are always created with an empty member set. The endpoint will also do a normalization of uppercase / spaces to lowercase and dashes. */
  enum ProvisionaNewTeam {
    public static let service = Service<Response>(id: "Provision a New Team", tag: "SCIM", method: "POST", path: "/api/0/organizations/{organization_slug}/scim/v2/Groups", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["team:write"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ProvisionaNewTeam.service
      }

      /** Create a new team bound to an organization via a SCIM Groups POST Request. Note that teams are always created with an empty member set. The endpoint will also do a normalization of uppercase / spaces to lowercase and dashes. */
      public struct Body: Model {
        public var schemas: [String]

        public var displayName: String

        public var members: [Members]?

        /** Create a new team bound to an organization via a SCIM Groups POST Request. Note that teams are always created with an empty member set. The endpoint will also do a normalization of uppercase / spaces to lowercase and dashes. */
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

        public init(schemas: [String], displayName: String, members: [Members]? = nil) {
          self.schemas = schemas
          self.displayName = displayName
          self.members = members
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          schemas = try container.decodeArray("schemas")
          displayName = try container.decode("displayName")
          members = try container.decodeArrayIfPresent("members")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(schemas, forKey: "schemas")
          try container.encode(displayName, forKey: "displayName")
          try container.encodeIfPresent(members, forKey: "members")
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

    public enum Response: Prch.Response {
      public var response: ClientResult<Status201, Void> {
        switch self {
        case let .status201(response):
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
      /** Create a new team bound to an organization via a SCIM Groups POST Request. Note that teams are always created with an empty member set. The endpoint will also do a normalization of uppercase / spaces to lowercase and dashes. */
      public struct Status201: Model {
        public var schemas: [String]

        public var id: String

        public var displayName: String

        public var members: [Members]

        public var meta: Meta

        /** Create a new team bound to an organization via a SCIM Groups POST Request. Note that teams are always created with an empty member set. The endpoint will also do a normalization of uppercase / spaces to lowercase and dashes. */
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

        /** Create a new team bound to an organization via a SCIM Groups POST Request. Note that teams are always created with an empty member set. The endpoint will also do a normalization of uppercase / spaces to lowercase and dashes. */
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

      public typealias SuccessType = Status201

      /** Success */
      case status201(Status201)

      /** Bad input */
      case status400

      /** Forbidden */
      case status403

      /** Team slug already exists */
      case status409

      public var success: Status201? {
        switch self {
        case let .status201(response): return response
        default: return nil
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
