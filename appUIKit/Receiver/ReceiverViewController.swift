//
//  ReceiverViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit
//protocol  category {
//    func category(category : String)
//}

class ReceiverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchResultsUpdating,canReceive,UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate,updateItems {
    //internal var barButton: UIBarButtonItem!
    lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    var someVariable : Bool = false
    var db = DBHelper()
    //var delegate : category?
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
    var someVariable1 : Bool = true
//    var addItems : [UIAction] {
//        var add : [UIAction] = []
//        add.append(UIAction(title: "Book", image: UIImage(named: "book"), handler: { _ in self.didTapAdd(category: "Book")}))
//        add.append(UIAction(title: "Cloth", image: UIImage(named: "cloth"), handler: { _ in self.didTapAdd(category: "Cloth")}))
//        add.append(UIAction(title: "Food", image: UIImage(named: "food"), handler: { _ in self.didTapAdd(category: "Food")}))
//        return add
//    }
    var menuItems: [UIAction] {
        var menu:[UIAction] = []
        
        if(nameToggle == true){
            menu.append(UIAction(title: "Name", image: UIImage(systemName: "arrow.up"),state: self.someVariable1 ? .on : .off){ _ in
                if(self.someVariable1 == false){
                    self.someVariable1 = true
                }
                if(self.someVariable == true){
                    self.someVariable = false
                }
                self.sortName()
                self.sorticon.menu = self.generateMenu()
            })
        }
        else{
            menu.append(UIAction(title: "Name", image: UIImage(systemName: "arrow.down"),state: self.someVariable1 ? .on : .off){ _ in
                if(self.someVariable1 == false){
                    self.someVariable1 = true
                }
                if(self.someVariable == true){
                    self.someVariable = false
                }
                self.sortName()
                self.sorticon.menu = self.generateMenu()
            })
        }
        if(dateToggle == true){
            menu.append(UIAction(title: "Date", image: UIImage(systemName: "arrow.up"),state: self.someVariable ? .on : .off){ _ in
                if(self.someVariable == false){
                    self.someVariable = true
                }
                if(self.someVariable1 == true){
                    self.someVariable1 = false
                }
                self.sortDate()
                self.sorticon.menu = self.generateMenu()
            })
        }
        else{
            menu.append(UIAction(title: "Date", image: UIImage(systemName: "arrow.down"),state: self.someVariable ? .on: .off){ _ in
//                self.someVariable.toggle()
                if(self.someVariable == false){
                    self.someVariable = true
                }
                if(self.someVariable1 == true){
                    self.someVariable1 = false
                }
                self.sortDate()
                self.sorticon.menu = self.generateMenu()
            })
        }
        return menu

    }
    func generateMenu() -> UIMenu {
        return UIMenu(title: "Sort", image: nil, identifier: nil, options: [], children: menuItems)
    }
//    func generateMenu1() -> UIMenu {
//        return UIMenu(title: "Add Item", image: nil, identifier: nil, options: [], children: addItems)
//    }
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
    
                filteredTotalDetails = totalDetails.filter({$0.item_name.lowercased().contains(searchString!.lowercased()) || $0.address.lowercased().contains(searchString!.lowercased()) || $0.category.lowercased().contains(searchString!.lowercased())})
               
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
            let vc = UINavigationController()
            let controller = AddItemViewController()
            vc.viewControllers = [controller]
            controller.delegate = self
            slideInTransitioningDelegate.direction = .right
            slideInTransitioningDelegate.origin = Int(self.navigationController!.navigationBar.frame.height)
            vc.transitioningDelegate = slideInTransitioningDelegate
            vc.modalPresentationStyle = .custom
           // vc.modalPresentationStyle = .automatic
            self.present(vc, animated: true, completion: nil)
//        let addItem = AddItemViewController()
//        let vc = UINavigationController()
//        vc.viewControllers = [addItem]
//        vc.modalPresentationStyle = .automatic //or .overFullScreen for transparency
//        addItem.delegate = self
//            //
//      //  addItem.categorychosen = category
//        self.present(vc, animated: true, completion: nil)
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
    var sorticon : UIBarButtonItem!
   // var addicon : UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftBarButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(navigateToProfile(_:)))
        
        sorticon = UIBarButtonItem(title: "sort", image: nil, primaryAction: nil, menu: generateMenu())
       // addicon = UIBarButtonItem(title: "Add", image: nil, primaryAction: nil, menu: generateMenu1())
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
        receiverTableView.separatorStyle = .none
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
        totalDetails = []
        filteredTotalDetails = []
        item_images = []
        filtered_item_images = []
        nameToggle = true
        dateToggle  = true
        someVariable = false
        someVariable1  = true
        self.sorticon.menu = self.generateMenu()
        loaditems()
        self.refreshControl.endRefreshing()
        receiverTableView.reloadData()
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
                 //   print(itemlist.map{$0.item_name})
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
               // print(self.filtered_item_images)
                    self.receiverTableView.reloadData()
                })
            
        }
        
     
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        itemid = totalDetails.map{$0.item_id}
        if let index = totalDetails.firstIndex(where: { $0 === filteredTotalDetails[indexPath.row] }){
            totalDetails[index].visited_count = totalDetails[index].visited_count + 1
          //  vc.itemid = totalDetails[index].item_id
            vc.item = totalDetails[index]
            vc.item.item_image = filtered_item_images[indexPath.row].item_image
//            vc.itemDetailValues[0] = totalDetails[index].item_name
//            vc.itemDetailValues[1] = totalDetails[index].category
//            vc.itemDetailValues[2] = totalDetails[index].address
//            vc.itemDetailValues[3] = String(totalDetails[index].Donar_ID)
//            vc.descValues = totalDetails[index].description
            //vc.item_image = item_images.map{$0.item_image}[index]
          //  vc.item.item_image = filtered_item_images.map{$0.item_image}[index]
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
            
            if(filteredTotalDetails[indexPath.row].category == "Food"){
                
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
        filtered_item_images = item_images
        filteredTotalDetails = totalDetails
//        print(fi)
        sortNameAscending()
        receiverTableView.reloadData()
    }
    func updateItem(itemid : Int) {
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

