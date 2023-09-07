//
//  UrlManager.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/07.
//

import Foundation

class URLManager {
  static let shared = URLManager()
  private init() { }
  var components = URLComponents(string: "https://youtube.googleapis.com/youtube/v3/videos")
  let key = URLQueryItem(name: "key", value: "\(ApiKey.rang.getApiKey)")
  let part = URLQueryItem(name: "part", value: "snippet")
  func createURL(_ videoId: String) -> URL? {
    let id = URLQueryItem(name: "id", value: videoId)
    components?.queryItems = [key, part, id]
    let url = components?.url
    return url
  }
  func getJsonData(_ videoId: String, completion: @escaping (Result<Data, Error>) -> Void) {
    guard let url = createURL(videoId) else { return }
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error {
        print("Error: \(error.localizedDescription)")
        completion(.failure(NetworkError.unknown(error.localizedDescription)))
        return
      }
      guard let httpResponse = response as? HTTPURLResponse,
         (200...299).contains(httpResponse.statusCode) else {
        print("Error: invalid response")
        completion(.failure(NetworkError.invalidResponse))
        return
      }
      guard let data = data else {
        print("Error: no data")
        completion(.failure(NetworkError.emptyResponse))
        return
      }
      print("데이터받기 성공")
      completion(.success(data))
    }
    task.resume()
  }
}

