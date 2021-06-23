//
//  DetailItemViewController.swift
//  appUIKit
//
//  Created by sysadmin on 16/06/21.
//

import UIKit

class DetailItemViewController: UIViewController {
    var itemid : Int = 0
    var donarid : Int = 0
    public var items : Item = Item(item_id: 0, item_name: "", item_description: "", item_quantity: "", address: "", Donar_ID: 0)
    public var user: User = User(user_name: "", user_phone: "", user_address: "", user_email: "", user_password: "")
    var db = DBHelper()
    
    let itemimage:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    let verticalstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .fillProportionally
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let donarverticalstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .fillProportionally
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let itemNameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let itemDescriptionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let itemQuantityStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let itemlabel:CustomLabel = {
    let label = CustomLabel(labelType: .title)
    label.text = "Item Details"
    return label
    }()
    let itemnamelabel:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    label.text = "Name :"
    return label
    }()
    let itemname:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    
    let itemdescription:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    let itemdescriptionlabel:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    label.text = "Description :"
    return label
    }()

    let itemquantity:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    return label
    }()
    let itemquantitylabel:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    label.text = "Quantity :"
    return label
    }()
    
    let donarNameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let donarphoneStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let donaraddressStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let donarlabel:CustomLabel = {
    let label = CustomLabel(labelType: .title)
    label.text = "Donar Details"
    return label
    }()
    let donarnamelabel:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    label.text = "Name :"
    return label
    }()
    let donarname:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    
    let donarphone:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    let donarphoneno:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    label.text = "Phone No :"
    return label
    }()

    let donaraddress:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    return label
    }()
    let donaraddressdetails:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    label.text = "Address :"
    return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("ID\(itemid)")
        db = DBHelper()
        items = DBHelper.getitemsbyID(ID: itemid)
        donarid = items.Donar_ID
        db = DBHelper()
        user = DBHelper.getdonardetails(ID: donarid)
        print(donarid)
        print(items)
        print(user)
        
        donarname.text = user.user_name
        donarphone.text = user.user_phone
        donaraddress.text = user.user_address
        itemname.text = items.item_name
        itemdescription.text = items.item_description
        itemquantity.text = items.item_quantity
        setupConstraints()
        containerView.addSubview(itemimage)
        containerView.addSubview(verticalstackView)
        containerView.addSubview(donarverticalstackView)
        itemNameStackView.addArrangedSubview(itemnamelabel)
        itemNameStackView.addArrangedSubview(itemname)
        
        itemDescriptionStackView.addArrangedSubview(itemdescriptionlabel)
        itemDescriptionStackView.addArrangedSubview(itemdescription)
        
        itemQuantityStackView.addArrangedSubview(itemquantitylabel)
        itemQuantityStackView.addArrangedSubview(itemquantity)
        
        donarNameStackView.addArrangedSubview(donarnamelabel)
        donarNameStackView.addArrangedSubview(donarname)
        
        donarphoneStackView.addArrangedSubview(donarphoneno)
        donarphoneStackView.addArrangedSubview(donarphone)
        
        donaraddressStackView.addArrangedSubview(donaraddressdetails)
        donaraddressStackView.addArrangedSubview(donaraddress)
        
        
        verticalstackView.addArrangedSubview(itemlabel)
        verticalstackView.addArrangedSubview(itemNameStackView)
        verticalstackView.addArrangedSubview(itemDescriptionStackView)
        verticalstackView.addArrangedSubview(itemQuantityStackView)
        
        donarverticalstackView.addArrangedSubview(donarlabel)
        donarverticalstackView.addArrangedSubview(donarNameStackView)
        donarverticalstackView.addArrangedSubview(donarphoneStackView)
        donarverticalstackView.addArrangedSubview(donaraddressStackView)
        
        view.addSubview(containerView)
        print(itemid)
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
    }
    
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()

}
extension DetailItemViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints:sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
    }
    
    private func setupConstraints() {
        
        sharedConstraints.append(contentsOf: [
            verticalstackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        compactConstraints.append(contentsOf: [
            containerView.topAnchor.constraint(equalTo: view.topAnchor,constant: 40),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            verticalstackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemimage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            itemimage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            itemimage.topAnchor.constraint(equalTo: containerView.topAnchor),
            itemimage.heightAnchor.constraint(equalToConstant: 270),
          
            verticalstackView.topAnchor.constraint(equalTo: itemimage.bottomAnchor),
            itemlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemNameStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            itemNameStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
          
            itemDescriptionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            itemDescriptionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            itemQuantityStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            itemQuantityStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            donarverticalstackView.topAnchor.constraint(equalTo: verticalstackView.bottomAnchor, constant: 10),
            donarlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            donarNameStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            donarNameStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
          
            donarphoneStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            donarphoneStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            donaraddressStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            donaraddressStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
        ])
        
        regularConstraints.append(contentsOf: [
         //   loginlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            verticalstackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            verticalstackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            itemNameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}
