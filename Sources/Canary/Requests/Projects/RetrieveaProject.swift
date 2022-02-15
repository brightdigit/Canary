import Foundation
import Prch

public extension Projects {
  /** Return details on an individual project. */
  enum RetrieveaProject {
    public static let service = APIService<Response>(id: "Retrieve a Project", tag: "Projects", method: "GET", path: "/api/0/projects/{organization_slug}/{project_slug}/", hasBody: false, securityRequirements: [SecurityRequirement(type: "auth_token", scopes: ["project:read"])])

    public final class Request: APIRequest<Response, CanaryAPI> {
      public struct Options {
        /** The slug of the organization the project belongs to. */
        public var organizationSlug: String

        /** The slug of the project to retrieve. */
        public var projectSlug: String

        public init(organizationSlug: String, projectSlug: String) {
          self.organizationSlug = organizationSlug
          self.projectSlug = projectSlug
        }
      }

      public var options: Options

      public init(options: Options) {
        self.options = options
        super.init(service: RetrieveaProject.service)
      }

      /// convenience initialiser so an Option doesn't have to be created
      public convenience init(organizationSlug: String, projectSlug: String) {
        let options = Options(organizationSlug: organizationSlug, projectSlug: projectSlug)
        self.init(options: options)
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
      /** Return details on an individual project. */
      public struct Status200: Model {
        public var allowedDomains: [String]

        public var avatar: Avatar

        public var color: String

        public var dataScrubber: Bool

        public var dataScrubberDefaults: Bool

        public var dateCreated: String

        public var defaultEnvironment: String?

        public var digestsMaxDelay: Int

        public var digestsMinDelay: Int

        public var features: [String]

        public var firstEvent: String?

        public var hasAccess: Bool

        public var id: String

        public var isBookmarked: Bool

        public var isInternal: Bool

        public var isMember: Bool

        public var isPublic: Bool

        public var latestRelease: LatestRelease?

        public var name: String

        public var options: Options

        public var organization: Organization

        public var platform: String?

        public var platforms: [String]

        public var processingIssues: Int

        public var relayPiiConfig: String?

        public var resolveAge: Int

        public var safeFields: [String]

        public var scrapeJavaScript: Bool

        public var scrubIPAddresses: Bool

        public var securityToken: String

        public var securityTokenHeader: String?

        public var sensitiveFields: [String]

        public var slug: String

        public var status: String

        public var storeCrashReports: Bool?

        public var subjectPrefix: String

        public var subjectTemplate: String

        public var team: Team

        public var teams: [Teams]

        public var verifySSL: Bool

        public var plugins: [Plugins]?

        /** Return details on an individual project. */
        public struct Avatar: Model {
          public var avatarType: String?

          public var avatarUuid: String?

          public init(avatarType: String? = nil, avatarUuid: String? = nil) {
            self.avatarType = avatarType
            self.avatarUuid = avatarUuid
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            avatarType = try container.decodeIfPresent("avatarType")
            avatarUuid = try container.decodeIfPresent("avatarUuid")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(avatarType, forKey: "avatarType")
            try container.encodeIfPresent(avatarUuid, forKey: "avatarUuid")
          }
        }

        /** Return details on an individual project. */
        public struct LatestRelease: Model {
          public var authors: [Authors]

          public var commitCount: Int

          public var data: [String: AnyCodable]

          public var dateCreated: String

          public var dateReleased: String?

          public var deployCount: Int

          public var firstEvent: String?

          public var lastCommit: [String: AnyCodable]?

          public var lastDeploy: [String: AnyCodable]?

          public var lastEvent: String?

          public var newGroups: Int

          public var owner: String?

          public var projects: [Projects]

          public var ref: String?

          public var shortVersion: String

          public var url: String?

          public var version: String

          /** Return details on an individual project. */
          public struct Authors: Model {
            public var email: String?

            public var name: String?

            public init(email: String? = nil, name: String? = nil) {
              self.email = email
              self.name = name
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              email = try container.decodeIfPresent("email")
              name = try container.decodeIfPresent("name")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(email, forKey: "email")
              try container.encodeIfPresent(name, forKey: "name")
            }
          }

          /** Return details on an individual project. */
          public struct Projects: Model {
            public var name: String?

            public var slug: String?

            public init(name: String? = nil, slug: String? = nil) {
              self.name = name
              self.slug = slug
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              name = try container.decodeIfPresent("name")
              slug = try container.decodeIfPresent("slug")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(name, forKey: "name")
              try container.encodeIfPresent(slug, forKey: "slug")
            }
          }

          public init(authors: [Authors], commitCount: Int, data: [String: AnyCodable], dateCreated: String, dateReleased: String?, deployCount: Int, firstEvent: String?, lastCommit: [String: AnyCodable]?, lastDeploy: [String: AnyCodable]?, lastEvent: String?, newGroups: Int, owner: String?, projects: [Projects], ref: String?, shortVersion: String, url: String?, version: String) {
            self.authors = authors
            self.commitCount = commitCount
            self.data = data
            self.dateCreated = dateCreated
            self.dateReleased = dateReleased
            self.deployCount = deployCount
            self.firstEvent = firstEvent
            self.lastCommit = lastCommit
            self.lastDeploy = lastDeploy
            self.lastEvent = lastEvent
            self.newGroups = newGroups
            self.owner = owner
            self.projects = projects
            self.ref = ref
            self.shortVersion = shortVersion
            self.url = url
            self.version = version
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            authors = try container.decodeArray("authors")
            commitCount = try container.decode("commitCount")
            data = try container.decodeAny("data")
            dateCreated = try container.decode("dateCreated")
            dateReleased = try container.decodeIfPresent("dateReleased")
            deployCount = try container.decode("deployCount")
            firstEvent = try container.decodeIfPresent("firstEvent")
            lastCommit = try container.decodeAnyIfPresent("lastCommit")
            lastDeploy = try container.decodeAnyIfPresent("lastDeploy")
            lastEvent = try container.decodeIfPresent("lastEvent")
            newGroups = try container.decode("newGroups")
            owner = try container.decodeIfPresent("owner")
            projects = try container.decodeArray("projects")
            ref = try container.decodeIfPresent("ref")
            shortVersion = try container.decode("shortVersion")
            url = try container.decodeIfPresent("url")
            version = try container.decode("version")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(authors, forKey: "authors")
            try container.encode(commitCount, forKey: "commitCount")
            try container.encodeAny(data, forKey: "data")
            try container.encode(dateCreated, forKey: "dateCreated")
            try container.encodeIfPresent(dateReleased, forKey: "dateReleased")
            try container.encode(deployCount, forKey: "deployCount")
            try container.encodeIfPresent(firstEvent, forKey: "firstEvent")
            try container.encodeAnyIfPresent(lastCommit, forKey: "lastCommit")
            try container.encodeAnyIfPresent(lastDeploy, forKey: "lastDeploy")
            try container.encodeIfPresent(lastEvent, forKey: "lastEvent")
            try container.encode(newGroups, forKey: "newGroups")
            try container.encodeIfPresent(owner, forKey: "owner")
            try container.encode(projects, forKey: "projects")
            try container.encodeIfPresent(ref, forKey: "ref")
            try container.encode(shortVersion, forKey: "shortVersion")
            try container.encodeIfPresent(url, forKey: "url")
            try container.encode(version, forKey: "version")
          }
        }

        /** Return details on an individual project. */
        public struct Options: Model {
          public var feedbackbranding: Bool?

          public var filtersblacklistedIps: String?

          public var filterserrorMessages: String?

          public var filtersreleases: String?

          public var sentrycspIgnoredSources: String?

          public var sentrycspIgnoredSourcesDefaults: Bool?

          public var sentryreprocessingActive: Bool?

          public init(feedbackbranding: Bool? = nil, filtersblacklistedIps: String? = nil, filterserrorMessages: String? = nil, filtersreleases: String? = nil, sentrycspIgnoredSources: String? = nil, sentrycspIgnoredSourcesDefaults: Bool? = nil, sentryreprocessingActive: Bool? = nil) {
            self.feedbackbranding = feedbackbranding
            self.filtersblacklistedIps = filtersblacklistedIps
            self.filterserrorMessages = filterserrorMessages
            self.filtersreleases = filtersreleases
            self.sentrycspIgnoredSources = sentrycspIgnoredSources
            self.sentrycspIgnoredSourcesDefaults = sentrycspIgnoredSourcesDefaults
            self.sentryreprocessingActive = sentryreprocessingActive
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            feedbackbranding = try container.decodeIfPresent("feedback:branding")
            filtersblacklistedIps = try container.decodeIfPresent("filters:blacklisted_ips")
            filterserrorMessages = try container.decodeIfPresent("filters:error_messages")
            filtersreleases = try container.decodeIfPresent("filters:releases")
            sentrycspIgnoredSources = try container.decodeIfPresent("sentry:csp_ignored_sources")
            sentrycspIgnoredSourcesDefaults = try container.decodeIfPresent("sentry:csp_ignored_sources_defaults")
            sentryreprocessingActive = try container.decodeIfPresent("sentry:reprocessing_active")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encodeIfPresent(feedbackbranding, forKey: "feedback:branding")
            try container.encodeIfPresent(filtersblacklistedIps, forKey: "filters:blacklisted_ips")
            try container.encodeIfPresent(filterserrorMessages, forKey: "filters:error_messages")
            try container.encodeIfPresent(filtersreleases, forKey: "filters:releases")
            try container.encodeIfPresent(sentrycspIgnoredSources, forKey: "sentry:csp_ignored_sources")
            try container.encodeIfPresent(sentrycspIgnoredSourcesDefaults, forKey: "sentry:csp_ignored_sources_defaults")
            try container.encodeIfPresent(sentryreprocessingActive, forKey: "sentry:reprocessing_active")
          }
        }

        /** Return details on an individual project. */
        public struct Organization: Model {
          public var avatar: Avatar

          public var dateCreated: DateTime

          public var id: String

          public var isEarlyAdopter: Bool

          public var name: String

          public var require2FA: Bool

          public var slug: String

          public var status: Status

          /** Return details on an individual project. */
          public struct Avatar: Model {
            public var avatarType: String?

            public var avatarUuid: String?

            public init(avatarType: String? = nil, avatarUuid: String? = nil) {
              self.avatarType = avatarType
              self.avatarUuid = avatarUuid
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              avatarType = try container.decodeIfPresent("avatarType")
              avatarUuid = try container.decodeIfPresent("avatarUuid")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(avatarType, forKey: "avatarType")
              try container.encodeIfPresent(avatarUuid, forKey: "avatarUuid")
            }
          }

          /** Return details on an individual project. */
          public struct Status: Model {
            public var id: String

            public var name: String

            public init(id: String, name: String) {
              self.id = id
              self.name = name
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              id = try container.decode("id")
              name = try container.decode("name")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encode(id, forKey: "id")
              try container.encode(name, forKey: "name")
            }
          }

          public init(avatar: Avatar, dateCreated: DateTime, id: String, isEarlyAdopter: Bool, name: String, require2FA: Bool, slug: String, status: Status) {
            self.avatar = avatar
            self.dateCreated = dateCreated
            self.id = id
            self.isEarlyAdopter = isEarlyAdopter
            self.name = name
            self.require2FA = require2FA
            self.slug = slug
            self.status = status
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            avatar = try container.decode("avatar")
            dateCreated = try container.decode("dateCreated")
            id = try container.decode("id")
            isEarlyAdopter = try container.decode("isEarlyAdopter")
            name = try container.decode("name")
            require2FA = try container.decode("require2FA")
            slug = try container.decode("slug")
            status = try container.decode("status")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(avatar, forKey: "avatar")
            try container.encode(dateCreated, forKey: "dateCreated")
            try container.encode(id, forKey: "id")
            try container.encode(isEarlyAdopter, forKey: "isEarlyAdopter")
            try container.encode(name, forKey: "name")
            try container.encode(require2FA, forKey: "require2FA")
            try container.encode(slug, forKey: "slug")
            try container.encode(status, forKey: "status")
          }
        }

        /** Return details on an individual project. */
        public struct Team: Model {
          public var id: String

          public var name: String

          public var slug: String

          public init(id: String, name: String, slug: String) {
            self.id = id
            self.name = name
            self.slug = slug
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            id = try container.decode("id")
            name = try container.decode("name")
            slug = try container.decode("slug")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(id, forKey: "id")
            try container.encode(name, forKey: "name")
            try container.encode(slug, forKey: "slug")
          }
        }

        /** Return details on an individual project. */
        public struct Teams: Model {
          public var id: String

          public var name: String

          public var slug: String

          public init(id: String, name: String, slug: String) {
            self.id = id
            self.name = name
            self.slug = slug
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            id = try container.decode("id")
            name = try container.decode("name")
            slug = try container.decode("slug")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(id, forKey: "id")
            try container.encode(name, forKey: "name")
            try container.encode(slug, forKey: "slug")
          }
        }

        /** Return details on an individual project. */
        public struct Plugins: Model {
          public var assets: [String]

          public var canDisable: Bool

          public var contexts: [String]

          public var doc: String

          public var enabled: Bool

          public var hasConfiguration: Bool

          public var id: String

          public var isTestable: Bool

          public var metadata: [String: AnyCodable]

          public var name: String

          public var shortName: String

          public var slug: String

          public var status: String

          public var type: String

          public var author: Author?

          public var description: String?

          public var resourceLinks: [ResourceLinks]?

          public var version: String?

          /** Return details on an individual project. */
          public struct Author: Model {
            public var name: String?

            public var url: String?

            public init(name: String? = nil, url: String? = nil) {
              self.name = name
              self.url = url
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              name = try container.decodeIfPresent("name")
              url = try container.decodeIfPresent("url")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(name, forKey: "name")
              try container.encodeIfPresent(url, forKey: "url")
            }
          }

          /** Return details on an individual project. */
          public struct ResourceLinks: Model {
            public var title: String?

            public var url: String?

            public init(title: String? = nil, url: String? = nil) {
              self.title = title
              self.url = url
            }

            public init(from decoder: Decoder) throws {
              let container = try decoder.container(keyedBy: StringCodingKey.self)

              title = try container.decodeIfPresent("title")
              url = try container.decodeIfPresent("url")
            }

            public func encode(to encoder: Encoder) throws {
              var container = encoder.container(keyedBy: StringCodingKey.self)

              try container.encodeIfPresent(title, forKey: "title")
              try container.encodeIfPresent(url, forKey: "url")
            }
          }

          public init(assets: [String], canDisable: Bool, contexts: [String], doc: String, enabled: Bool, hasConfiguration: Bool, id: String, isTestable: Bool, metadata: [String: AnyCodable], name: String, shortName: String, slug: String, status: String, type: String, author: Author? = nil, description: String? = nil, resourceLinks: [ResourceLinks]? = nil, version: String? = nil) {
            self.assets = assets
            self.canDisable = canDisable
            self.contexts = contexts
            self.doc = doc
            self.enabled = enabled
            self.hasConfiguration = hasConfiguration
            self.id = id
            self.isTestable = isTestable
            self.metadata = metadata
            self.name = name
            self.shortName = shortName
            self.slug = slug
            self.status = status
            self.type = type
            self.author = author
            self.description = description
            self.resourceLinks = resourceLinks
            self.version = version
          }

          public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: StringCodingKey.self)

            assets = try container.decodeArray("assets")
            canDisable = try container.decode("canDisable")
            contexts = try container.decodeArray("contexts")
            doc = try container.decode("doc")
            enabled = try container.decode("enabled")
            hasConfiguration = try container.decode("hasConfiguration")
            id = try container.decode("id")
            isTestable = try container.decode("isTestable")
            metadata = try container.decodeAny("metadata")
            name = try container.decode("name")
            shortName = try container.decode("shortName")
            slug = try container.decode("slug")
            status = try container.decode("status")
            type = try container.decode("type")
            author = try container.decodeIfPresent("author")
            description = try container.decodeIfPresent("description")
            resourceLinks = try container.decodeArrayIfPresent("resourceLinks")
            version = try container.decodeIfPresent("version")
          }

          public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: StringCodingKey.self)

            try container.encode(assets, forKey: "assets")
            try container.encode(canDisable, forKey: "canDisable")
            try container.encode(contexts, forKey: "contexts")
            try container.encode(doc, forKey: "doc")
            try container.encode(enabled, forKey: "enabled")
            try container.encode(hasConfiguration, forKey: "hasConfiguration")
            try container.encode(id, forKey: "id")
            try container.encode(isTestable, forKey: "isTestable")
            try container.encodeAny(metadata, forKey: "metadata")
            try container.encode(name, forKey: "name")
            try container.encode(shortName, forKey: "shortName")
            try container.encode(slug, forKey: "slug")
            try container.encode(status, forKey: "status")
            try container.encode(type, forKey: "type")
            try container.encodeIfPresent(author, forKey: "author")
            try container.encodeIfPresent(description, forKey: "description")
            try container.encodeIfPresent(resourceLinks, forKey: "resourceLinks")
            try container.encodeIfPresent(version, forKey: "version")
          }
        }

        public init(allowedDomains: [String], avatar: Avatar, color: String, dataScrubber: Bool, dataScrubberDefaults: Bool, dateCreated: String, defaultEnvironment: String?, digestsMaxDelay: Int, digestsMinDelay: Int, features: [String], firstEvent: String?, hasAccess: Bool, id: String, isBookmarked: Bool, isInternal: Bool, isMember: Bool, isPublic: Bool, latestRelease: LatestRelease?, name: String, options: Options, organization: Organization, platform: String?, platforms: [String], processingIssues: Int, relayPiiConfig: String?, resolveAge: Int, safeFields: [String], scrapeJavaScript: Bool, scrubIPAddresses: Bool, securityToken: String, securityTokenHeader: String?, sensitiveFields: [String], slug: String, status: String, storeCrashReports: Bool?, subjectPrefix: String, subjectTemplate: String, team: Team, teams: [Teams], verifySSL: Bool, plugins: [Plugins]? = nil) {
          self.allowedDomains = allowedDomains
          self.avatar = avatar
          self.color = color
          self.dataScrubber = dataScrubber
          self.dataScrubberDefaults = dataScrubberDefaults
          self.dateCreated = dateCreated
          self.defaultEnvironment = defaultEnvironment
          self.digestsMaxDelay = digestsMaxDelay
          self.digestsMinDelay = digestsMinDelay
          self.features = features
          self.firstEvent = firstEvent
          self.hasAccess = hasAccess
          self.id = id
          self.isBookmarked = isBookmarked
          self.isInternal = isInternal
          self.isMember = isMember
          self.isPublic = isPublic
          self.latestRelease = latestRelease
          self.name = name
          self.options = options
          self.organization = organization
          self.platform = platform
          self.platforms = platforms
          self.processingIssues = processingIssues
          self.relayPiiConfig = relayPiiConfig
          self.resolveAge = resolveAge
          self.safeFields = safeFields
          self.scrapeJavaScript = scrapeJavaScript
          self.scrubIPAddresses = scrubIPAddresses
          self.securityToken = securityToken
          self.securityTokenHeader = securityTokenHeader
          self.sensitiveFields = sensitiveFields
          self.slug = slug
          self.status = status
          self.storeCrashReports = storeCrashReports
          self.subjectPrefix = subjectPrefix
          self.subjectTemplate = subjectTemplate
          self.team = team
          self.teams = teams
          self.verifySSL = verifySSL
          self.plugins = plugins
        }

        public init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: StringCodingKey.self)

          allowedDomains = try container.decodeArray("allowedDomains")
          avatar = try container.decode("avatar")
          color = try container.decode("color")
          dataScrubber = try container.decode("dataScrubber")
          dataScrubberDefaults = try container.decode("dataScrubberDefaults")
          dateCreated = try container.decode("dateCreated")
          defaultEnvironment = try container.decodeIfPresent("defaultEnvironment")
          digestsMaxDelay = try container.decode("digestsMaxDelay")
          digestsMinDelay = try container.decode("digestsMinDelay")
          features = try container.decodeArray("features")
          firstEvent = try container.decodeIfPresent("firstEvent")
          hasAccess = try container.decode("hasAccess")
          id = try container.decode("id")
          isBookmarked = try container.decode("isBookmarked")
          isInternal = try container.decode("isInternal")
          isMember = try container.decode("isMember")
          isPublic = try container.decode("isPublic")
          latestRelease = try container.decodeIfPresent("latestRelease")
          name = try container.decode("name")
          options = try container.decode("options")
          organization = try container.decode("organization")
          platform = try container.decodeIfPresent("platform")
          platforms = try container.decodeArray("platforms")
          processingIssues = try container.decode("processingIssues")
          relayPiiConfig = try container.decodeIfPresent("relayPiiConfig")
          resolveAge = try container.decode("resolveAge")
          safeFields = try container.decodeArray("safeFields")
          scrapeJavaScript = try container.decode("scrapeJavaScript")
          scrubIPAddresses = try container.decode("scrubIPAddresses")
          securityToken = try container.decode("securityToken")
          securityTokenHeader = try container.decodeIfPresent("securityTokenHeader")
          sensitiveFields = try container.decodeArray("sensitiveFields")
          slug = try container.decode("slug")
          status = try container.decode("status")
          storeCrashReports = try container.decodeIfPresent("storeCrashReports")
          subjectPrefix = try container.decode("subjectPrefix")
          subjectTemplate = try container.decode("subjectTemplate")
          team = try container.decode("team")
          teams = try container.decodeArray("teams")
          verifySSL = try container.decode("verifySSL")
          plugins = try container.decodeArrayIfPresent("plugins")
        }

        public func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: StringCodingKey.self)

          try container.encode(allowedDomains, forKey: "allowedDomains")
          try container.encode(avatar, forKey: "avatar")
          try container.encode(color, forKey: "color")
          try container.encode(dataScrubber, forKey: "dataScrubber")
          try container.encode(dataScrubberDefaults, forKey: "dataScrubberDefaults")
          try container.encode(dateCreated, forKey: "dateCreated")
          try container.encodeIfPresent(defaultEnvironment, forKey: "defaultEnvironment")
          try container.encode(digestsMaxDelay, forKey: "digestsMaxDelay")
          try container.encode(digestsMinDelay, forKey: "digestsMinDelay")
          try container.encode(features, forKey: "features")
          try container.encodeIfPresent(firstEvent, forKey: "firstEvent")
          try container.encode(hasAccess, forKey: "hasAccess")
          try container.encode(id, forKey: "id")
          try container.encode(isBookmarked, forKey: "isBookmarked")
          try container.encode(isInternal, forKey: "isInternal")
          try container.encode(isMember, forKey: "isMember")
          try container.encode(isPublic, forKey: "isPublic")
          try container.encodeIfPresent(latestRelease, forKey: "latestRelease")
          try container.encode(name, forKey: "name")
          try container.encode(options, forKey: "options")
          try container.encode(organization, forKey: "organization")
          try container.encodeIfPresent(platform, forKey: "platform")
          try container.encode(platforms, forKey: "platforms")
          try container.encode(processingIssues, forKey: "processingIssues")
          try container.encodeIfPresent(relayPiiConfig, forKey: "relayPiiConfig")
          try container.encode(resolveAge, forKey: "resolveAge")
          try container.encode(safeFields, forKey: "safeFields")
          try container.encode(scrapeJavaScript, forKey: "scrapeJavaScript")
          try container.encode(scrubIPAddresses, forKey: "scrubIPAddresses")
          try container.encode(securityToken, forKey: "securityToken")
          try container.encodeIfPresent(securityTokenHeader, forKey: "securityTokenHeader")
          try container.encode(sensitiveFields, forKey: "sensitiveFields")
          try container.encode(slug, forKey: "slug")
          try container.encode(status, forKey: "status")
          try container.encodeIfPresent(storeCrashReports, forKey: "storeCrashReports")
          try container.encode(subjectPrefix, forKey: "subjectPrefix")
          try container.encode(subjectTemplate, forKey: "subjectTemplate")
          try container.encode(team, forKey: "team")
          try container.encode(teams, forKey: "teams")
          try container.encode(verifySSL, forKey: "verifySSL")
          try container.encodeIfPresent(plugins, forKey: "plugins")
        }
      }

      public typealias SuccessType = Status200

      /** Success */
      case status200(Status200)

      /** Forbidden */
      case status403

      /** Project not found */
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
        case 200: self = try .status200(decoder.decode(Status200.self, from: data))
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
