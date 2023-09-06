//
//  LoginDataManager.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import Foundation

final class UserDataManager{
    
    
    static let shared = UserDataManager()
    
    private let encoder = JSONEncoder()
    
    private let decoder = JSONDecoder()
    
    public var userData:[String:UserData] = ["1":UserData(passWord: "1", nickName: "test")]
    
    public func appendUser(nickName:String, id:String, passWord:String){
        userData[id] = UserData(passWord: passWord, nickName: nickName)
    }
    
    func setData(){
        if let encoded = try? encoder.encode(userData){
            UserDefaults.standard.set(encoded, forKey: "UserData")
         }
    }
    
    func loadData(){
        if let data = UserDefaults.standard.object(forKey: "UserData") as? Data,
           let manager = try? decoder.decode([String:UserData].self, from: data) {
                self.userData = manager
        }
    }
    
    private init(){
        
    }
    
}


