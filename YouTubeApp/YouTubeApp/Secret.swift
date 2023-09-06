//
//  Secret.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/06.
//

import Foundation

enum ApiKey {
    case seo
    case rang
    case ryeong
    var getApiKey: String {
        switch self {
        case .seo:
            return "AIzaSyCnemkX3hsKpbx1ehvf0KowNaiZbB1XinE"
        case .rang:
            return "AIzaSyAW5IxTM0j37NqWa6Y83N7aQ4VZyBHuQGo"
        case .ryeong:
            return "AIzaSyCRUWav07GHjg5O92n3QeM8_3AgOdQPEQU"
        }
    }
}
