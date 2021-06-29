//
//  ReceiverViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit


class ReceiverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITabBarControllerDelegate, UISearchBarDelegate,UISearchResultsUpdating {
    public var itemid : [Int] = []
    public var items : [Item] = []
    public var filteredItems : [Item] = []
    let receiverInteractor = ReceiverInteractor()
    let receiverTableView = UITableView()
    var searchController : UISearchController!
        func updateSearchResults(for searchController: UISearchController) {
            let searchString = searchController.searchBar.text
            if(searchString == ""){
                filteredItems = items
            }
            else{
            filteredItems = items.filter({$0.item_name.contains(searchString!)})
            }

            receiverTableView.reloadData()
            
        }
    override func viewWillAppear(_ Animated : Bool) {
        super.viewWillAppear(Animated)
            print("view will appear")
        
        items = receiverInteractor.getitemdetails()
        print(items)
        filteredItems = items
           receiverTableView.reloadData()
            view.backgroundColor = .white
            view.addSubview(receiverTableView)
            receiverTableView.translatesAutoresizingMaskIntoConstraints = false
            receiverTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
            receiverTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
            receiverTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
            receiverTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.searchBar.placeholder = "Search by Item Name"
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.searchBar.sizeToFit()
            receiverTableView.tableHeaderView = searchController.searchBar
            definesPresentationContext = true

            receiverTableView.dataSource = self
            receiverTableView.delegate = self
            receiverTableView.register(ReceiverTableViewCell.self, forCellReuseIdentifier: "itemcell")
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        }
   

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row\(indexPath.row)")
        let vc = PageViewController()
        itemid = items.map{$0.item_id}
        
        if let index = items.firstIndex(where: { $0 === filteredItems[indexPath.row] }){
            vc.current = index
            vc.itemid = itemid
            print("itemid\(itemid)")
            print(" Current\(vc.current)")
            print(items)
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("ITEMCOUNT\(items.count)")
            return filteredItems.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ReceiverTableViewCell
            print("index patH \(indexPath)")
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.item = filteredItems[indexPath.row]
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130
        }
    
}
