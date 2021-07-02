//
//  ReceiverViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit


class ReceiverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchResultsUpdating,canReceive,UINavigationControllerDelegate {
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
   
    @objc func didTapAdd(_ sender: UIButton) {
        let addItem = AddItemViewController()
        let vc = UINavigationController()
        vc.viewControllers = [addItem]
        vc.modalPresentationStyle = .automatic //or .overFullScreen for transparency
        addItem.delegate = self
        self.present(vc, animated: true, completion: nil)
        print("Hello")
        }
    @objc func navigateToProfile(_ sender: UIButton) {
        //	let addItem = AddItemViewController()
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
       print("hey")
        super.viewWillAppear(animated)
        filteredItems = items
        receiverTableView.reloadData()
        
    }
        
    
    override func viewDidLoad() {
        //super.viewWillAppear(Animated)
        super.viewDidLoad()
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd(_:)))
        navigationItem.rightBarButtonItem = add
        let buttonIcon = UIImage(systemName: "person.circle")
        let leftBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(navigateToProfile(_:)))
        leftBarButton.image = buttonIcon
        navigationItem.leftBarButtonItem = leftBarButton
        let userdefaults = UserDefaults.standard
        let userid = userdefaults.integer(forKey: "userid")
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
        let vc = PageViewController()
        itemid = items.map{$0.item_id}
        print(itemid)
        
        if let index = items.firstIndex(where: { $0 === filteredItems[indexPath.row] }){
            vc.current = index
            items[index].visited_count = items[index].visited_count + 1
            vc.itemid = itemid
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredItems.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ReceiverTableViewCell
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.item = filteredItems[indexPath.row]
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 350
        }
    func passData(item: Item) {
        items.append(item)
        filteredItems = items
        receiverTableView.reloadData()
    }
}
