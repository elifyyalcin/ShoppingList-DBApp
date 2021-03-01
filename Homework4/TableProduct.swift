//
//  ProductTable.swift
//  Homework4
//
//  Created by Elif Yalçın on 23.01.2021.
//

import UIKit
import SCLAlertView

class TableProduct: UITableViewController {
    
    let db = DB() //dataları kullanmak icin db nesnesine iht var
    var arr:[ProductSt] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db.fncConnection()
        arr = db.productList()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = arr[indexPath.row]
        cell.textLabel?.text = item.name
        //cell.detailTextLabel?.text = item.amount

        return cell
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true //her satır editlenmeye uygun
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let item = arr[indexPath.row]
            let deleteRow = db.productDelete(uid: item.id)
            if ( deleteRow > 0) {
                arr.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SCLAlertView().showEdit("\(arr[indexPath.row].name)", subTitle: "\(arr[indexPath.row].amount)")
        
    }
    
    

}
