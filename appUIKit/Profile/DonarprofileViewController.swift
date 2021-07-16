//
//  DonarprofileViewController.swift
//  appUIKit
//
//  Created by sysadmin on 12/07/21.
//

import UIKit

class DonarprofileViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var donar_id : Int = 0
    var profile_details : [String] = []
    var profile_details_label : [String] = ["Name","Phone Number","Address","Email"]
    let donarInteractor = DonarInteractor()
    let donarProfileTableView = UITableView()
    let profileLabel:CustomLabel = {
        let label = CustomLabel(labelType: .title)
        label.text = "Profile Details"
        label.textAlignment = .center
        return label
    }()
    let closeButton:CustomButton = {
        let closeButton = CustomButton(title: "Close", bgColor: .systemRed)
        closeButton.addTarget(self, action: #selector(dismissPresentation(_:)), for: .touchUpInside)
        closeButton.layer.cornerRadius = 10
        return closeButton
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        donarProfileTableView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        profile_details = donarInteractor.getdonarProfile(ID: donar_id)
        self.view.backgroundColor = UIColor.clear
        let effect = UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterial)
            let blurView = UIVisualEffectView(effect: effect)
            blurView.frame = self.view.bounds
            self.view.addSubview(blurView)
        print("DID\(donar_id)")
        print(profile_details)
       // view.backgroundColor = .white
        view.addSubview(profileLabel)
        view.addSubview(donarProfileTableView)
        view.addSubview(closeButton)
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
        donarProfileTableView.dataSource = self
        donarProfileTableView.delegate = self
        donarProfileTableView.register(DonarTableViewCell.self, forCellReuseIdentifier: "profilecell")
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile_details_label.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profilecell", for: indexPath) as! DonarTableViewCell
        cell.label_value.text = profile_details[indexPath.row]
        cell.label_name.text = profile_details_label[indexPath.row]
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    @objc func dismissPresentation(_ sender:UIButton){
        dismiss(animated: true, completion: nil)
    }

    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()

}
extension DonarprofileViewController {
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
            
            profileLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 5),
            profileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           // profileLabel.bottomAnchor.constraint(equalTo: donarProfileTableView.topAnchor,constant: -5),
            
            donarProfileTableView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor,constant: 20),
            donarProfileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            donarProfileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //donarProfileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: donarProfileTableView.bottomAnchor),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -40)
            
            
        ])
        
        regularConstraints.append(contentsOf: [
           
        ])
    }
}
