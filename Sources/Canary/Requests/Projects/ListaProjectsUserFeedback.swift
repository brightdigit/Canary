import Foundation
import Prch

public extension Projects {
  /** Return a list of user feedback items within this project. */
  enum ListaProjectsUserFeedback {
    public static let service = Service<Response>(id: "List a Project's User Feedback", tag: "Projects", method: "GET", path: "/api/0/projects/{organization_slug}/{project_slug}/user-feedback/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        ListaProjectsUserFeedback.service
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** The slug of the project. */
        public var projectSlug: String

        public init(organizationSlug: String, projectSlug: String) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, projectSlug: String) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)")
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
      /** Return a list of user feedback items within this project. */
      public struct Status200: Model {
        public var comments: String

        public var dateCreated: String

        public var email: String

        public var event: Event

        public var eventID: String

        public var id: String

        public var issue: [String: AnyCodable]?

        public var name: String

        public var user: [String: AnyCodable]?

        /** Return a list of user feedback items within this project. */
        public struct Event: Model {
          public var eventID: String?

          public var id: String?

          public init(eventID: String? = nil, id: String? = nil) {
            self.eventID = eventID
            self.id = id
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            eventID = try container.decodeIfPresent("eventID")
            id = try container.decodeIfPresent("id")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(eventID, forKey: "eventID")
            try container.encodeIfPresent(id, forKey: "id")
          }
        }

        public init(comments: String, dateCreated: String, email: String, event: Event, eventID: String, id: String, issue: [String: AnyCodable]?, name: String, user: [String: AnyCodable]?) {
          self.comments = comments
          self.dateCreated = dateCreated
          self.email = email
          self.event = event
          self.eventID = eventID
          self.id = id
          self.issue = issue
          self.name = name
          self.user = user
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          comments = try container.decode("comments")
          dateCreated = try container.decode("dateCreated")
          email = try container.decode("email")
          event = try container.decode("event")
          eventID = try container.decode("eventID")
          id = try container.decode("id")
          issue = try container.decodeAnyIfPresent("issue")
          name = try container.decode("name")
          user = try container.decodeAnyIfPresent("user")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(comments, forKey: "comments")
          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encode(email, forKey: "email")
          try container.encode(event, forKey: "event")
          try container.encode(eventID, forKey: "eventID")
          try container.encode(id, forKey: "id")
          try container.encodeAnyIfPresent(issue, forKey: "issue")
          try container.encode(name, forKey: "name")
          try container.encodeAnyIfPresent(user, forKey: "user")
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
