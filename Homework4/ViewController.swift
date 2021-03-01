//
//  ViewController.swift
//  Homework4
//
//  Created by Elif Yalçın on 23.01.2021.
//

import UIKit
import SCLAlertView
import SQLite

class ViewController: UIViewController {
    
    let db = DB()
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtAmount: UITextField!
    
    @IBAction func btnAdd(_ sender: UIButton) {
        let name = txtName.text!
        //let amount = txtAmount.text!
        //let row = db.userInsert(name: name, amount:amount)
        if name == ""{
            SCLAlertView().showError("Hata", subTitle: "Lütfen bir ürün giriniz!")
        } else{
            let amount = txtAmount.text!
            
            if db.productInsert(name: name, amount: amount) == -1 {
                SCLAlertView().showError("Hata", subTitle: "Bu ürün daha önce eklendi.Lütfen farklı bir ürün ekleyiniz!")
            }else{
                SCLAlertView().showSuccess("Başarılı", subTitle: "Ürün listeye eklendi!")
            }
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.fncConnection()
    }


}

