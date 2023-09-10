//
//  VideoSnippetModel.swift
//  YouTubeApp
//
//  Created by 랑 on 2023/09/08.
//

import Foundation

struct VideoData: Decodable {
    let items: [VideoItem]
}

struct VideoItem: Codable {
    let id: String
    let snippet: VideoSnippet
}

struct VideoSnippet: Codable {
    let publishedAt: String   // Date로 두면 typeMismatch(Swift.Double, Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "items", intValue: nil), _JSONKey(stringValue: "Index 0", intValue: 0), CodingKeys(stringValue: "snippet", intValue: nil), CodingKeys(stringValue: "publishedAt", intValue: nil)], debugDescription: "Expected to decode Double but found a string/data instead.", underlyingError: nil))
    let title: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let categoryId: String
}

struct StatisticsData: Decodable {
    let items: [StatisticsItem]
}

struct StatisticsItem: Decodable {
    let statistics: Statistics
}

struct Statistics: Decodable {
    let viewCount: String
}
