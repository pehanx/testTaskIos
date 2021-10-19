//
//  EnumCodable.swift
//  TestTask
//
//  Created by Nikita Spekhin on 20.10.2021.
//

import Foundation


enum StringDoubleCodable:Decodable {
    case string(String)
    case double(Double)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self){
            self = .string(x)
            return
        }
        if let x = try? container.decode(Double.self){
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(StringDoubleCodable.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MyValue"))
    }
    
    var stringValue:String {
        switch self {
        case .string(let value):
            return value
        case .double(let value):
            return "\(value)"
        }
    }
}
