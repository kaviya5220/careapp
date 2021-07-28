//
//  ReceiverViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit


class ReceiverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchResultsUpdating,canReceive,UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate,updateItems {
    internal var barButton: UIBarButtonItem!
    var someVariable = true
   // var someVariable1 = false
    var db = DBHelper()
    public var itemid : [Int] = []
    public var items : [Item] = []
    public var filteredItems : [Item] = []
    var item_images : [Item_Image] =  []
    var filtered_item_images : [Item_Image] =  []
    var current_search : String =  ""
    let receiverInteractor = ReceiverInteractor()
    let receiverTableView = UITableView()
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
    let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    let refreshControl = UIRefreshControl()
    var nameToggle : Bool = true
    var dateToggle : Bool = true
    
    var menuItems: [UIAction] {
        return [
            UIAction(title: "Name", image: UIImage(systemName: "arrow.up.arrow.down"),state: self.someVariable == true ? .on : .off){ _ in
                self.someVariable = false
                self.sortName()
                //action.image = nil
            },
            UIAction(title: "Date Posted", image: UIImage(systemName: "arrow.up.arrow.down"),state: self.someVariable ? .off : .on) { _ in
                print(self.someVariable)
                self.someVariable = true
                self.sortDate()
            },
        ]
    }

    var demoMenu: UIMenu {
        return UIMenu(title: "Sort", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    let noItemAvailable:CustomLabel = {
        let label = CustomLabel(labelType: .title)
        label.text = "No Items Available"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    var searchController : UISearchController!
        func updateSearchResults(for searchController: UISearchController) {
            let searchString = searchController.searchBar.text
            if(searchString == ""){
                filteredItems = items
                filtered_item_images = item_images
            }
            else{
                filtered_item_images = []
            filteredItems = items.filter({$0.item_name.contains(searchString!) || $0.address.contains(searchString!) || $0.item_description.contains(searchString!)})
                for item in item_images{
                    if(filteredItems.map{$0.item_id}.contains(item.item_id)){
                        filtered_item_images.append(item)
                    }
                }
                print(filtered_item_images)
            }
            receiverTableView.reloadData()
        }
   
    @objc func didTapAdd(_ sender: UIButton) {
        if(receiverInteractor.isLoggedIn()){
        let addItem = AddItemViewController()
        let vc = UINavigationController()
        vc.viewControllers = [addItem]
        vc.modalPresentationStyle = .automatic //or .overFullScreen for transparency
        addItem.delegate = self
        self.present(vc, animated: true, completion: nil)
        }
        else{
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        }
    @objc func navigateToProfile(_ sender: UIButton) {
        if(receiverInteractor.isLoggedIn()){
            let vc = ProfileViewController()
            vc.delagate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
    @objc func sortNameDescending(){
        let combined = zip(items,filtered_item_images).sorted(by: {$0.0.item_name > $1.0.item_name})
        let s1 = combined.map {$0.0}
        let s2 = combined.map {$0.1}
        items = s1
        filteredItems = s1
        filtered_item_images = s2
        receiverTableView.reloadData()
    }
    @objc func sortDateDescending(){
       
        let combined = zip(items,filtered_item_images).sorted(by: {$0.0.date > $1.0.date})
        let s1 = combined.map {$0.0}
        let s2 = combined.map {$0.1}
        items = s1
        filteredItems = s1
        filtered_item_images = s2
        receiverTableView.reloadData()
    }
    @objc func sortDateAscending(){
        
        let combined = zip(items,filtered_item_images).sorted(by: {$0.0.date < $1.0.date})
        let s1 = combined.map {$0.0}
        let s2 = combined.map {$0.1}
        items = s1
        filteredItems = s1
        filtered_item_images = s2
        receiverTableView.reloadData()
    }
    @objc func sortNameAscending(){
       
        let combined = zip(items,filtered_item_images).sorted(by: {$0.0.item_name < $1.0.item_name})
        let s1 = combined.map {$0.0}
        let s2 = combined.map {$0.1}
        items = s1
        filteredItems = s1
        filtered_item_images = s2
        receiverTableView.reloadData()
    }
    @objc func sortName()
    {
        menuItems[1].image = nil
        switch (nameToggle){
        case true:
            sortNameDescending()
            nameToggle.toggle()
        case false:
            sortNameAscending()
            nameToggle.toggle()
        }
        
    }
    @objc func sortDate()
    {
        switch (dateToggle){
        case true:
            sortDateDescending()
            dateToggle.toggle()
        case false:
            sortDateAscending()
            dateToggle.toggle()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.receiverTableView.reloadData()
      
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //super.viewWillAppear(Animated)
        //super.viewDidLoad()
      //  let add1 = UIBarButtonItem(barButtonSystemItem: , target: self, action: #selector(didTapAdd(_:)))
        let leftBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(navigateToProfile(_:)))
        let sorticon = UIBarButtonItem(title: "sort", image: nil, primaryAction: nil, menu: demoMenu)
        
       
        let add = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(didTapAdd(_:)))
        navigationItem.rightBarButtonItems = [add,sorticon]
        let addIcon = UIImage(systemName: "plus")
        add.image = addIcon
        let filterIcon = UIImage(systemName: "arrow.up.arrow.down")
        sorticon.image = filterIcon
        
        let buttonIcon = UIImage(systemName: "person.crop.circle")
        leftBarButton.image = buttonIcon
        navigationItem.leftBarButtonItem = leftBarButton
        loaditems()
        
        
        view.backgroundColor = .white
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.searchBar.placeholder = "Search"
            searchController.obscuresBackgroundDuringPresentation = false
            navigationItem.hidesSearchBarWhenScrolling = false
//            searchController.searchBar.scopeButtonTitles = searchArray
            searchController.searchBar.sizeToFit()
          //  receiverTableView.tableHeaderView = searchController.searchBar
        navigationItem.searchController = searchController
            definesPresentationContext = true
        searchController.searchBar.delegate = self
            
        
        
        
        receiverTableView.dataSource = self
        receiverTableView.delegate = self
        receiverTableView.register(ReceiverTableViewCell.self, forCellReuseIdentifier: "itemcell")
        receiverTableView.register(Receiver1TableViewCell.self, forCellReuseIdentifier: "itemcell1")
        receiverTableView.estimatedRowHeight = 370.0
        receiverTableView.rowHeight = UITableView.automaticDimension
        receiverTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshItem(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Items ...", attributes: nil)
        view.addSubview(noItemAvailable)
        view.addSubview(receiverTableView)
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        receiverTableView.translatesAutoresizingMaskIntoConstraints = false
        noItemAvailable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noItemAvailable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        receiverTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
        receiverTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        receiverTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        receiverTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        }
    @objc func refreshItem(_ sender : Any){
        loaditems()
        self.refreshControl.endRefreshing()
        //self..stopAnimating()
    }
     func loaditems(){
        DispatchQueue.global(qos:.background).async {
            var itemlist:[Item] = []
                  //  print("asnccc")
                    itemlist = self.receiverInteractor.getitemdetails()

                DispatchQueue.main.async(execute: {
                    self.items = itemlist
                    self.filteredItems = itemlist
                   self.receiverTableView.reloadData()
                })
            }

        DispatchQueue.global(qos:.background).async {
            var item_images_list : [Item_Image] = []
                 //   print("image  asnccc")
            item_images_list = self.receiverInteractor.getItemImages()

            DispatchQueue.main.async(execute: {
                print("Image")
                    self.item_images = item_images_list
                self.filtered_item_images = item_images_list
                    self.receiverTableView.reloadData()
                })
            
        }
        
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
            if(filteredItems.count == 0){
                noItemAvailable.isHidden = false
                receiverTableView.isHidden = true
            }
            else{
                noItemAvailable.isHidden = true
                receiverTableView.isHidden = false
            }
            
            return filteredItems.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ReceiverTableViewCell
            cell.item = filteredItems[indexPath.row]
            let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            
            if(filtered_item_images.count >= indexPath.row && filtered_item_images.count != 0) {
            if let dirPath = paths.first{
                let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(filtered_item_images[indexPath.row].item_image)
                if(filtered_item_images[indexPath.row].item_image != "") {
                    cell.itemimage.image = UIImage(contentsOfFile: imageURL.path) }
                else {
                    cell.itemimage.image = UIImage(named: "loadingimage") 
                }
            }
                
           
            }
                return cell }
            else{let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell1", for: indexPath) as! Receiver1TableViewCell
                cell.item = filteredItems[indexPath.row]
                let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                
                if(filtered_item_images.count >= indexPath.row && filtered_item_images.count != 0) {
                if let dirPath = paths.first{
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(filtered_item_images[indexPath.row].item_image)
                    if(filtered_item_images[indexPath.row].item_image != "") {
                        cell.itemimage.image = UIImage(contentsOfFile: imageURL.path) }
                    else {
                        cell.itemimage.image = UIImage(named: "loadingimage")
                    }
                }
                    
               
                }
                    return cell
                
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func passData(item: Item,item_image : String) {
        items.append(item)
        item_images.append(Item_Image(item_id: item.item_id, item_image: item_image))
        filtered_item_images = item_images
        filteredItems = items
        sortNameAscending()
        receiverTableView.reloadData()
    }
    func updateItem(itemid : Int) {
        print("updelegate")
//        filteredItems.remove(at: filteredItems.firstIndex(of: 1))
        if let idx = items.firstIndex(where: { $0.item_id == itemid }) {

            items.remove(at: idx)
            
        }
        if let idx = item_images.firstIndex(where: { $0.item_id == itemid }) {

            item_images.remove(at: idx)
        }
        filtered_item_images = item_images
        filteredItems = items
        sortNameAscending()
        receiverTableView.reloadData()
    }
}

