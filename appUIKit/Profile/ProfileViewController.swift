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
    let donationInteractor = DonationInteractor()
    let testview = UITableView()
   
    
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
        label.text = "Kaviya"
        return label
    }()
    let email:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "kaviya5220@gmail.com"
        return label
    }()
    let phoneno:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "91768679012"
        return label
    }()
//   // let testview : UIView = {
//        let tst = UIView()
//        tst.backgroundColor = .blue
//        tst.clipsToBounds = true
//        tst.translatesAutoresizingMaskIntoConstraints = false
//        return tst
//    }()
    let testview1 : UIView = {
        let tst = UIView()
        tst.backgroundColor = .red
        tst.clipsToBounds = true
        tst.translatesAutoresizingMaskIntoConstraints = false
        return tst
    }()
    
    let segmentedControl : UISegmentedControl = {
        let segmentItems = ["My Donations", "Request Status"]
           let control = UISegmentedControl(items: segmentItems)
       
           control.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
           control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let userdefaults = UserDefaults.standard
        let userid = userdefaults.integer(forKey: "userid")
        items = donationInteractor.getitemdetailbydonarid(userid : userid)
        print(items)
        testview.translatesAutoresizingMaskIntoConstraints = false
        testview.reloadData()
       // segmentedControl.frame = CGRect(x: 10, y: 250, width: (self.view.frame.width - 20), height: 50)
        view.addSubview(profileHorizantalView)
        view.addSubview(segmentedControl)
        view.addSubview(testview1)
        view.addSubview(testview)
        
        
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
        testview.dataSource = self
        testview.delegate = self
        testview.register(DonationTableViewCell.self, forCellReuseIdentifier: "itemcell")
    }
    @objc func insertUser(_ sender: UIButton) {
        print("REquest clicked")
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
            testview1.isHidden = true
            testview.isHidden = false
          break
          case 1:
            print("!")
            testview.isHidden = true
            testview1.isHidden = false
            
          break
          default:
          break
       }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DonationDetailViewController()
        itemid = items.map{$0.item_id}
        print(itemid)
        
       // if let index = items.firstIndex(where: { $0 === items[indexPath.row] }){
            print("if")
        vc.itemid = items[indexPath.row].item_id
            
            self.navigationController?.pushViewController(vc, animated: true)
     //   }
            
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! DonationTableViewCell
            print("cell\(cell.item)")
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            cell.item = items[indexPath.row]
            return cell
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
            testview.topAnchor.constraint(equalTo: profileHorizantalView.bottomAnchor,constant: 50),
            testview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            testview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            testview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            testview1.topAnchor.constraint(equalTo: profileHorizantalView.bottomAnchor,constant: 50),
            testview1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            testview1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            testview1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
         
            
            

        
        ])
        
        regularConstraints.append(contentsOf: [
            
       ])
    }
}

