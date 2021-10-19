//
//  AuthManager.swift
//  TestTask
//
//  Created by Nikita Spekhin on 20.10.2021.
//

import Foundation

class TokenManager {
    
    static let shared = TokenManager()
    
    private let tokenKey = "tokenKey"
    
    func saveToken(token:String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func removeToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    func issetToken() -> Bool {
        !(UserDefaults.standard.string(forKey: tokenKey) ?? "").isEmpty
    }
    
    var token:String {
        return UserDefaults.standard.string(forKey: tokenKey) ?? ""
    }
    
}
