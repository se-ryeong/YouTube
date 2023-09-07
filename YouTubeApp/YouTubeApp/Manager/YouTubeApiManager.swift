//
//  YouTubeApiManager.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/06.
//

import Foundation

struct YouTubeManager{
    
    func getSearchData(keyWord: String, completion: @escaping (YoutubeData?) -> Void) {
        
        let urlString = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&q=\(keyWord)official trailer&key=\(ApiKey.seo.getApiKey)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        performRequest(urlString: urlString) { data in completion(data) }
    }
    
    func performRequest(urlString: String, completion: @escaping (YoutubeData?) -> Void) {
        // 1. URL 구조체 만들기
        guard let url = URL(string: urlString) else { return }
        
        // 2. URLSession 만들기
        let session = URLSession(configuration: .default)
        
        // 3. 세션에 작업 부여
        let task = session.dataTask(with: url) { data, _, error in
            if error != nil {
                print(error!)
                completion(nil)
                return
            }
            
            guard let safeData = data else {
                completion(nil)
                return
            }
            
            // 데이터 분석하기
            if let data = self.parseJSON(safeData) {
                completion(data)
            } else {
                completion(nil)
            }
        }
        
        // 4.Start the task
        task.resume() // 일시정지된 상태로 작업이 시작하기 때문
    }
    
    func parseJSON(_ data: Data) -> YoutubeData? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(YoutubeData.self, from: data)
            print("파싱 성공")
            return decodedData
            
        } catch {
            print(error)
            print("파싱 실패")
            return nil
        }
    }
}

