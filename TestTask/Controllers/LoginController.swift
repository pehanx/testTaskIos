//
//  LoginController.swift
//  TestTask
//
//  Created by Nikita Spekhin on 20.10.2021.
//

import Foundation
import UIKit
import SnapKit

class LoginController:UIViewController {
    
    // MARK: - Views
    private let loginTextField:TextField = {
        let textField = TextField()
        textField.placeholder = "Введите login"
        return textField
    }()
    private let passwordTextField:TextField = {
        let textField = TextField()
        textField.placeholder = "Введите пароль"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    private let activityIndicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.tintColor = .darkGray
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        return indicator
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Авторизация"
        setupUI()
    }
    
    // MARK: - Selectors
    @objc private func login(){
        
        guard
            let loginText = loginTextField.text, !loginText.isEmpty,
            let passwordText = passwordTextField.text, !passwordText.isEmpty
        else {
            presentErrorAlertController(message: "Заполните все поля")
            return
        }
        activityIndicator.startAnimating()
        loginButton.isEnabled = false
        APIService.shared.login(login: loginText, password: passwordText) { responseLogin, error in
            self.loginButton.isEnabled = true
            self.activityIndicator.stopAnimating()
            if let error = error {
                self.presentErrorAlertController(message: error.localizedDescription)
                return
            }
            if let responseError = responseLogin?.error {
                self.presentErrorAlertController(message: responseError.error_msg)
                return
            }
            
            if let token = responseLogin?.response?.token {
                TokenManager.shared.saveToken(token: token)
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: PaymentsController()))
            }
        }
    }
    
    // MARK: - Helpers
    private func setupUI(){
        
        view.backgroundColor = .systemBackground
        
        let stackView = UIStackView(arrangedSubviews: [
            loginTextField, passwordTextField, loginButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(72)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
