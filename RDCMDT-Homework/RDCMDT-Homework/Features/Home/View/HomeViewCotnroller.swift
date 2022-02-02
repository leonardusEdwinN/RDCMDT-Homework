//
//  HomeViewCotnroller.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 02/02/22.
//

import Foundation
import UIKit

class HomeViewController : UIViewController{
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var buttonLogout: UIButton!
    @IBAction func buttonLogoutPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var labelInfomartion: UILabel!
    @IBOutlet weak var labelCurrencyInformation: UILabel!
    @IBOutlet weak var labelAccountNumber: UILabel!
    @IBOutlet weak var labelAccountNumberValue: UILabel!
    @IBOutlet weak var labelAccountHolder: UILabel!
    @IBOutlet weak var labelAccountHolderName: UILabel!
    @IBOutlet weak var copyAccountNumberButton: UIButton!
    @IBAction func copyAccountNumberButtonPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var labelTransactions: UILabel!
    @IBOutlet weak var transactionsTableView: UITableView!
    
    // MARK: Variable
    var homeVM = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPUI()
        registerCell()
        
        getData()
    }
    
    func registerCell(){
        transactionsTableView.register(UINib.init(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "transactionTableViewCell")
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
    }
    
    func setUPUI(){
        navigationView.backgroundColor = UIColor.white
        navigationView.layer.shadowColor = UIColor.gray.cgColor
        navigationView.layer.shadowOffset = CGSize(width: 1, height: 1)
        navigationView.layer.shadowRadius = 1
        navigationView.layer.shadowOpacity = 5
        
        informationView.backgroundColor = UIColor.white
        informationView.layer.shadowColor = UIColor.gray.cgColor
        informationView.layer.shadowOffset = CGSize(width: 1, height: 1)
        informationView.layer.shadowRadius = 1
        informationView.layer.shadowOpacity = 5
        informationView.layer.cornerRadius = 15
        
        labelAccountNumberValue.text = UserDefaults.standard.string(forKey: "AccountNumber")
        labelAccountHolderName.text = UserDefaults.standard.string(forKey: "Username")
    }
    
    func getData(){
        LoadingScreen.sharedInstance.showIndicator()
        homeVM.getBalance { status, balance in
            self.labelAccountNumberValue.text = balance.accountNo
            if let balance = balance.balance{
                self.labelCurrencyInformation.text = "SGD \(balance)"
            }
        }
        
        homeVM.getAllTransactions { status, transactions in
            DispatchQueue.main.async {
                self.transactionsTableView.reloadData()
            }
        }
        
        
        
        LoadingScreen.sharedInstance.hideIndicator()
    }
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM.numberOfRows(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionTableViewCell") as! TransactionTableViewCell
        
        let dataCell = homeVM.modelAt(indexPath.row)
        
        
        cell.setupUI(transactionDate: dataCell.item.transactionDate ?? "\(Date())", transactionHolder: dataCell.item.receipient?.accountHolder ?? "", transactionAmmount: dataCell.item.amount ?? 0, transactionAccNumber: dataCell.item.receipient?.accountNo ?? "", transactionType: dataCell.item.transactionType ?? "")
        
        return cell
    }
    
    
}
