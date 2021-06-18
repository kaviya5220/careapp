//
//  ReceiverViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit


class ReceiverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UITabBarControllerDelegate, UISearchBarDelegate,UISearchResultsUpdating {
    
    public var items : [Item] = []
    public var filteredItems : [Item] = []
    var filteredArray :[String] = []
    var data : [String] = []
    var filteredData : [String]!
    var text:String = ""
    let receiverTableView = UITableView()
    var db = DBHelper()
    var searchController : UISearchController!
        func updateSearchResults(for searchController: UISearchController) {
            let searchString = searchController.searchBar.text
                filteredArray = data.filter({ (itemname) -> Bool in
                    let itemText: NSString = itemname as NSString
                    return (itemText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                }
                )
            let count  = 0...items.count-1
            if(filteredArray.count != 0){
                filteredItems = []
                for i in count {
                    if(filteredArray.contains(items[i].item_name)){
                        filteredItems.append(items[i])
                    }
                }
                receiverTableView.reloadData()
            }
            
            else if(filteredArray.count == 0 && searchString == ""){
                filteredItems = items
                receiverTableView.reloadData()
            }

            else if(filteredArray.count == 0 && searchString != ""){
                filteredItems = []
                receiverTableView.reloadData()
            }
        }
    

    func reload(){
        print("reload")
       // db = DBHelper()
        items = DBHelper.getitems()
        let count=1...items.count-1
        for i in count {
            print(items[i].item_name)
            data.append(items[i].item_name)
        }
        filteredItems = items
        print(items.count)
        receiverTableView.reloadData()
    }
    override func viewWillAppear(_ Animated : Bool) {
        super.viewWillAppear(Animated)
        
        
            print("view will appear")
            db = DBHelper()
        items = DBHelper.getitems()
        let count=1...items.count-1
//
        for i in count {
            print(items[i].item_name)
            data.append(items[i].item_name)
        }
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

        //

                    // The object responsible for updating the contents of the search results controller.

                    searchController.searchResultsUpdater = self

        

                searchController.searchBar.placeholder = "Search by Item Name"

        

                    // Determines whether the underlying content is dimmed during a search.

                    // if we are presenting the display results in the same view, this should be false

                    searchController.dimsBackgroundDuringPresentation = false

        

                    // Make sure the that the search bar is visible within the navigation bar.

                    searchController.searchBar.sizeToFit()

        

                    // Include the search controller's search bar within the table's header view.

                   receiverTableView.tableHeaderView = searchController.searchBar

        

                    definesPresentationContext = true

        
        
        
        
             
        
        
        
        
            
            receiverTableView.dataSource = self
            receiverTableView.delegate = self
            receiverTableView.register(ReceiverTableViewCell.self, forCellReuseIdentifier: "itemcell")
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailItemViewController()
        vc.itemid = items[indexPath.row].item_id
        vc.modalPresentationStyle = .automatic //or .overFullScreen for transparency
        //vc.isModalInPresentation = true
        //print("Name\(items[indexPath.row].item_name)")
        self.present(vc, animated: true, completion: nil)
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("ITEMCOUNT\(items.count)")
            return filteredItems.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ReceiverTableViewCell
            print("index patH \(indexPath)")
            cell.item = Item(item_id: filteredItems[indexPath.row].item_id, item_name: filteredItems[indexPath.row].item_name, item_description: filteredItems[indexPath.row].item_description, item_quantity: filteredItems[indexPath.row].item_quantity, address:filteredItems[indexPath.row].address, Donar_ID: filteredItems[indexPath.row].Donar_ID)
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
}
