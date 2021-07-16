//
//  ProfileViewController.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit
protocol updateItems {
    func updateItem(itemid : Int)
}

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var delagate : updateItems?
    public var itemid : [Int] = []
    public var items : [Item] = []
    var requestlist : [RequestList] = []
    var newRequestList: [[RequestList]] = [[]]
    var statuslist : [Status] = []
    var itemNames : [String] = []
    let donationInteractor = DonationInteractor()
    let requestlistInteractor = RequestListInteractor()
    let statuslistInteractor = StatusInteractor()
    let donarTableView = UITableView()
    let requestListTableView = UITableView()
    let statusTableView = UITableView()
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
        let newlist = Dictionary(grouping: requestlist,by : \.item_name).sorted{$0.key < $1.key}
        newRequestList = newlist.map{return $0.value}
        
        
        
        setUserDetails(userid: userid)
        statuslist = statuslistInteractor.fetchStatus(receiver_id: userid)
        donarTableView.translatesAutoresizingMaskIntoConstraints = false
        donarTableView.reloadData()
        requestListTableView.translatesAutoresizingMaskIntoConstraints = false
        requestListTableView.reloadData()
        statusTableView.translatesAutoresizingMaskIntoConstraints = false
        statusTableView.reloadData()
        view.addSubview(profileHorizantalView)
        view.addSubview(segmentedControl)
        view.addSubview(statusTableView)
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
        statusTableView.dataSource = self
        statusTableView.delegate = self
        statusTableView.register(StatusTableViewCell.self, forCellReuseIdentifier: "statuscell")
    }
    
    func receiver_accepted(receiver_id: Int,item_id:Int) {
        print("Accept clicked")
        //print(sender.tag)
        delagate?.updateItem(itemid: item_id )
        requestlistInteractor.updatestatus(receiverID: receiver_id, item_id:item_id)
        requestlistInteractor.updateOtherRequests(receiverID: receiver_id, item_id:item_id)
        let userid = userdefaults.integer(forKey: "userid")
        requestlist = requestlistInteractor.fetchRequestList(donarID: userid)
        itemNames = [String](Set(requestlist.map{$0.item_name}))
        itemNames.sort()
        let newlist = Dictionary(grouping: requestlist,by : \.item_name).sorted{$0.key < $1.key}
        newRequestList = newlist.map{return $0.value}
        requestListTableView.reloadData()
        
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
      //  let login = LoginViewController()
        let userDefaults =  UserDefaults.standard
      //  let nav = UINavigationController(rootViewController: login)
        
        userDefaults.removeObject(forKey: "userid")
            userDefaults.synchronize()
      
          //  (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(nav)
        let newVc = ReceiverViewController()
        let nav = UINavigationController(rootViewController: newVc)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let scene = UIApplication.shared.connectedScenes.first{
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window.windowScene = windowScene
            window.rootViewController = nav
            window.makeKeyAndVisible()
            appDelegate.window = window
        }
            }
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
       switch (segmentedControl.selectedSegmentIndex) {
          case 0:
            print("0")
            statusTableView.isHidden = true
            requestListTableView.isHidden = true
            donarTableView.isHidden = false
          break
          case 1:
            print("!")
            statusTableView.isHidden = true
            donarTableView.isHidden = true
            requestListTableView.isHidden = false
       case 2 :
        statusTableView.isHidden = false
        requestListTableView.isHidden = true
        donarTableView.isHidden = true
         
            
            
            
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
        if(tableView == donarTableView || tableView == statusTableView){
            return 1
        }
        else {
        return itemNames.count
        }
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(tableView == donarTableView){
            return items.count
            }
            else if(tableView == requestListTableView){
                return requestlist.filter{$0.item_name == itemNames[section]}.count
            }
            else{
                return statuslist.count
            }
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if(tableView == donarTableView){
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! DonationTableViewCell
           cell.item = items[indexPath.row]
            return cell
            }
            
            else if(tableView == requestListTableView){
                let cell = tableView.dequeueReusableCell(withIdentifier: "requestList", for: indexPath) as! RequestListTableViewCell
                cell.request = newRequestList[indexPath.section][indexPath.row]
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "statuscell", for: indexPath) as! StatusTableViewCell
                cell.status = statuslist[indexPath.row]
                changeColor(cell: cell)
                return cell
            }
            
        }
    func changeColor(cell : StatusTableViewCell)
    {
        switch cell.status?.status{
        case "accepted" :
            cell.statusvaluelabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        case "rejected" :
            cell.statusvaluelabel.textColor = .red
        case "pending" :
            cell.statusvaluelabel.textColor = .orange
        default :
            cell.statusvaluelabel.textColor = .red
        }
        
    }
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if(tableView == requestListTableView){
        let archive = UIContextualAction(style: .normal,
                                         title: "Archive") { [weak self] (action, view, completionHandler) in
            self?.receiver_accepted(receiver_id: self!.newRequestList[indexPath.section][indexPath.row].receiver_id, item_id: self!.newRequestList[indexPath.section][indexPath.row].item_id)
                                            completionHandler(true)
            
        }
        archive.backgroundColor = .systemGreen

        
        let configuration = UISwipeActionsConfiguration(actions: [archive])

        return configuration
        }
        else{
            return .none
        }
    }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 170
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
            
            statusTableView.topAnchor.constraint(equalTo: profileHorizantalView.bottomAnchor,constant: 50),
            statusTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            statusTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            statusTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        compactConstraints.append(contentsOf: [
           
        ])
        
        regularConstraints.append(contentsOf: [
          
       ])
    }
}

