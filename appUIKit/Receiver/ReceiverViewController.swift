//
//  ReceiverViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit

class ReceiverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
       public var items : [Item] = []
        var text:String = ""
        let receiverTableView = UITableView()
        var db = DBHelper()
    
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            items = db.getitems()
            view.backgroundColor = .white
            view.addSubview(receiverTableView)
            
            receiverTableView.translatesAutoresizingMaskIntoConstraints = false
            
            receiverTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 50).isActive = true
            receiverTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
            receiverTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
            receiverTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            receiverTableView.dataSource = self
            receiverTableView.delegate = self
            receiverTableView.register(ReceiverTableViewCell.self, forCellReuseIdentifier: "itemcell")
            navigationItem.title = "HOME"
            //navigationItem.title = .none
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ReceiverTableViewCell
            cell.item = Item(item_id: items[indexPath.row].item_id, item_name: items[indexPath.row].item_name, item_description: items[indexPath.row].item_description, item_quantity: items[indexPath.row].item_quantity, address:items[indexPath.row].address, Donar_ID: items[indexPath.row].Donar_ID)
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
        
        


    }

