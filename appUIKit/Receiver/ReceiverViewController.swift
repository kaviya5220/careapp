//
//  ReceiverViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit


class ReceiverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchResultsUpdating,canReceive,UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate,updateItems {
    internal var barButton: UIBarButtonItem!
    var someVariable : Bool = false
    var db = DBHelper()
    public var itemid : [Int] = []
    public var totalDetails : [ItemDetails] = []
    var item_images : [Item_Image] =  []
    var filteredTotalDetails : [ItemDetails] = []
    var filtered_item_images : [Item_Image] =  []
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
                filteredTotalDetails = totalDetails
                filtered_item_images = item_images
            }
            else{
                filtered_item_images = []
                filteredTotalDetails = totalDetails.filter({$0.item_name.lowercased().contains(searchString!.lowercased()) || $0.address.contains(searchString!.lowercased()) || $0.category.contains(searchString!.lowercased())})
                for item in item_images{
                    if(filteredTotalDetails.map{$0.item_id}.contains(item.item_id)){
                        filtered_item_images.append(item)
                    }
                }
                
               
            }
            receiverTableView.reloadData()
        }
   
    @objc func didTapAdd(_ sender: UIButton) {
        if(receiverInteractor.isLoggedIn()){
        let addItem = AddItemTableViewController()
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
        let combined = zip(totalDetails,filtered_item_images).sorted(by: {$0.0.item_name > $1.0.item_name})
        let s1 = combined.map {$0.0}
        let s2 = combined.map {$0.1}
        totalDetails = s1
        filteredTotalDetails = s1
        item_images = s2
        filtered_item_images = s2
        receiverTableView.reloadData()
    }
    @objc func sortDateDescending(){
       
        let combined = zip(totalDetails,filtered_item_images).sorted(by: {$0.0.date > $1.0.date})
        let s1 = combined.map {$0.0}
        let s2 = combined.map {$0.1}
        totalDetails = s1
        filteredTotalDetails = s1
        item_images = s2
        filtered_item_images = s2
        receiverTableView.reloadData()
    }
    @objc func sortDateAscending(){
        
        let combined = zip(totalDetails,filtered_item_images).sorted(by: {$0.0.date < $1.0.date})
        let s1 = combined.map {$0.0}
        let s2 = combined.map {$0.1}
        totalDetails = s1
        filteredTotalDetails = s1
        item_images = s2
        filtered_item_images = s2
        receiverTableView.reloadData()
    }
    @objc func sortNameAscending(){
       
        let combined = zip(totalDetails,filtered_item_images).sorted(by: {$0.0.item_name < $1.0.item_name})
        let s1 = combined.map {$0.0}
        let s2 = combined.map {$0.1}
        totalDetails = s1
        filteredTotalDetails = s1
        item_images = s2
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        receiverTableView.reloadData()
    }

    override func viewDidLoad() {
        //super.viewDidLayoutSubviews()
        //super.viewWillAppear(Animated)
        super.viewDidLoad()
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
        receiverTableView.register(FoodTableViewCell.self, forCellReuseIdentifier: "foodCell")
        receiverTableView.register(BookTableViewCell.self, forCellReuseIdentifier: "bookCell")
        receiverTableView.register(ClothTableViewCell.self, forCellReuseIdentifier: "clothCell")
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
        i = 0
        j = 0
        k = 0
        loaditems()
        self.refreshControl.endRefreshing()
        receiverTableView.reloadData()
        //self..stopAnimating()
    }
    var i : Int = 0
    var j : Int = 0
    var k : Int = 0
     func loaditems(){
        DispatchQueue.global(qos:.background).async {
            var itemlist:[Item] = []
                  //  print("asnccc")
                    itemlist = self.receiverInteractor.getitemdetails()
            var foodItems : [Food] = []
            foodItems = self.receiverInteractor.getFood()
            var bookItems : [Books] = []
            bookItems = self.receiverInteractor.getBooks()
            var clothItems : [Cloth] = []
            clothItems = self.receiverInteractor.getCloth()
           
                DispatchQueue.main.async(execute: {
//                    self.totalDetails = itemlist
//                    self.filteredTotalDetails = itemlist
                   
                    for item in itemlist{
                        if(item.category == "Food"){
                            var foodDesc : [String] = ["","","","",""]
                            foodDesc[0] = foodItems[self.i].expiry_date
                            foodDesc[1] = foodItems[self.i].cusine
                            foodDesc[2] = foodItems[self.i].vegnonveg
                            foodDesc[3] = String(foodItems[self.i].quantity)
                            foodDesc[4] = foodItems[self.i].others
                            self.totalDetails.append(ItemDetails(item_id: item.item_id, item_name: item.item_name, item_image: "", category: item.category, address: item.address, Donar_ID: item.Donar_ID, visited_count: item.visited_count, date: item.date, description: foodDesc))
                            self.i = self.i + 1
                        }
                        else if(item.category == "Book"){
                            var bookDesc : [String] = ["","","","",""]
                            bookDesc[0] = bookItems[self.j].author
                            bookDesc[1] = bookItems[self.j].publisher
                            bookDesc[2] = bookItems[self.j].year_of_publish
                            bookDesc[3] = String(bookItems[self.j].quantity)
                            bookDesc[4] = bookItems[self.j].others
                            self.totalDetails.append(ItemDetails(item_id: item.item_id, item_name: item.item_name, item_image: "", category: item.category, address: item.address, Donar_ID: item.Donar_ID, visited_count: item.visited_count, date: item.date, description: bookDesc))
                            self.j = self.j + 1
                        }
                        else if(item.category == "Cloth"){
                            var clothDesc : [String] = ["","","","",""]
                            clothDesc[0] = clothItems[self.k].size
                            clothDesc[1] = clothItems[self.k].clothCategory
                            clothDesc[2] = clothItems[self.k].gender
                            clothDesc[3] = String(clothItems[self.k].quantity)
                            clothDesc[4] = clothItems[self.k].others
                            self.totalDetails.append(ItemDetails(item_id: item.item_id, item_name: item.item_name, item_image: "", category: item.category, address: item.address, Donar_ID: item.Donar_ID, visited_count: item.visited_count, date: item.date, description: clothDesc))
                            self.k = self.k + 1
                        }
                    }
                    self.filteredTotalDetails =  self.totalDetails
                   self.receiverTableView.reloadData()
                })
            }
      
        DispatchQueue.global(qos:.background).async {
            var item_images_list : [Item_Image] = []
                 //   print("image  asnccc")
            item_images_list = self.receiverInteractor.getItemImages()

            DispatchQueue.main.async(execute: {
//                print("Image")
                    self.item_images = item_images_list
                self.filtered_item_images = item_images_list
                    self.receiverTableView.reloadData()
                })
            
        }
        
     
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailItemTableViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        let vc = DetailItemTableViewController()
        itemid = totalDetails.map{$0.item_id}

        if let index = totalDetails.firstIndex(where: { $0 === filteredTotalDetails[indexPath.row] }){
//            vc.current = index
            totalDetails[index].visited_count = totalDetails[index].visited_count + 1
            vc.itemid = totalDetails[index].item_id
            vc.itemDetailValues[0] = totalDetails[index].item_name
            vc.itemDetailValues[1] = totalDetails[index].category
            vc.itemDetailValues[2] = totalDetails[index].address
            vc.itemDetailValues[3] = String(totalDetails[index].Donar_ID)
            vc.descValues = totalDetails[index].description
            print(item_images.map{$0.item_image}[index])
            vc.item_image = item_images.map{$0.item_image}[index]
            self.navigationController?.pushViewController(vc, animated: true)
        }
//
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(filteredTotalDetails.count == 0){
                noItemAvailable.isHidden = false
                receiverTableView.isHidden = true
            }
            else{
                noItemAvailable.isHidden = true
                receiverTableView.isHidden = false
            }
            
            return filteredTotalDetails.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print("item det item id\(filteredTotalDetails[indexPath.row].item_id)")
            
//            print(filteredItems[indexPath.row].category)
            if(filteredTotalDetails[indexPath.row].category == "Food"){
                
//                print("ss\(filtered_foodItems[foodIterator].item_id)")
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell
                cell.item = filteredTotalDetails[indexPath.row]
            
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
    else  if(filteredTotalDetails[indexPath.row].category == "Book"){
    let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        cell.item = filteredTotalDetails[indexPath.row]
    
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
    else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "clothCell", for: indexPath) as! ClothTableViewCell
            cell.item = filteredTotalDetails[indexPath.row]
        
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
    func passData(item: Item,item_image : String,description : [String]) {
//        totalDetails.append(item)
        totalDetails.append(ItemDetails(item_id: item.item_id, item_name: item.item_name, item_image: item_image, category: item.category, address: item.address, Donar_ID: item.Donar_ID, visited_count: item.visited_count, date: item.date, description: description))
        item_images.append(Item_Image(item_id: item.item_id, item_image: item_image))
//        if(item.category == "Food") {
//        let food:Food = Food(expiry_date: description[0], cusine: description[1], vegnonveg: description[2], quantity: Int(description[3])!, others: description[4])
//        foodItems.append(food)
//            filtered_foodItems = foodItems
//        }
//        else if(item.category == "Book") {
//        let book:Books = Books(author: description[0], publisher: description[1], year_of_publish : description[2], quantity: Int(description[3])!, others: description[4])
//        bookItems.append(book)
//            filtered_bookItems = bookItems
//        }
        filtered_item_images = item_images
        filteredTotalDetails = totalDetails
//        print(fi)
        sortNameAscending()
        receiverTableView.reloadData()
    }
    func updateItem(itemid : Int) {
//        print("updelegate")
//        filteredItems.remove(at: filteredItems.firstIndex(of: 1))
        if let idx = totalDetails.firstIndex(where: { $0.item_id == itemid }) {

            totalDetails.remove(at: idx)
            
        }
        if let idx = item_images.firstIndex(where: { $0.item_id == itemid }) {

            item_images.remove(at: idx)
        }
        filtered_item_images = item_images
        filteredTotalDetails = totalDetails
        sortNameAscending()
        receiverTableView.reloadData()
    }
}

