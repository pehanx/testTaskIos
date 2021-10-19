//
//  APIService.swift
//  TestTask
//
//  Created by Nikita Spekhin on 19.10.2021.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    private let BASE_URL = "http://82.202.204.94/api-test/"
    
    private let headers:HTTPHeaders = [
        "app-key":"12345",
        "v":"1"
    ]
    
    func login(login:String, password:String, completion: @escaping (ResponseLogin?, Error?) -> ()){
        
        let params:Parameters = [
            "login":login,
            "password":password
        ]
        
        AF.request(BASE_URL + "login", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: ResponseLogin.self) { response in
            guard let data = response.value else {
                completion(nil, response.error)
                return
            }
            completion(data, nil)
        }
    }
    
    func fetchPayments(completion: @escaping (ResponsePayments?, Error?) -> ()){
        let token = TokenManager.shared.token
        AF.request(BASE_URL + "payments?token=" + token, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: ResponsePayments.self) { response in
            
            guard let data = response.value else {
                completion(nil, response.error)
                return
            }
            completion(data, nil)
        }
    }
    
}
