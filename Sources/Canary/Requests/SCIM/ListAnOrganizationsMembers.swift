import Foundation
import Prch

public extension SCIM {
  /** Returns a paginated list of members bound to a organization with a SCIM Users GET Request. */
  enum ListAnOrganizationsMembers {
    public static let service = APIService<Response>(id: "List an Organization's Members", tag: "SCIM", method: "GET", path: "/api/0/organizations/{organization_slug}/scim/v2/Users", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["member:read"])])

    public final class Request: APIRequest<Response> {
      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** SCIM 1-offset based index for pagination. */
        public var startIndex: Int?

        /** A SCIM filter expression. The only operator currently supported is `eq`. */
        public var filter: String?

        /** The maximum number of results the query should return, maximum of 100. */
        public var count: Int?

        public init(organizationSlug: String, startIndex: Int? = nil, filter: String? = nil, count: Int? = nil) {
          self.organizationSlug = organizationSlug
          self.startIndex = startIndex
          self.filter = filter
          self.count = count
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: ListAnOrganizationsMembers.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, startIndex: Int? = nil, filter: String? = nil, count: Int? = nil) {
        let options = Options(organizationSlug: organizationSlug, startIndex: startIndex, filter: filter, count: count)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(self.options.organizationSlug)")
      }

      override public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let startIndex = options.startIndex {
          params["startIndex"] = startIndex
        }
        if let filter = options.filter {
          params["filter"] = filter
        }
        if let count = options.count {
          params["count"] = count
        }
        return params
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      /** Returns a paginated list of members bound to a organization with a SCIM Users GET Request. */
      public struct Status200: Model {
        public var totalResults: Int

        public var itemsPerPage: Int

        public var startIndex: Int

        public var resources: [Resources]

        public var schemas: [String]?

        /** Returns a paginated list of members bound to a organization with a SCIM Users GET Request. */
        public struct Resources: Model {
          public var schemas: [String]

          public var id: String

          public var active: Bool

          public var userName: String

          public var name: Name

          public var meta: Meta

          public var emails: [Emails]

          /** Returns a paginated list of members bound to a organization with a SCIM Users GET Request. */
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

          /** Returns a paginated list of members bound to a organization with a SCIM Users GET Request. */
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

          /** Returns a paginated list of members bound to a organization with a SCIM Users GET Request. */
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

        public init(totalResults: Int, itemsPerPage: Int, startIndex: Int, resources: [Resources], schemas: [String]? = nil) {
          self.totalResults = totalResults
          self.itemsPerPage = itemsPerPage
          self.startIndex = startIndex
          self.resources = resources
          self.schemas = schemas
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          totalResults = try container.decode("totalResults")
          itemsPerPage = try container.decode("itemsPerPage")
          startIndex = try container.decode("startIndex")
          resources = try container.decodeArray("Resources")
          schemas = try container.decodeArrayIfPresent("schemas")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(totalResults, forKey: "totalResults")
          try container.encode(itemsPerPage, forKey: "itemsPerPage")
          try container.encode(startIndex, forKey: "startIndex")
          try container.encode(resources, forKey: "Resources")
          try container.encodeIfPresent(schemas, forKey: "schemas")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Permission Denied */
      case status401

      /** Forbidden */
      case status403

      /** Not Found */
      case status404

      public var success: Status200? {
        switch self {
        case let .status200(response): return response
        default: return nil
        }
      }

      public var response: Any {
        switch self {
        case let .status200(response): return response
        default: return ()
        }
      }

      public var statusCode: Int {
        switch self {
        case .status200: return 200
        case .status401: return 401
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status401: return false
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
        case 401: self = .status401
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
