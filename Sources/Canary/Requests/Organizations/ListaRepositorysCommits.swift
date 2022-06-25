import Foundation
import Prch

public extension Organizations {
  /** Return a list of commits for a given repository. */
  enum ListaRepositorysCommits {
    public static let service = Service<Response>(id: "List a Repository's Commits", tag: "Organizations", method: "GET", path: "/api/0/organizations/{organization_slug}/repos/{repo_id}/commits/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["org: read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ListaRepositorysCommits.service
      }

      public struct Options {
        /** The organization short name. */
        public var organizationSlug: String

        /** The repository ID. */
        public var repoId: String

        public init(organizationSlug: String, repoId: String) {
          self.organizationSlug = organizationSlug
          self.repoId = repoId
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, repoId: String) {
        let options = Options(organizationSlug: organizationSlug, repoId: repoId)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "repo_id" + "}", with: "\(options.repoId)")
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<[Status200], Void> {
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
      /** Return a list of commits for a given repository. */
      public struct Status200: Model {
        public var dateCreated: Date

        public var id: String

        public var message: String?

        public init(dateCreated: Date, id: String, message: String?) {
          self.dateCreated = dateCreated
          self.id = id
          self.message = message
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          dateCreated = try container.decode("dateCreated")
          id = try container.decode("id")
          message = try container.decodeIfPresent("message")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(id, forKey: "id")
          try container.encodeIfPresent(message, forKey: "message")
        }
      }

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

      /** Unauthorized */
      case status401

      /** Forbidden */
      case status403

      /** Not Found */
      case status404

      public var success: [Status200]? {
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
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
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
