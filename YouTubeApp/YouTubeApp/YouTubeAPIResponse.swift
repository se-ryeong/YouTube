//
//  YouTubeAPIResponse.swift
//  YouTubeApp
//
//  Created by t2023-m0062 on 2023/09/06.
//

import Foundation

// MARK: - YouTubeAPIResponse
struct YouTubeAPIResponse: Codable {
    let kind, etag, nextPageToken, regionCode: String?
    let pageInfo: PageInfo?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let kind, etag: String?
    let id: ID?
    let snippet: Snippet?
}

// MARK: - ID
struct ID: Codable {
    let kind, videoId: String?
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: String?
    let channelId, title, description: String?
    let thumbnails: Thumbnails?
    let channelTitle, liveBroadcastContent: String?
    let publishTime: String?
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}
