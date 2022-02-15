import Foundation
import Prch

public extension Projects {
  /** Submit and associate user feedback with an issue.
   Feedback must be received by the server no more than 30 minutes after the event was saved.
   Additionally, within 5 minutes of submitting feedback it may also be overwritten. This is useful in situations where you may need to retry sending a request due to network failures.
   If feedback is rejected due to a mutability threshold, a 409 status code will be returned.
   Note: Feedback may be submitted with DSN authentication (see auth documentation). */
  enum SubmitUserFeedback {
    public static let service = APIService<Response>(id: "Submit User Feedback", tag: "Projects", method: "POST", path: "/api/0/projects/{organization_slug}/{project_slug}/user-feedback/", hasBody: true, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:write"]), SecurityRequirement(type: "dsn", scopes: [])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      /** Submit and associate user feedback with an issue.
       Feedback must be received by the server no more than 30 minutes after the event was saved.
       Additionally, within 5 minutes of submitting feedback it may also be overwritten. This is useful in situations where you may need to retry sending a request due to network failures.
       If feedback is rejected due to a mutability threshold, a 409 status code will be returned.
       Note: Feedback may be submitted with DSN authentication (see auth documentation). */
      public struct Body: Model {
        /** The event ID. This can be retrieved from the [beforeSend callback](https://docs.sentry.io/platforms/javascript/configuration/filtering/#using-beforesend). */
        public var eventId: String

        /** User's name. */
        public var name: String

        /** User's email address. */
        public var email: String

        /** Comments supplied by user. */
        public var comments: String

        public init(eventId: String, name: String, email: String, comments: String) {
          self.eventId = eventId
          self.name = name
          self.email = email
          self.comments = comments
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          eventId = try container.decode("event_id")
          name = try container.decode("name")
          email = try container.decode("email")
          comments = try container.decode("comments")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(eventId, forKey: "event_id")
          try container.encode(name, forKey: "name")
          try container.encode(email, forKey: "email")
          try container.encode(comments, forKey: "comments")
        }
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

      public var body: Body?

      public init(body: Body?, options: Options, encoder: RequestEncoder? = nil) {
        self.body = body
        self.options = options
        super.init(service: SubmitUserFeedback.service) { defaultEncoder in
          try (encoder ?? defaultEncoder).encode(body)
        }
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, projectSlug: String, body: Body? = nil) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug)
        self.init(body: body, options: options)
      }

      override public var path: String {
        super.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)").replacingOccurrences(of: "{" + "project_slug" + "}", with: "\(options.projectSlug)")
      }
    }

    public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
      public var failure: FailureType? {
        successful ? nil : ()
      }

      public typealias FailureType = Void

      public typealias APIType = CanaryAPI
      /** Submit and associate user feedback with an issue.
       Feedback must be received by the server no more than 30 minutes after the event was saved.
       Additionally, within 5 minutes of submitting feedback it may also be overwritten. This is useful in situations where you may need to retry sending a request due to network failures.
       If feedback is rejected due to a mutability threshold, a 409 status code will be returned.
       Note: Feedback may be submitted with DSN authentication (see auth documentation). */
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

        /** Submit and associate user feedback with an issue.
         Feedback must be received by the server no more than 30 minutes after the event was saved.
         Additionally, within 5 minutes of submitting feedback it may also be overwritten. This is useful in situations where you may need to retry sending a request due to network failures.
         If feedback is rejected due to a mutability threshold, a 409 status code will be returned.
         Note: Feedback may be submitted with DSN authentication (see auth documentation). */
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

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Bad Input */
      case status400

      /** Forbidden */
      case status403

      /** The requested resource does not exist */
      case status404

      /** Conflict */
      case status409

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
        case .status400: return 400
        case .status403: return 403
        case .status404: return 404
        case .status409: return 409
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status400: return false
        case .status403: return false
        case .status404: return false
        case .status409: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
        case 400: self = .status400
        case 403: self = .status403
        case 404: self = .status404
        case 409: self = .status409
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
