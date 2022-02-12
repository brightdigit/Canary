import Foundation
import Prch

public extension Projects {
  /** Return a list of client keys bound to a project. */
  enum ListaProjectsClientKeys {
    public static let service = APIService<Response>(id: "List a Project's Client Keys", tag: "Projects", method: "GET", path: "/api/0/projects/{organization_slug}/{project_slug}/keys/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:read"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      public struct Options {
        /** The slug of the organization the client keys belong to. */
        public var organizationSlug: String

        /** The slug of the project the client keys belong to. */
        public var projectSlug: String

        /** A pointer to the last object fetched and its' sort order; used to retrieve the next or previous results. */
        public var cursor: String?

        public init(organizationSlug: String, projectSlug: String, cursor: String? = nil) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
          self.cursor = cursor
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: ListaProjectsClientKeys.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, projectSlug: String, cursor: String? = nil) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug, cursor: cursor)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(self.options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(self.options.projectSlug)")
      }

      override public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        if let cursor = options.cursor {
          params["cursor"] = cursor
        }
        return params
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Return a list of client keys bound to a project. */
      public struct Status200: Model {
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

        /** Return a list of client keys bound to a project. */
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

        /** Return a list of client keys bound to a project. */
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

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** Forbidden */
      case status403

      public var success: [Status200]? {
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
        case .status403: return 403
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status403: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
        case 403: self = .status403
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
