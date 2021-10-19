//
//  ViewController.swift
//  TestTask
//
//  Created by Nikita Spekhin on 19.10.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        APIService.shared.login(login: "demo1", password: "12345") { responseLogin, error in
            if let error = error {
                self.presentErrorAlertController(message: error.localizedDescription)
                return
            }
            if let responseError = responseLogin?.error {
                self.presentErrorAlertController(message: responseError.error_msg)
                return
            }
        }
        
    
    
        APIService.shared.fetchPayments { responsePayments, error in
            if let error = error {
                self.presentErrorAlertController(message: error.localizedDescription)
                return
            }
            if let responseError = responsePayments?.error {
                self.presentErrorAlertController(message: responseError.error_msg)
                return
            }
        }
    }


}

