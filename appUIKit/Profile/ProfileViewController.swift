//
//  ProfileViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var itemid : [Int] = []
    public var items : [Item] = []
    var requestlist : [RequestList] = []
    var newRequestList: [[RequestList]] = [[]]
    var itemNames : [String] = []
    let donationInteractor = DonationInteractor()
    let requestlistInteractor = RequestListInteractor()
    let donarTableView = UITableView()
    let requestListTableView = UITableView()
    let userdefaults = UserDefaults.standard
    let profileInteractor = ProfileInteractor()
    
    let profileHorizantalView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
//        stack.spacing = -20
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 10
       // stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        //stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let profileVerticalView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 15
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 10
       // stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        //stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let userimage:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person.circle")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        //img.layer.cornerRadius = 100
        img.clipsToBounds = true
        return img
    }()
    let name:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    let email:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    let phoneno:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    let testview1 : UIView = {
        let tst = UIView()
        tst.backgroundColor = .red
        tst.clipsToBounds = true
        tst.translatesAutoresizingMaskIntoConstraints = false
        return tst
    }()
    
    let segmentedControl : UISegmentedControl = {
        let segmentItems = ["My Donations","Request List", "Status"]
           let control = UISegmentedControl(items: segmentItems)
       
           control.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
           control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userid = userdefaults.integer(forKey: "userid")
        items = donationInteractor.getitemdetailbydonarid(userid : userid)
        requestlist = requestlistInteractor.fetchRequestList(donarID: userid)
        itemNames = [String](Set(requestlist.map{$0.item_name}))
        itemNames.sort()
//        print("Item Names\(itemNames)")
//        print("Items COunt \(items)")
        let newlist = Dictionary(grouping: requestlist,by : \.item_name).sorted{$0.key < $1.key}
       // print("newnwew\(newlist)")
        newRequestList = newlist.map{return $0.value}
        
        setUserDetails(userid: userid)
        print(items)
        donarTableView.translatesAutoresizingMaskIntoConstraints = false
        donarTableView.reloadData()
        requestListTableView.translatesAutoresizingMaskIntoConstraints = false
        requestListTableView.reloadData()
       
        view.addSubview(profileHorizantalView)
        view.addSubview(segmentedControl)
        //view.addSubview(testview1)
        view.addSubview(requestListTableView)
        view.addSubview(donarTableView)
        
        
        
        profileHorizantalView.addArrangedSubview(userimage)
        profileHorizantalView.addArrangedSubview(profileVerticalView)
        profileVerticalView.addArrangedSubview(name)
        profileVerticalView.addArrangedSubview(phoneno)
        profileVerticalView.addArrangedSubview(email)
        
        setupConstraints()
        view.backgroundColor = .white
        let upload = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout(_:)))
        self.navigationItem.rightBarButtonItem = upload
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
        donarTableView.dataSource = self
        donarTableView.delegate = self
        donarTableView.register(DonationTableViewCell.self, forCellReuseIdentifier: "itemcell")
        requestListTableView.dataSource = self
        requestListTableView.delegate = self
        requestListTableView.register(RequestListTableViewCell.self, forCellReuseIdentifier: "requestList")
    }
    @objc func insertUser(_ sender: UIButton) {
        print("REquest clicked")
    }
    func setUserDetails(userid:Int){
        let user:User = profileInteractor.getdonardetails(ID: userid)
        name.text = user.user_name
        email.text = user.user_email
        phoneno.text = user.user_phone
    }
    
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
       
    @objc func logout(_ sender: UIButton)
    {
        let login = LoginViewController()
        let userDefaults =  UserDefaults.standard
        let nav = UINavigationController(rootViewController: login)
        
        userDefaults.removeObject(forKey: "userid")
            userDefaults.synchronize()
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(nav)
            }
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
       switch (segmentedControl.selectedSegmentIndex) {
          case 0:
            print("0")
            requestListTableView.isHidden = true
            donarTableView.isHidden = false
          break
          case 1:
            print("!")
//            print(requestlist)
            donarTableView.isHidden = true
            requestListTableView.isHidden = false
            
          break
          default:
          break
       }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(tableView == requestListTableView){
            return itemNames[section]
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == donarTableView){
            return 1
        }
        else{
        return itemNames.count
        }
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(tableView == donarTableView){
            return items.count
            }
            else {
                //print("Item Name\(itemNames[section])")
                //print("Section\(requestlist.map{$0.item_name==itemNames[section]}.count)")
                return requestlist.filter{$0.item_name == itemNames[section]}.count
            }
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if(tableView == donarTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! DonationTableViewCell
            print("cell\(cell.item)")
           cell.item = items[indexPath.row]
            return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "requestList", for: indexPath) as! RequestListTableViewCell
              //  print("IndexPath\(indexPath.section)")

                //print("IN here \(newRequestList[indexPath.section][indexPath.row].item_name)")
                cell.request = newRequestList[indexPath.section][indexPath.row]
                
                //  cell.textLabel?.text = "hi"
                return cell
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
    
}



extension ProfileViewController {
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
            profileHorizantalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            profileHorizantalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profileHorizantalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
         
            segmentedControl.topAnchor.constraint(equalTo: profileHorizantalView.bottomAnchor,constant: 15),

            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            donarTableView.topAnchor.constraint(equalTo: profileHorizantalView.bottomAnchor,constant: 50),
            donarTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            donarTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            donarTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            requestListTableView.topAnchor.constraint(equalTo: profileHorizantalView.bottomAnchor,constant: 50),
            requestListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            requestListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            requestListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            
            

        
        ])
        
        regularConstraints.append(contentsOf: [
            
       ])
    }
}

