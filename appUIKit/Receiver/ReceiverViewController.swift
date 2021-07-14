//
//  ReceiverViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit


class ReceiverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchResultsUpdating,canReceive,UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate,updateItems {
    
   
    
    var db = DBHelper()
    public var itemid : [Int] = []
    public var items : [Item] = []
    public var filteredItems : [Item] = []
    var item_images : [Item_Image] =  []
    var filtered_item_images : [Item_Image] =  []
    var current_search : String =  ""
    let searchArray : [String] = ["Item Name","Location"]
    let receiverInteractor = ReceiverInteractor()
    let receiverTableView = UITableView()
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
    let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    
    let noItemAvailable:CustomLabel = {
        let label = CustomLabel(labelType: .title)
        label.text = "No Items Available"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private var actionSheet: UIAlertController {
        let actionSheet = UIAlertController(
            title: "Sort By",
            message: "",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(.init(
            title: "Name Ascending",
            style: .default,
            handler: { _ in self.sortNameAscending() }
        ))
        actionSheet.addAction(.init(
            title: "Name Descending",
            style: .default,
            handler: { _ in  self.sortNameDescending()}
        ))
        actionSheet.addAction(.init(
            title: "Date Ascending",
            style: .default,
            handler: { _ in self.sortDateAscending() }
        ))
        actionSheet.addAction(.init(
            title: "Date Descending",
            style: .default,
            handler: { _ in self.sortDateDescending() }
        ))
        actionSheet.addAction(.init(
            title: "Cancel",
            style: .destructive,
            handler: { _ in self.dismiss(animated: true) }
        ))
        return actionSheet
    }

   
    var searchController : UISearchController!
        func updateSearchResults(for searchController: UISearchController) {
            let searchString = searchController.searchBar.text
            if(searchString == ""){
                filteredItems = items
                filtered_item_images = item_images
            }
            
            else if(current_search == "Location"){
                filtered_item_images = []
            filteredItems = items.filter({$0.address.contains(searchString!)})
                for item in item_images{
                    if(filteredItems.map{$0.item_id}.contains(item.item_id)){
                        filtered_item_images.append(item)
                    }
                }
                print(filtered_item_images)
            }
            else{
                filtered_item_images = []
            filteredItems = items.filter({$0.item_name.contains(searchString!)})
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
    @objc func didTapFilter(_ sender: UIButton) {
        print("clicked")
        self.present(actionSheet,animated: true)
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
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        //print(filteredItems)
//        filteredItems = items
//        receiverTableView.reloadData()
//
//    }
        
    
    override func viewDidLoad() {
        //super.viewWillAppear(Animated)
        super.viewDidLoad()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd(_:)))
        let leftBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(navigateToProfile(_:)))
        let filter = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(didTapFilter(_:)))
        navigationItem.rightBarButtonItems = [add,filter]
        let filterIcon = UIImage(systemName: "arrow.up.arrow.down")
        filter.image = filterIcon
        let buttonIcon = UIImage(systemName: "person.circle")
        leftBarButton.image = buttonIcon
        navigationItem.leftBarButtonItem = leftBarButton
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
                    self.item_images = item_images_list
                self.filtered_item_images = item_images_list
                    self.receiverTableView.reloadData()
                })
            
        }
        
        
        view.backgroundColor = .white
        view.addSubview(noItemAvailable)
            view.addSubview(receiverTableView)
        noItemAvailable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noItemAvailable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
            receiverTableView.translatesAutoresizingMaskIntoConstraints = false
        
            receiverTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 10).isActive = true
            receiverTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
            receiverTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
            receiverTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.searchBar.placeholder = "Search"
            searchController.obscuresBackgroundDuringPresentation = false
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.searchBar.scopeButtonTitles = searchArray
            searchController.searchBar.sizeToFit()
          //  receiverTableView.tableHeaderView = searchController.searchBar
        navigationItem.searchController = searchController
            definesPresentationContext = true
        searchController.searchBar.delegate = self
            receiverTableView.dataSource = self
            receiverTableView.delegate = self
            receiverTableView.register(ReceiverTableViewCell.self, forCellReuseIdentifier: "itemcell")
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        }
    
   
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        current_search = searchArray[selectedScope]
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ReceiverTableViewCell
            cell.item = filteredItems[indexPath.row]
            let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if let dirPath = paths.first{
                let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(filtered_item_images[indexPath.row].item_image)
                cell.itemimage.image = UIImage(contentsOfFile: imageURL.path)
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 370
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

