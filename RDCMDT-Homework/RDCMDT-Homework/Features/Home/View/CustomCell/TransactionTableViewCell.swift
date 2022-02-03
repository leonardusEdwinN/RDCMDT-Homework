//
//  TransactionTableViewCell.swift
//  RDCMDT-Homework
//
//  Created by Edwin Niwarlangga on 02/02/22.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var transactionAmmountLabel: UILabel!
    @IBOutlet weak var transactionAccountNumberLabel: UILabel!
    @IBOutlet weak var transactionHolderNameLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        resetUI()
    }
    
    func resetUI(){
        transactionDateLabel.text = ""
        transactionAmmountLabel.text = ""
        transactionHolderNameLabel.text = ""
        transactionAccountNumberLabel.text = ""
        setupUI()
    }
    
    func setupUI(){
        outerView.backgroundColor = UIColor.white
        outerView.layer.shadowColor = UIColor.gray.cgColor
        outerView.layer.shadowOffset = CGSize(width: 1, height: 1)
        outerView.layer.shadowRadius = 1
        outerView.layer.shadowOpacity = 5
        outerView.layer.cornerRadius = 15
    }
    
    func setupUI(transactionDate : String, transactionHolder : String, transactionAmmount: Double, transactionAccNumber : String, transactionType : String){
        setupUI()
        if transactionType == "transfer"{
            transactionAmmountLabel.textColor = UIColor.red
        }else if transactionType == "received"{
            transactionAmmountLabel.textColor = UIColor.green
        }
        
        transactionAmmountLabel.text = "\(transactionAmmount)"
        transactionHolderNameLabel.text = transactionHolder
        transactionAccountNumberLabel.text = transactionAccNumber
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+7")
        let dateTemp = dateFormatter.date(from: transactionDate)
        
        
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy HH:mm:ss"
        transactionDateLabel.text = dateFormatter.string(from: dateTemp ?? Date())
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
