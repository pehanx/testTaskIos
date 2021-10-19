//
//  Response.swift
//  TestTask
//
//  Created by Nikita Spekhin on 20.10.2021.
//

import Foundation

struct ResponsePayments:Decodable {
    let success:String
    let response:[Payment]?
    let error:ResponseError?
}

struct ResponseLogin:Decodable {
    let success:String
    let response: ResponseToken?
    let error:ResponseError?
}

struct ResponseToken:Decodable {
    let token:String
}

struct ResponseError:Decodable {
    let error_code:Int
    let error_msg:String
}
