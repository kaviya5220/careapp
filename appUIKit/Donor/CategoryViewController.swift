//
//  CategoryViewController.swift
//  appUIKit
//
//  Created by sysadmin on 30/07/21.
//

import UIKit
protocol  chooseCategory {
    func chooseCategory(category : String)
}

class CategoryViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
      let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var category = ["Book", "Food", "Cloth"]
    var delegate : chooseCategory?

      override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTableView()
//        let cancel = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(cancel(_:)))
//        self.navigationItem.rightBarButtonItem = cancel
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
      }
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
      }
   // @objc func cancel(_ sender: UIButton) {
        //self.present(actionSheet,animated: true)
  //  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
    let section = "Select a Category"
       return "\(section)"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
      }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = category[indexPath.row]
     //   cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  let vc = AddItemTableViewController()
        let category : String = category[indexPath.row]
        delegate?.chooseCategory(category: category)
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
           // self.navigationController?.pushViewController(vc, animated: true)
        }
            
}
