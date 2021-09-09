//
//  CharacterData.swift
//  Marvel Characters
//
//  Created by Softbuilder Hibrido on 24/08/21.
//

import Foundation

struct CharacterDataWrapper: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: CharacterDataContainer
    let etag: String?
}

struct CharacterDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let resourceURI: String?
    let urls: [Url]?
    let thumbnail: Image?
    let comics: Comics?
    let stores: Storys?
    let events: Events?
    let series: Series?
}

struct Url: Codable {
    let type: String?
    let url: String?
}

struct Image: Codable {
    let path: String?
    let `extension`: String?
}

struct Comics: Codable {
    let available: Int?
    let returned: Int?
    let items: [ComicSummary]
}

struct ComicSummary: Codable {
    let resourceURI: String?
    let name: String?
}

struct Storys: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String
    let items: [StorySummary]
}

struct StorySummary: Codable {
    let resourceURI: String?
    let name: String
    let type: String
}

struct Events: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [EventSummary]
}

struct EventSummary: Codable {
    let resourceURI: String?
    let name: String?
}

struct Series: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [SeriesSummary]
}

struct SeriesSummary: Codable {
    let resourceURI: String
    let name: String
}
