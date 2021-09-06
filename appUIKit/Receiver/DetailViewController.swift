//
//  DetailViewController.swift
//  appUIKit
//
//  Created by Kaviya M on 31/08/21.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UIViewControllerTransitioningDelegate {
    var item : ItemDetails = ItemDetails( description: [])
    let detailView = UITableView()
    var item_image : String = ""
    var donorValues : [String] = ["","",""]
    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
    let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
    let receiverInteractor = ReceiverInteractor()
    
    let requestbutton:UIButton = {
        let button = CustomButton(title: "REQUEST", bgColor: .systemBlue)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(requestitem(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        loadDonorDetails(donor_id: item.Donar_ID)
        view.backgroundColor = .white
        detailView.dataSource = self
        detailView.delegate = self
        detailView.estimatedRowHeight = 370.0
        detailView.rowHeight = UITableView.automaticDimension
        detailView.register(ProductImageTableViewCell.self, forCellReuseIdentifier: "image")
        detailView.register(NameTableViewCell.self, forCellReuseIdentifier: "name")
        detailView.register(PublisherTableViewCell.self, forCellReuseIdentifier: "publisher")
        detailView.register(AboutTableViewCell.self, forCellReuseIdentifier: "about")
        detailView.register(profileTableViewCell.self, forCellReuseIdentifier: "profile")
        detailView.register(quantityTableViewCell.self, forCellReuseIdentifier: "quantity")
        detailView.register(sizeTableViewCell.self, forCellReuseIdentifier: "size")
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.separatorStyle = .none
        view.addSubview(detailView)
        view.addSubview(requestbutton)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.shadowImage = UIImage()
      //  self.navigationController?.navigationBar.backIndicatorImage = .remove
//        let yourBackImage = UIImage(systemName: "lessthan")
//        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
//        self.navigationController?.navigationBar.backItem?.title = "Custom"
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "lessthan.circle")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        //self.navigationItem.backButtonTitle = "custom"
//
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)

    }
    @objc func viewProfleClicked(_ sender: UITapGestureRecognizer){
        let vc = DonarprofileViewController()
        vc.donar_id = item.Donar_ID
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        //self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        self.present(vc, animated: true, completion: nil)
     

    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
    @objc func requestitem(_ sender: UIButton) {
            if(receiverInteractor.isLoggedIn()){
            let userdefaults = UserDefaults.standard
            let userid = userdefaults.integer(forKey: "userid")
            
                if(userid == item.Donar_ID){
                    showToast(message: "You are the Donar", font: .systemFont(ofSize: 12))
                    requestbutton.isEnabled = false
                }
                else if(receiverInteractor.getdonationstatus(Receiver_ID: userid, Item_ID: item.item_id) == "pending"){
                    showToast(message: "Request Already Made", font: .systemFont(ofSize: 12))
                    requestbutton.isEnabled = false
                }
                else{
                    let donation : Donationstatus = Donationstatus(item_id: item.item_id , Donar_ID: item.Donar_ID, Receiver_ID: userid, status: "pending")
            receiverInteractor.insertdonation(donation: donation)
            self.navigationController?.pushViewController(ReceiverViewController(), animated: true)
            }
            }
            else{
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 220
        }
        else if(indexPath.row == 1 ){
            return 70
        }
        else if(indexPath.row == 2 ){
        return 50
        }
        else if(indexPath.row == 3){
        return 50
        }
        else if(indexPath.row == 4){
            return 50
        }
        else{
            return 170
        }
    
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
        let cell = detailView.dequeueReusableCell(withIdentifier: "image", for: indexPath) as! ProductImageTableViewCell
        cell.selectionStyle = .none
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if item.item_image != "" {
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(item.item_image)
            cell.itemimage.image = resizeImage(image: UIImage(contentsOfFile: imageURL.path)!, newWidth: 250)
            
    }
        }
        return cell
        }
         else if(indexPath.row == 1){
            let cell = detailView.dequeueReusableCell(withIdentifier: "name", for: indexPath) as! NameTableViewCell
            cell.bookNameLabel.text = item.item_name
            cell.authorNameLabel.text = item.description[0]
        return cell
        }
       else if(indexPath.row == 2){
        if(item.category == "Book"){
        let cell = detailView.dequeueReusableCell(withIdentifier: "publisher", for: indexPath) as! PublisherTableViewCell
        cell.selectionStyle = .none
        cell.publisherNameLabel.text = item.description[1]
        cell.publishingyearLabel.text = item.description[2]
//        if itemDetailValues[1] != "" && !descValues.isEmpty{
//            cell.label.text = descLabels[itemDetailValues[1]]![indexPath.row]
//            cell.label1.textAlignment = .right
//            cell.label1.numberOfLines = 0
//            cell.label1.lineBreakMode = .byWordWrapping
//
//            cell.label1.text = descValues[indexPath.row]
            
      //  }
        return cell
        }
        else if(item.category ==  "Cloth")
        {
            let cell = detailView.dequeueReusableCell(withIdentifier: "size", for: indexPath) as! sizeTableViewCell
            cell.selectionStyle = .none
            cell.sizeLabel.text = "Size :"
            cell.sizeLabel.text! += item.description[1]
            cell.gender.text = item.description[2]
            return cell
        }
        else
        { let cell = detailView.dequeueReusableCell(withIdentifier: "size", for: indexPath) as! sizeTableViewCell
                    if(item.category == "Food"){
                       
                        cell.selectionStyle = .none
                        cell.sizeLabel.text = "Expirey :"
                        cell.sizeLabel.text! += item.description[1]
                        cell.gender.text = item.description[2]
                        
                    }
            return cell
        }
       }
       else if(indexPath.row == 3) {
        let cell = detailView.dequeueReusableCell(withIdentifier: "quantity", for: indexPath) as! quantityTableViewCell
        cell.quantitynameLabel.text! += item.description[3]
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "eye")
        let attachmentString = NSMutableAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: " "+String(item.visited_count))
        attachmentString.append(myString)
        myString.append(attachmentString)
        cell.visitedCount.attributedText = attachmentString
        cell.selectionStyle = .none
        return cell
        
        }
       else if(indexPath.row == 4){
        let cell = detailView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as! profileTableViewCell
        cell.selectionStyle = .none
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "person.fill")
        let attachmentString = NSMutableAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: " "+donorValues[0])
        attachmentString.append(myString)
        myString.append(attachmentString)
        cell.profile.attributedText = attachmentString
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewProfleClicked(_:)))
        cell.viewprofileLabel.isUserInteractionEnabled = true
        cell.viewprofileLabel.addGestureRecognizer(tap)
        return cell
       }
       else {
        let cell = detailView.dequeueReusableCell(withIdentifier: "about", for: indexPath) as! AboutTableViewCell
        cell.selectionStyle = .none
        cell.textView.text = item.description[4]
//        if itemDetailValues[3] != "" {
//            cell.label.text = donorLables[indexPath.row]
//            cell.label1.textAlignment = .right
//            cell.label1.numberOfLines = 0
//            cell.label1.lineBreakMode = .byWordWrapping
//            cell.label1.text = donorValues[indexPath.row]
//
//        }
        
        
        return cell
       }
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: 270))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: 270))
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
            }
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
}
extension DetailViewController {
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
            detailView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 20),
            detailView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor,constant: -60),
           // detailView.heightAnchor.constraint(equalToConstant : 500),
            
            requestbutton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -55),
          //  requestbutton.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant:10),
           // requestbutton.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant:-10),
          //  containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            
            requestbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.5),
           // containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -55),
            requestbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //itemimage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            //itemimage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 30),

        ])

        regularConstraints.append(contentsOf: [
            detailView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 20),
            detailView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor,constant: -60),

        ])
    }
}
