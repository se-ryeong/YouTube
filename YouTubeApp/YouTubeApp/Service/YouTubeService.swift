//
//  YouTubeService.swift
//  YouTubeApp
//
//  Created by t2023-m0062 on 2023/09/06.
//

import Foundation

struct YouTubeService {
    
    func fetchYouTubeThumbnails(_ categoryId: String?, completion: @escaping (_ items: [Item])->Void) {
        let search = "official+movie+trailer" //원하는 동영상 검색어
        let apiKey = ApiKey.rang.getApiKey
        let baseURL = "https://www.googleapis.com/youtube/v3/search"
        
        //공용
        var urlComponent = URLComponents(string: baseURL)
        let partQuery = URLQueryItem(name: "part", value: "snippet") //필수 매개변수
        let keyQuery = URLQueryItem(name: "key", value: apiKey)

        //search
        let searchQuery = URLQueryItem(name: "q", value: search)
        let maxResults = URLQueryItem(name: "maxResults", value: "1") //영상 개수
        
        let type = URLQueryItem(name: "type", value: "video")
        let videoCategoryId = URLQueryItem(name: "videoCategoryId", value: categoryId)
        
        if categoryId == nil {
            let items: [URLQueryItem] = [partQuery,keyQuery,searchQuery,maxResults]
            urlComponent?.queryItems = items
        } else {
            let items: [URLQueryItem] = [partQuery,keyQuery,searchQuery,maxResults, type, videoCategoryId]
            urlComponent?.queryItems = items
        }
        
        guard let url = urlComponent?.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching YouTube data")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
//                print("API Response: \(responseString)")
            }
            
            do {
                let res = try JSONDecoder().decode(YoutubeData.self, from: data)
                completion(res.items)
                
            } catch {
                print(error.localizedDescription)
                print(error)
            }
        }
        task.resume()
    }

}
