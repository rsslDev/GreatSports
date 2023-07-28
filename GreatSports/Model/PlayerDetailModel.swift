//
//  PlayerDetailModel.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

// MARK: - PlayerDetailResponse
struct PlayerDetailResponse: Codable {
    var status: Int?
    var message: String?
    var data: PlayerDetail?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
}

// MARK: - PlayerDetail
struct PlayerDetail: Codable {
    var playerId: String?
    var playerPhoto: String?
    var playerName: String?
    var playerCountry: String?
    var teamPhoto: String?
    var teamName: String?
    var teamSlug: String?
    var indicators: [Indicator]?
    var rating: [Indicator]?
    var statistics: [Statistic]?
    var about: String?
    var events: [Event]?
    var medias: [Media]?

    enum CodingKeys: String, CodingKey {
        case playerId = "player_id"
        case playerPhoto = "player_photo"
        case playerName = "player_name"
        case playerCountry = "player_country"
        case teamPhoto = "team_photo"
        case teamName = "team_name"
        case teamSlug = "team_slug"
        case indicators = "indicators"
        case rating = "rating"
        case statistics = "statistics"
        case about = "about"
        case events = "events"
        case medias = "medias"
    }
}

// MARK: - Event
struct Event: Codable {
    var leagueName: String?
    var leagueLogo: String?
    var leagueSlug: String?
    var matches: [Match]?

    enum CodingKeys: String, CodingKey {
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
        case leagueSlug = "league_slug"
        case matches = "matches"
    }
}

// MARK: - Match
struct Match: Codable {
    var date: String?
    var homeScore: String?
    var awayScore: String?
    var homeName: String?
    var awayName: String?
    var slug: String?
    var round: String?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case homeScore = "home_score"
        case awayScore = "away_score"
        case homeName = "home_name"
        case awayName = "away_name"
        case slug = "slug"
        case round = "round"
    }
}

// MARK: - Indicator
struct Indicator: Codable {
    var key: String?
    var value: String?

    enum CodingKeys: String, CodingKey {
        case key = "key"
        case value = "value"
    }
}

// MARK: - Media
struct Media: Codable {
    var preview: String?
    var video: String?
    var title: String?
    var subtitle: String?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case preview = "preview"
        case video = "video"
        case title = "title"
        case subtitle = "subtitle"
        case date = "date"
    }
}

// MARK: - Statistic
struct Statistic: Codable {
    var league: String?
    var data: [StatisticList]?

    enum CodingKeys: String, CodingKey {
        case league = "league"
        case data = "data"
    }
}

// MARK: - StatisticList
struct StatisticList: Codable {
    var section: String?
    var data: [Indicator]?

    enum CodingKeys: String, CodingKey {
        case section = "section"
        case data = "data"
    }
}

enum Section: String, Codable {
    case attacking = "Attacking"
    case cards = "Cards"
    case defending = "Defending"
    case matches = "Matches"
    case otherPerGame = "Other (per game)"
    case passes = "Passes"
}
