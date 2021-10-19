//
//  UIViewController+Extensions.swift
//  TestTask
//
//  Created by Nikita Spekhin on 20.10.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentErrorAlertController(message:String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
}
