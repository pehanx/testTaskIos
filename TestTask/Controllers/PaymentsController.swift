//
//  PaymentsController.swift
//  TestTask
//
//  Created by Nikita Spekhin on 20.10.2021.
//

import Foundation
import UIKit

class PaymentsController:UITableViewController {
    
    // MARK: - Properties
    private var payments:[Payment]?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        fetchData()
    }
    
    // MARK: - Selectors
    @objc private func showLogoutAlert(){
        let alertController = UIAlertController(title: "Вы действительно хотите выйти?", message: nil, preferredStyle:.alert)
        alertController.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { [weak self] _ in
            self?.logout()
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alertController, animated: true)
    }
    
    // MARK: - Helpers
    private func logout(){
        TokenManager.shared.removeToken()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(UINavigationController(rootViewController: LoginController()))
    }
    
    private func setupNavBar(){
        navigationItem.title = "Платежи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(showLogoutAlert))
    }
    
    private func setupTableView(){
        tableView.register(PaymentTableViewCell.self, forCellReuseIdentifier: PaymentTableViewCell.cellId)
    }
    
    private func fetchData(){
        APIService.shared.fetchPayments { responsePayments, error in
            if let error = error {
                self.presentErrorAlertController(message: error.localizedDescription)
                return
            }
            if let responseError = responsePayments?.error {
                self.presentErrorAlertController(message: responseError.error_msg)
                return
            }
            if let payments = responsePayments?.response {
                self.payments = payments
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension PaymentsController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        payments?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTableViewCell.cellId, for: indexPath) as! PaymentTableViewCell
        cell.bindData(payment: payments?[indexPath.row])
        return cell
    }
}
