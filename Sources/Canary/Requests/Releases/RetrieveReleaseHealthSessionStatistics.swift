import Foundation
import Prch

public extension Releases {
  /** Returns a time series of release health session statistics for projects bound to an organization.
   The interval and date range are subject to certain restrictions and rounding rules.
   The date range is rounded to align with the interval, and is rounded to at least one hour. The interval can at most be one day and at least one hour currently. It has to cleanly divide one day, for rounding reasons. */
  enum RetrieveReleaseHealthSessionStatistics {
    public static let service = Service<Response>(id: "Retrieve Release Health Session Statistics", tag: "Releases", method: "GET", path: "/api/0/organizations/{organization_slug}/sessions/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["org: read"])])

    public struct Request: ServiceRequest {
      public typealias ResponseType = Response

      public var service: Service<Response> {
        RetrieveReleaseHealthSessionStatistics.service
      }

      public struct Options {
        /** The slug of the organization. */
        public var organizationSlug: String

        /** The ID of the projects to filter by.
         Use `-1` to include all accessible projects. */
        public var project: [Int]

        /** The list of fields to query.
         The available fields are `sum(session)`, `count_unique(user)`, and the following functions applied to the `session.duration` metric: `avg`, `p50`, `p75`, `p90`, `p95`, `p99` and `max`.
         For example, `p99(session.duration)`. */
        public var field: [String]

        /** The name of environments to filter by. */
        public var environment: [String]?

        /** The list of properties to group by.
         The available groupBy conditions are `project`, `release`, `environment` and `session.status`. */
        public var groupBy: [String]?

        /** A free-form query that is applied as a filter.
         An example query could be `release:"1.1.0" or release:"1.2.0"`. */
        public var query: String?

        /** This defines the range of the time series, relative to now.
         The range is given in a `"<number><unit>"` format.
         For example `1d` for a one day range. Possible units are `m` for minutes, `h` for hours, `d` for days and `w` for weeks.
         It defaults to `90d`. */
        public var statsPeriod: String?

        /** This is the resolution of the time series, given in the same format as `statsPeriod`.
         The default resolution is `1h` and the minimum resolution is currently restricted to `1h` as well.
         Intervals larger than `1d` are not supported, and the interval has to cleanly divide one day. */
        public var interval: String?

        /** This defines the start of the time series range, in the same format as the `interval`, relative to now. */
        public var statsPeriodStart: String?

        /** This defines the end of the time series range, in the same format as the `interval`, relative to now. */
        public var statsPeriodEnd: String?

        /** This defines the start of the time series range as an explicit Date. */
        public var start: Date?

        /** This defines the inclusive end of the time series range as an explicit Date. */
        public var end: Date?

        public init(organizationSlug: String, project: [Int], field: [String], environment: [String]? = nil, groupBy: [String]? = nil, query: String? = nil, statsPeriod: String? = nil, interval: String? = nil, statsPeriodStart: String? = nil, statsPeriodEnd: String? = nil, start: Date? = nil, end: Date? = nil) {
          self.organizationSlug = organizationSlug
          self.project = project
          self.field = field
          self.environment = environment
          self.groupBy = groupBy
          self.query = query
          self.statsPeriod = statsPeriod
          self.interval = interval
          self.statsPeriodStart = statsPeriodStart
          self.statsPeriodEnd = statsPeriodEnd
          self.start = start
          self.end = end
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
      }

      /// convenience initialiser so an Option doesn't have to be created
      public init(organizationSlug: String, project: [Int], field: [String], environment: [String]? = nil, groupBy: [String]? = nil, query: String? = nil, statsPeriod: String? = nil, interval: String? = nil, statsPeriodStart: String? = nil, statsPeriodEnd: String? = nil, start: Date? = nil, end: Date? = nil) {
        let options = Options(organizationSlug: organizationSlug, project: project, field: field, environment: environment, groupBy: groupBy, query: query, statsPeriod: statsPeriod, interval: interval, statsPeriodStart: statsPeriodStart, statsPeriodEnd: statsPeriodEnd, start: start, end: end)
        self.init(options: options)
      }

      public var path: String {
        service.path.replacingOccurrences(of: "{" + "organization_slug" + "}", with: "\(options.organizationSlug)")
      }

      public var queryParameters: [String: Any] {
        var params: [String: Any] = [:]
        params["project"] = options.project.map { String(describing: $0) }.joined(separator: ",")
        params["field"] = options.field.joined(separator: ",")
        if let environment = options.environment?.joined(separator: ",") {
          params["environment"] = environment
        }
        if let groupBy = options.groupBy?.joined(separator: ",") {
          params["groupBy"] = groupBy
        }
        if let query = options.query {
          params["query"] = query
        }
        if let statsPeriod = options.statsPeriod {
          params["statsPeriod"] = statsPeriod
        }
        if let interval = options.interval {
          params["interval"] = interval
        }
        if let statsPeriodStart = options.statsPeriodStart {
          params["statsPeriodStart"] = statsPeriodStart
        }
        if let statsPeriodEnd = options.statsPeriodEnd {
          params["statsPeriodEnd"] = statsPeriodEnd
        }
        if let start = options.start?.encode(with: CanaryAPI.dateEncodingFormatter) {
          params["start"] = start
        }
        if let end = options.end?.encode(with: CanaryAPI.dateEncodingFormatter) {
          params["end"] = end
        }
        return params
      }
    }

    public enum Response: Prch.Response {
      public var response: ClientResult<Status200, Status400?> {
        switch self {
        case let .status200(response):
          return .success(response)
        case let .status400(response):
          return .defaultResponse(400, response)
        default:
          return .defaultResponse(statusCode, nil)
        }
      }

      public typealias FailureType = Status400?

      public typealias APIType = CanaryAPI
      /** Returns a time series of release health session statistics for projects bound to an organization.
       The interval and date range are subject to certain restrictions and rounding rules.
       The date range is rounded to align with the interval, and is rounded to at least one hour. The interval can at most be one day and at least one hour currently. It has to cleanly divide one day, for rounding reasons. */
      public struct Status200: Model {
        /** The start time of the data being returned. */
        public var start: Date

        /** The exclusive end time of the data being returned. */
        public var end: Date

        /** The time slices of the timeseries data given in the `groups[].series` field. */
        public var intervals: [Date]

        public var groups: [Groups]

        /** A grouped result, as requested by the `groupBy` request parameter. */
        public struct Groups: Model {
          /** These are key/value pairs, the key being the requested `groupBy` property with its corresponding value. */
          public var by: [String: AnyCodable]

          /** These are key/value pairs, the key being the requested `field`, and the value the corresponding total over the requested time frame. */
          public var totals: [String: AnyCodable]

          /** These are key/value pairs, the key being the requested `field`, and the value is an array of aggregated values. The array corresponds to the times given in the `intervals` array. */
          public var series: [String: AnyCodable]

          public init(by: [String: AnyCodable], totals: [String: AnyCodable], series: [String: AnyCodable]) {
            self.by = by
            self.totals = totals
            self.series = series
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            by = try container.decodeAny("by")
            totals = try container.decodeAny("totals")
            series = try container.decodeAny("series")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeAny(by, forKey: "by")
            try container.encodeAny(totals, forKey: "totals")
            try container.encodeAny(series, forKey: "series")
          }
        }

        public init(start: Date, end: Date, intervals: [Date], groups: [Groups]) {
          self.start = start
          self.end = end
          self.intervals = intervals
          self.groups = groups
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          start = try container.decode("start")
          end = try container.decode("end")
          intervals = try container.decodeArray("intervals")
          groups = try container.decodeArray("groups")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(start, forKey: "start")
          try container.encode(end, forKey: "end")
          try container.encode(intervals, forKey: "intervals")
          try container.encode(groups, forKey: "groups")
        }
      }

      /** Returns a time series of release health session statistics for projects bound to an organization.
       The interval and date range are subject to certain restrictions and rounding rules.
       The date range is rounded to align with the interval, and is rounded to at least one hour. The interval can at most be one day and at least one hour currently. It has to cleanly divide one day, for rounding reasons. */
      public struct Status400: Model {
        public var detail: String

        public init(detail: String) {
          self.detail = detail
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          detail = try container.decode("detail")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(detail, forKey: "detail")
        }
      }

      public typealias SuccessType = Status200

      /** Time-series Session Statistics. */
      case status200(Status200)

      /** Wrong Parameters */
      case status400(Status400)

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

      public var failure: Status400? {
        switch self {
        case let .status400(response): return response
        default: return nil
        }
      }

//      /// either success or failure value. Success is anything in the 200..<300 status code range
//      public var responseResult: APIResponseResult<Status200, Status400> {
//        if let successValue = success {
//          return .success(successValue)
//        } else if let failureValue = failure {
//          return .failure(failureValue)
//        } else {
//          fatalError("Response does not have success or failure response")
//        }
//      }

      public var statusCode: Int {
        switch self {
        case .status200: return 200
        case .status400: return 400
        case .status401: return 401
        case .status403: return 403
        }
      }

      public var successful: Bool {
        switch self {
        case .status200: return true
        case .status400: return false
        case .status401: return false
        case .status403: return false
        }
      }

      public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
        switch statusCode {
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
        case 400: self = try .status400(decoder.decode(Status400.self, from: data))
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
