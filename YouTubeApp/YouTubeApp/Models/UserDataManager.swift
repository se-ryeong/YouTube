//
//  LoginDataManager.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import Foundation

final class UserDataManager{
    
    static let shared = UserDataManager()
    
    var userData:[String:UserData] = ["1":UserData(passWord: "1", nickName: "test")]
    
    public func appendUser(nickName:String, id:String, passWord:String){
        userData[id] = UserData(passWord: passWord, nickName: nickName)
    }
    
    private init(){
        
    }
}