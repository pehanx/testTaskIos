//
//  Double+Extensions.swift
//  TestTask
//
//  Created by Nikita Spekhin on 20.10.2021.
//

import Foundation
import UIKit

extension Double {
    var convertedDate:String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return dateFormatter.string(from: date).replacingOccurrences(of: ".", with: "")
    }
}
