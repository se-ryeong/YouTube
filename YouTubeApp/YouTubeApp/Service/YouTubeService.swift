//
//  YouTubeService.swift
//  YouTubeApp
//
//  Created by t2023-m0062 on 2023/09/06.
//

import Foundation

struct YouTubeService {

    func fetchYouTubeThumbnails(completion: @escaping (_ items: [Item])->Void) {
        let search = "official+movie+trailer" //원하는 동영상 검색어
        let apiKey = ApiKey.ryeong.getApiKey

        let baseURL = "https://www.googleapis.com/youtube/v3/search"
        var urlComponent = URLComponents(string: baseURL)
        let partQuery = URLQueryItem(name: "part", value: "snippet") //필수 매개변수
        let searchQuery = URLQueryItem(name: "q", value: search)
        let keyQuery = URLQueryItem(name: "key", value: apiKey)
        let maxResults = URLQueryItem(name: "maxResults", value: "20") //영상 개수
        
        let items: [URLQueryItem] = [partQuery,searchQuery,keyQuery,maxResults]
        urlComponent?.queryItems = items
        
        guard let url = urlComponent?.url else { return }
        
        print(url.absoluteString)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching YouTube data")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("API Response: \(responseString)")
            }
            
            do {
                let res = try JSONDecoder().decode(YouTubeAPIResponse.self, from: data)
                completion(res.items ?? [])
                
            } catch {
                print(error.localizedDescription)
                print(error)
            }
        }
        task.resume()
    }
}
