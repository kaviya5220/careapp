//
//  ViewController.swift
//  appUIKit
//
//  Created by sysadmin on 07/07/21.
//


import UIKit
import CryptoSwift

class DropdownMenu: UIViewController, UITableViewDataSource, UITableViewDelegate {
    public var menu : [String] = ["Date","Item Name"]
    var text:String = ""
    let dropdownTableView = UITableView() // view
    
    
    @objc func didTapAdd(_ sender: UIButton) {
        
        //self.navigationController?.pushViewController(MainViewController(), animated: true)
        
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let plusbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd(_:)))
        self.navigationItem.rightBarButtonItem = plusbutton
        view.backgroundColor = .white
        view.addSubview(dropdownTableView)
        
        dropdownTableView.translatesAutoresizingMaskIntoConstraints = false
        
        dropdownTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 50).isActive = true
        dropdownTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        dropdownTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        dropdownTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        dropdownTableView.dataSource = self
        dropdownTableView.delegate = self
        dropdownTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationItem.title = "Sort By"
        //navigationItem.title = .none
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    


}

