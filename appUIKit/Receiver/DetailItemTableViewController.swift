//
//  DetailItemTableViewController.swift
//  appUIKit
//
//  Created by sysadmin on 03/08/21.
//

import UIKit

class DetailItemTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let detailTableView = UITableView()
    var itemid : Int = 0
    var itemLabels : [String] = ["Name","Category","Address"]
    var donorLables : [String] = ["Name","Email","Phone"]
    var itemDetailValues : [String] = ["","","","",""]
    var descLabels : [String:[String]] = ["Book":["Author","Publisher","Year","Quantity","Others"],"Food":["Accompaniments","Cuisine","Veg/NonVeg","Quantity","Others"],"Cloth":["Size","Material","Gender","Quantity","Others"]]
    var descValues : [String] = ["","","","",""]
    var donorValues : [String] = ["","",""]
    var item_image : String = ""
    public var user: User = User()
    let  receiverInteractor = ReceiverInteractor()
    
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
    let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    
    
    
    
    var request = UIBarButtonItem()

    override func viewWillAppear(_ animated : Bool) {
        super.viewWillAppear(animated)
        setupConstraints()
        request = UIBarButtonItem(title: "Request", style: .plain, target: self, action: #selector(requestitem(_:)))
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "itemdetails")
        detailTableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "description")
        detailTableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "donordetails")
        detailTableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "itemimage")
        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailTableView)
        view.backgroundColor = .white
        receiverInteractor.updateVisitedCount(ID: itemid)
        loadDonorDetails(donor_id: Int(itemDetailValues[3])!)
        self.navigationItem.title = itemDetailValues[0]
        self.navigationItem.rightBarButtonItem = request
        
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
        
        

    }
    @objc func requestitem(_ sender: UIButton) {
        if(receiverInteractor.isLoggedIn()){
        let userdefaults = UserDefaults.standard
        let userid = userdefaults.integer(forKey: "userid")
            
            if(userid == Int(itemDetailValues[3])){
                showToast(message: "You are the Donar", font: .systemFont(ofSize: 12))
                request.isEnabled = false
            }
            else if(receiverInteractor.getdonationstatus(Receiver_ID: userid, Item_ID: itemid) == "pending"){
                showToast(message: "Request Already Made", font: .systemFont(ofSize: 12))
                request.isEnabled = false
            }
            else{
                let donation : Donationstatus = Donationstatus(item_id: itemid , Donar_ID: Int(itemDetailValues[3])!, Receiver_ID: userid, status: "pending")
        receiverInteractor.insertdonation(donation: donation)
        self.navigationController?.pushViewController(ReceiverViewController(), animated: true)
        }
        }
        else{
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
//    func loadItemByCategory(category:String){
//       
//            var itemdesc = [String]()
//            switch category{
//            case "Book":
//                itemdesc = self.receiverInteractor.getBookDetails(itemid: self.itemid)
//            case "Food":
//                itemdesc = self.receiverInteractor.getFoodDetails(itemid: self.itemid)
//            case "Cloth":
//                itemdesc = self.receiverInteractor.getClothDetails(itemid: self.itemid)
//            default:
//                break
//            }
//         self.descValues = itemdesc
//         self.detailTableView.reloadData()
//    
//    }

    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: 150))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: 150))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    func loadDonorDetails(donor_id:Int){
        var donorVal : User = User()
            donorVal = self.receiverInteractor.getdonardetails(ID: donor_id)

            donorValues[0] = donorVal.user_name
            donorValues[1] = donorVal.user_email
            donorValues[2] = donorVal.user_phone
             self.detailTableView.reloadData()
        }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
           return 1
        }
        else if(section == 1){
            return 3
        }
        else if(section == 2){
            return 5
        }
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = detailTableView.dequeueReusableCell(withIdentifier: "itemimage", for: indexPath) as! ImageTableViewCell
            cell.selectionStyle = .none
            let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if item_image != "" {
            if let dirPath = paths.first{
                let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(item_image)
                cell.itemimage.image = resizeImage(image: UIImage(contentsOfFile: imageURL.path)!, newWidth: 200)
                
            
        }
            }
            return cell
            
        }
        else if(indexPath.section == 1){
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "itemdetails", for: indexPath) as! TextFieldTableViewCell
        cell.label.text = itemLabels[indexPath.row]
            cell.selectionStyle = .none
            cell.label1.textAlignment = .right
            cell.label1.numberOfLines = 0
            cell.label1.lineBreakMode = .byWordWrapping
            
            cell.label1.text = itemDetailValues[indexPath.row]
        return cell
        }
       else if(indexPath.section == 2){
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "description", for: indexPath) as! TextFieldTableViewCell
        cell.selectionStyle = .none
        if itemDetailValues[1] != "" && !descValues.isEmpty{
            cell.label.text = descLabels[itemDetailValues[1]]![indexPath.row]
            cell.label1.textAlignment = .right
            cell.label1.numberOfLines = 0
            cell.label1.lineBreakMode = .byWordWrapping
            
            cell.label1.text = descValues[indexPath.row]
            
        }
        return cell
    
        }
       else {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "donordetails", for: indexPath) as! TextFieldTableViewCell
        cell.selectionStyle = .none
        if itemDetailValues[3] != "" {
            cell.label.text = donorLables[indexPath.row]
            cell.label1.textAlignment = .right
            cell.label1.numberOfLines = 0
            cell.label1.lineBreakMode = .byWordWrapping
            cell.label1.text = donorValues[indexPath.row]
            
        }
        
        
        return cell
        }
    }
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//
//
//            return nil
//        }
       
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       if(section == 1){
            return "Item Details"
        }
        else if(section == 2){
            return "Description"
        }
        else if(section == 3){
        return "Donar Details"
        }
        return ""
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 1){
            return 80
        }
        else if(indexPath.section == 2){
            return 60
        }
        else if(indexPath.section == 0){
            return 170
        }
        return 60
    
    }
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
}
extension DetailItemTableViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints:sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
    }
    private func setupConstraints() {

        sharedConstraints.append(contentsOf: [
        ])



        compactConstraints.append(contentsOf: [
            detailTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 20),
            detailTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            detailTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            detailTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            
            //itemimage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            //itemimage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 30),

        ])

        regularConstraints.append(contentsOf: [
            detailTableView.topAnchor.constraint(equalTo:view.topAnchor,constant: 10),
            detailTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            detailTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            detailTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
}
