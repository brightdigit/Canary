import Foundation
import Prch

public extension Projects {
  /** Create a new client key bound to a project.  The key's secret and public key are generated by the server. */
  enum CreateaNewClientKey {
    public static let service = Service<Response>(id: "Create a New Client Key", tag: "Projects", method: "POST", path: "/api/0/projects/{organization_slug}/{project_slug}/keys/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:write"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        CreateaNewClientKey.service
      }

      /** Create a new client key bound to a project.  The key's secret and public key are generated by the server. */
      public struct Body: Model {
        /** The name for the new key. */
        public var name: String

        public init(name: String) {
          self.name = name
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          name = try container.decode("name")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(name, forKey: "name")
        }
      }

      public struct Options {
        /** The slug of the organization the client keys belong to. */
        public var organizationSlug: String

        /** The slug of the project the client keys belong to. */
        public var projectSlug: String

        public init(organizationSlug: String, projectSlug: String) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
        }
      }

      public var options: Options

      public var body: Body

      public init(body: Body, options: Options, encoder _: RequestEncoder? = nil) {
        self.body = body
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, projectSlug: String, body: Body) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug)
        self.init(body: body, options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)")
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
      /** Create a new client key bound to a project.  The key's secret and public key are generated by the server. */
      public struct Status201: Model {
        public var browserSdk: BrowserSdk

        public var browserSdkVersion: String

        public var dateCreated: String

        public var dsn: Dsn

        public var id: String

        public var isActive: Bool

        public var label: String

        public var name: String

        public var projectId: Int

        public var `public`: String

        public var rateLimit: String?

        public var secret: String

        /** Create a new client key bound to a project.  The key's secret and public key are generated by the server. */
        public struct BrowserSdk: Model {
          public var choices: [[String]]?

          public init(choices: [[String]]? = nil) {
            self.choices = choices
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            choices = try container.decodeArrayIfPresent("choices")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(choices, forKey: "choices")
          }
        }

        /** Create a new client key bound to a project.  The key's secret and public key are generated by the server. */
        public struct Dsn: Model {
          public var cdn: String

          public var csp: String

          public var minidump: String

          public var `public`: String

          public var secret: String

          public var security: String

          public init(cdn: String, csp: String, minidump: String, public: String, secret: String, security: String) {
            self.cdn = cdn
            self.csp = csp
            self.minidump = minidump
            self.public = `public`
            self.secret = secret
            self.security = security
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            cdn = try container.decode("cdn")
            csp = try container.decode("csp")
            minidump = try container.decode("minidump")
            `public` = try container.decode("public")
            secret = try container.decode("secret")
            security = try container.decode("security")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(cdn, forKey: "cdn")
            try container.encode(csp, forKey: "csp")
            try container.encode(minidump, forKey: "minidump")
            try container.encode(`public`, forKey: "public")
            try container.encode(secret, forKey: "secret")
            try container.encode(security, forKey: "security")
          }
        }

        public init(browserSdk: BrowserSdk, browserSdkVersion: String, dateCreated: String, dsn: Dsn, id: String, isActive: Bool, label: String, name: String, projectId: Int, public: String, rateLimit: String?, secret: String) {
          self.browserSdk = browserSdk
          self.browserSdkVersion = browserSdkVersion
          self.dateCreated = dateCreated
          self.dsn = dsn
          self.id = id
          self.isActive = isActive
          self.label = label
          self.name = name
          self.projectId = projectId
          self.public = `public`
          self.rateLimit = rateLimit
          self.secret = secret
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          browserSdk = try container.decode("browserSdk")
          browserSdkVersion = try container.decode("browserSdkVersion")
          dateCreated = try container.decode("dateCreated")
          dsn = try container.decode("dsn")
          id = try container.decode("id")
          isActive = try container.decode("isActive")
          label = try container.decode("label")
          name = try container.decode("name")
          projectId = try container.decode("projectId")
          `public` = try container.decode("public")
          rateLimit = try container.decodeIfPresent("rateLimit")
          secret = try container.decode("secret")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(browserSdk, forKey: "browserSdk")
          try container.encode(browserSdkVersion, forKey: "browserSdkVersion")
          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(dsn, forKey: "dsn")
          try container.encode(id, forKey: "id")
          try container.encode(isActive, forKey: "isActive")
          try container.encode(label, forKey: "label")
          try container.encode(name, forKey: "name")
          try container.encode(projectId, forKey: "projectId")
          try container.encode(`public`, forKey: "public")
          try container.encodeIfPresent(rateLimit, forKey: "rateLimit")
          try container.encode(secret, forKey: "secret")
        }
      }

      public typealias SuccessType = Status201

      /** Success */
      case status201(Status201)

      /** Forbidden */
      case status403

      /** The requested resource does not exist */
      case status404

      public var success: Status201? {
        switch self {
        case let .status201(response): return response
        default: return nil
        }
      }

      public var statusCode: Int {
        switch self {
        case .status201: return 201
        case .status403: return 403
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status201: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 201: self = try .status201(decoder.decode(Status201.self, from: data))
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
