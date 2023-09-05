//
//  LoginDataManager.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import Foundation

final class UserDataManager{
    
    static let shared = UserDataManager()
    
    var userData:[String:UserData] = [:]
    
    func appendUser(nickName:String, id:String, passWord:String) -> Bool{
        
        if userData[id] == nil{
            userData[id] = UserData(passWord: passWord, nickName: nickName)
            return true
        } else {
            return false
        }
    }
    
    private init(){
        
    }
}
