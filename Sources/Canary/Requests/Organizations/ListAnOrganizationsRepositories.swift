import Foundation
import Prch

public extension Organizations {
  /** Return a list of version control repositories for a given organization. */
  enum ListAnOrganizationsRepositories {
    public static let service = APIService<Response>(id: "List an Organization's Repositories", tag: "Organizations", method: "GET", path: "/api/0/organizations/{organization_slug}/repos/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["org: read"])])

    public final class Request: APIRequest<Response> {
      public struct Options {
        /** The organization short name. */
        public var organizationSlug: String

        public init(organizationSlug: String) {
          self.organizationSlug = organizationSlug
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: ListAnOrganizationsRepositories.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String) {
        let options = Options(organizationSlug: organizationSlug)
        self.init(options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)")
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      /** Return a list of version control repositories for a given organization. */
      public struct Status200: Model {
        public var dateCreated: String

        public var id: String

        public var name: String

        public init(dateCreated: String, id: String, name: String) {
          self.dateCreated = dateCreated
          self.id = id
          self.name = name
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          dateCreated = try container.decode("dateCreated")
          id = try container.decode("id")
          name = try container.decode("name")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(id, forKey: "id")
          try container.encode(name, forKey: "name")
        }
      }

      public typealias SuccessType = [Status200]

      /** Success */
      case status200([Status200])

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
        case .status404: return 404
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status403: return false
        case .status404: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode([Status200].self, from: data))
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
