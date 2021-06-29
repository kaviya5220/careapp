//
//  DetailItemViewController.swift
//  appUIKit
//
//  Created by sysadmin on 16/06/21.
//

import UIKit

class DetailItemViewController: UIViewController,UIScrollViewDelegate {
    var itemid : Int = 0
    var donarid : Int = 0
    public var items : Item = Item(item_id: 0, item_name: "", item_description: "", item_quantity: "", address: "", Donar_ID: 0)
    public var user: User = User(user_name: "", user_phone: "", user_address: "", user_email: "", user_password: "")
    
    let itemimage:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "person")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    let backward:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "lessthan")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    let forward:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "greaterthan")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    let scrollView : UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    let containerView:UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8607709408, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    let verticalstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 10
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let donarverticalstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 10
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let itemNameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let itemDescriptionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let itemQuantityStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
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
        stack.alignment = .center
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
    
    
    

    override func viewWillAppear(_ Animated : Bool) {
        super.viewWillAppear(Animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 200)
        scrollView.contentSize = contentViewSize
        containerView.frame.size = contentViewSize
        scrollView.frame = view.bounds
        scrollView.delegate = self
        print("ID\(itemid)")
        let  receiverInteractor = ReceiverInteractor()
        items = receiverInteractor.getitemByID(ID: itemid)
        donarid = items.Donar_ID
        user = receiverInteractor.getdonardetails(ID: donarid)
        receiverInteractor.updateVisitedCount(ID: itemid)
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
        containerView.addSubview(itemlabel)
        containerView.addSubview(donarlabel)
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
        
        
      //  verticalstackView.addArrangedSubview(itemlabel)
        verticalstackView.addArrangedSubview(itemNameStackView)
        verticalstackView.addArrangedSubview(itemDescriptionStackView)
        verticalstackView.addArrangedSubview(itemQuantityStackView)
        
       // donarverticalstackView.addArrangedSubview(donarlabel)
        donarverticalstackView.addArrangedSubview(donarNameStackView)
        donarverticalstackView.addArrangedSubview(donarphoneStackView)
        donarverticalstackView.addArrangedSubview(donaraddressStackView)
       // view.addSubview(itemlabel)
        scrollView.addSubview(backward)
        scrollView.addSubview(forward)
       // view.addSubview(containerView)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
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
        ])
        
        compactConstraints.append(contentsOf: [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            backward.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backward.trailingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backward.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backward.heightAnchor.constraint(equalToConstant: 270),

            forward.leadingAnchor.constraint(equalTo: containerView.trailingAnchor),
            forward.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forward.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            forward.heightAnchor.constraint(equalToConstant: 270),

            verticalstackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            itemimage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            itemimage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            itemimage.topAnchor.constraint(equalTo: containerView.topAnchor),
            itemimage.heightAnchor.constraint(equalToConstant: 270),

            verticalstackView.topAnchor.constraint(equalTo: itemlabel.bottomAnchor,constant: 20),
            itemlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemlabel.topAnchor.constraint(equalTo: itemimage.bottomAnchor,constant: 10),
            itemlabel.bottomAnchor.constraint(equalTo: verticalstackView.topAnchor, constant: -20),
            donarlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            donarlabel.topAnchor.constraint(equalTo: verticalstackView.bottomAnchor,constant: 20),
            //donarlabel.bottomAnchor.constraint(equalTo: donarverticalstackView.topAnchor, constant: -20),
            donarverticalstackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            donarverticalstackView.topAnchor.constraint(equalTo: donarlabel.bottomAnchor, constant: 30),
            
            
        ])
        
        regularConstraints.append(contentsOf: [
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,multiplier: 0.5),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 800),
            
                                       


            backward.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backward.trailingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backward.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backward.heightAnchor.constraint(equalToConstant: 50),

            forward.leadingAnchor.constraint(equalTo: containerView.trailingAnchor),
            forward.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forward.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            forward.heightAnchor.constraint(equalToConstant: 50),

            verticalstackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            itemimage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            itemimage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            itemimage.topAnchor.constraint(equalTo: containerView.topAnchor),
            itemimage.heightAnchor.constraint(equalToConstant: 270),

            verticalstackView.topAnchor.constraint(equalTo: itemlabel.bottomAnchor,constant: 20),
            itemlabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            itemlabel.topAnchor.constraint(equalTo: itemimage.bottomAnchor,constant: 10),
            itemlabel.bottomAnchor.constraint(equalTo: verticalstackView.topAnchor, constant: -20),
            donarlabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            donarlabel.topAnchor.constraint(equalTo: verticalstackView.bottomAnchor,constant: 20),
//            donarlabel.bottomAnchor.constraint(equalTo: donarverticalstackView.topAnchor, constant: -20),
            donarverticalstackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            donarverticalstackView.topAnchor.constraint(equalTo: donarlabel.bottomAnchor, constant: 30),
            
        ])
    }
}
