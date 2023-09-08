//
//  VideoURLService.swift
//  YouTubeApp
//
//  Created by 랑 on 2023/09/08.
//

import Foundation

struct VideoURLService {
    
    func getVideoInfo(_ videoId: String?, completion: @escaping (_ items: [VideoItem]) -> Void) {
        
        var components = URLComponents(string: "https://youtube.googleapis.com/youtube/v3/videos")
        let key = URLQueryItem(name: "key", value: "\(ApiKey.rang.getApiKey)")
        let part = URLQueryItem(name: "part", value: "snippet")
        let id = URLQueryItem(name: "id", value: videoId)
        
        components?.queryItems = [key, part, id]
        
        guard let url = components?.url else { return }
        
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
                let res = try JSONDecoder().decode(VideoData.self, from: data)
                completion(res.items)
            } catch {
                print(error.localizedDescription)
                print(error)
            }
        }
        task.resume()
    }
    
    func getViewCount(_ videoId: String, completion: @escaping (_ items: [StatisticsItem]) -> Void) {
        
        var urlComponent = URLComponents(string: "https://youtube.googleapis.com/youtube/v3/videos")
        let key = URLQueryItem(name: "key", value: "\(ApiKey.rang.getApiKey)")
        let part = URLQueryItem(name: "part", value: "statistics")
        let id = URLQueryItem(name: "id", value: videoId)
        
        let items: [URLQueryItem] = [key, part, id]
        
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
                let res = try JSONDecoder().decode(StatisticsData.self, from: data)
                completion(res.items)
            } catch {
                print(error.localizedDescription)
                print(error)
            }
        }
        task.resume()
    }
}
