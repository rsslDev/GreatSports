//
//  PlayerListModel.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

import Foundation

// MARK: - PlayerListResponse
struct PlayerListResponse: Codable {
    var status: Int?
    var message: String?
    var data: [Player]?
    var total: Int?
    var perPage: Int?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
        case total = "total"
        case perPage = "per_page"
    }
}

// MARK: - Player
struct Player: Codable {
    var id: String?
    var sportId: String?
    var slug: String?
    var name: String?
    var nameTranslations: NameTranslations?
    var nameShort: String?
    var photo: String?
    var position: String?
    var positionName: String?
    var weight: String?
    var age: String?
    var dateBirthAt: String?
    var height: String?
    var shirtNumber: String?
    var preferredFoot: PreferredFoot?
    var nationalityCode: String?
    var flag: String?
    var marketCurrency: MarketCurrency?
    var marketValue: String?
    var contractUntil: String?
    var rating: String?
    var characteristics: Characteristics?
    var ability: [Ability]?
    var teamId: String?
    var teamCategoryId: String?
    var teamVenueId: String?
    var teamManagerId: String?
    var teamSlug: String?
    var teamName: String?
    var teamLogo: String?
    var teamNameTranslations: NameTranslations?
    var teamNameShort: String?
    var teamNameFull: String?
    var teamNameCode: String?
    var teamHasSub: String?
    var teamGender: TeamGender?
    var teamIsNationality: String?
    var teamCountryCode: String?
    var teamCountry: String?
    var teamFlag: String?
    var teamFoundation: String?
    var updated: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sportId = "sport_id"
        case slug = "slug"
        case name = "name"
        case nameTranslations = "name_translations"
        case nameShort = "name_short"
        case photo = "photo"
        case position = "position"
        case positionName = "position_name"
        case weight = "weight"
        case age = "age"
        case dateBirthAt = "date_birth_at"
        case height = "height"
        case shirtNumber = "shirt_number"
        case preferredFoot = "preferred_foot"
        case nationalityCode = "nationality_code"
        case flag = "flag"
        case marketCurrency = "market_currency"
        case marketValue = "market_value"
        case contractUntil = "contract_until"
        case rating = "rating"
        case characteristics = "characteristics"
        case ability = "ability"
        case teamId = "team_id"
        case teamCategoryId = "team_category_id"
        case teamVenueId = "team_venue_id"
        case teamManagerId = "team_manager_id"
        case teamSlug = "team_slug"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case teamNameTranslations = "team_name_translations"
        case teamNameShort = "team_name_short"
        case teamNameFull = "team_name_full"
        case teamNameCode = "team_name_code"
        case teamHasSub = "team_has_sub"
        case teamGender = "team_gender"
        case teamIsNationality = "team_is_nationality"
        case teamCountryCode = "team_country_code"
        case teamCountry = "team_country"
        case teamFlag = "team_flag"
        case teamFoundation = "team_foundation"
        case updated = "updated"
    }
}

// MARK: - Ability
struct Ability: Codable {
    var name: Name?
    var value: Int?
    var fullAverage: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
        case fullAverage = "full_average"
    }
}

enum Name: String, Codable {
    case attacking = "Attacking"
    case creativity = "Creativity"
    case defending = "Defending"
    case tactical = "Tactical"
    case technical = "Technical"
}

// MARK: - Characteristics
struct Characteristics: Codable {
    var positive: [Tive]?
    var negative: [Tive]?

    enum CodingKeys: String, CodingKey {
        case positive = "positive"
        case negative = "negative"
    }
}

// MARK: - Tive
struct Tive: Codable {
    var feature: String?
    var value: Int?

    enum CodingKeys: String, CodingKey {
        case feature = "feature"
        case value = "value"
    }
}

enum MarketCurrency: String, Codable {
    case eur = "EUR"
}

//enum Position: String, Codable {
//    case d = "D"
//    case f = "F"
//    case m = "M"
//}

//enum PositionName: String, Codable {
//    case defender = "Defender"
//    case forward = "Forward"
//    case midfielder = "Midfielder"
//}

enum PreferredFoot: String, Codable {
    case both = "Both"
    case preferredFootLeft = "Left"
    case preferredFootRight = "Right"
}

enum TeamGender: String, Codable {
    case empty = ""
    case m = "M"
    case f = "F"
}

// MARK: - NameTranslations
struct NameTranslations: Codable {
    var en: String?
    var ru: String?
    var de: String?
    var es: String?
    var fr: String?
    var zh: String?
    var tr: String?
    var el: String?
    var it: String?
    var nl: String?
    var pt: String?

    enum CodingKeys: String, CodingKey {
        case en = "en"
        case ru = "ru"
        case de = "de"
        case es = "es"
        case fr = "fr"
        case zh = "zh"
        case tr = "tr"
        case el = "el"
        case it = "it"
        case nl = "nl"
        case pt = "pt"
    }
}

