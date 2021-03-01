//
//  DB.swift
//  Homework4
//
//  Created by Elif Yalçın on 23.01.2021.
//

import Foundation
import SQLite

struct ProductSt {
    var id:Int64 = 0
    var name:String = ""
    var amount:String = ""
}


class DB {
    
    var db:Connection! //connection tipinde bir db nesnesi
    var tableList = Table("tList") //user tablosu
    
    //userın icindeki columnları tanımlıyoruz
    let id = Expression<Int64>("id")
    let name = Expression<String?>("name")
    let amount = Expression<String>("amount")
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    
    func fncConnection() {
        
        let  dbPath = path + "/db.sqlite3"
        print("Full Path : \(dbPath)")
        db = try! Connection(dbPath)
        
        do {
            try db.scalar(tableList.exists) //exist olup olmadığına bak
        } catch  { //eger table yoksa olustur
            
            try! db.run(tableList.create { t in
                t.column(id, primaryKey: true)
                t.column(name, unique: true)
                t.column(amount)
            })
            
        }
        
    }
 
    
    func productInsert(name: String, amount: String) -> Int64 {
        
        do {
            let insert = tableList.insert( self.name <- name, self.amount <- amount )
            return try db.run(insert)
        } catch  {
            return -1 //eklemede sorun old -1 döndür.
                        //aynı mail adresiyle veri kaydolamaz
        }
        
    }
    
    
    func productList() -> [ProductSt] {
        var arr:[ProductSt] = []
        let users = try! db.prepare(tableList)
        for item in users {
            let us = ProductSt(id: item[id], name: item[name]!, amount: item[amount])
            arr.append(us)
        }
        return arr
    }
    
    func productDelete( uid:Int64 ) -> Int {
        let alice = tableList.filter( id == uid )
        return try! db.run( alice.delete() )
    }
    
    
    
    
}
