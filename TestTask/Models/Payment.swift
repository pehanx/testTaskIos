//
//  Payment.swift
//  TestTask
//
//  Created by Nikita Spekhin on 19.10.2021.
//

import Foundation

struct Payment:Decodable {
    let amount:StringDoubleCodable
    let created:Double
    let currency:String?
    let desc:String
}
