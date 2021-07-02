//
//  DonationDetailViewController.swift
//  appUIKit
//
//  Created by sysadmin on 02/07/21.
//

import UIKit

class DonationDetailViewController: UIViewController,UIScrollViewDelegate {
        var itemid : Int = 0
        var donarid : Int = 0
        public var items : Item = Item()
        public var user: User = User()
        
        let itemimage:UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named: "dnimge")
            img.contentMode = .scaleAspectFit
            img.translatesAutoresizingMaskIntoConstraints = false
            img.layer.cornerRadius = 25
            img.clipsToBounds = true
            return img
        }()
        let scrollView : UIScrollView = {
            let scroll = UIScrollView(frame: .zero)
            scroll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            scroll.translatesAutoresizingMaskIntoConstraints = false
            return scroll
        }()
        let containerView:UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
         //   stack.spacing = -20
            stack.backgroundColor = .white
            stack.layer.cornerRadius = 10
           // stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            //stack.isLayoutMarginsRelativeArrangement = true
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        let verticalstackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.spacing = 15
            stack.backgroundColor = .white
            stack.layer.cornerRadius = 10
    //        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    //        stack.isLayoutMarginsRelativeArrangement = true
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        let donarverticalstackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.spacing = 15
            stack.backgroundColor = .white
            stack.layer.cornerRadius = 10
           // stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    //        stack.isLayoutMarginsRelativeArrangement = true
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
            print(self.view.frame.height)
            let accept = UIBarButtonItem(title: "Accept", style: .plain, target: self, action: nil)
            navigationItem.rightBarButtonItem = accept
            let contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 300)
            scrollView.contentSize = contentViewSize
           // containerView.frame.size = contentViewSize
            scrollView.frame = view.bounds
            scrollView.delegate = self
           
            let  donationInteractor = DonationInteractor()
            items = donationInteractor.getitemByID(ID: itemid)
            donarid = items.Donar_ID
            user = donationInteractor.getdonardetails(ID: donarid)
            
            
            donarname.text = user.user_name
            donarphone.text = user.user_phone
            donaraddress.text = user.user_address
            itemname.text = items.item_name
            itemdescription.text = items.item_description
            itemquantity.text = items.item_quantity
            setupConstraints()
            containerView.addArrangedSubview(itemimage)
            containerView.addArrangedSubview(itemlabel)
            containerView.setCustomSpacing(5, after: itemlabel)
            containerView.addArrangedSubview(verticalstackView)
            containerView.setCustomSpacing(5, after: verticalstackView)
            containerView.addArrangedSubview(donarlabel)
            containerView.setCustomSpacing(5, after: donarlabel)
            containerView.addArrangedSubview(donarverticalstackView)
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
    extension DonationDetailViewController {
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
                containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                containerView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
                containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
               
            
            ])
            
            regularConstraints.append(contentsOf: [
                scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
              //  scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),

                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,multiplier: 0.5),
                containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                //containerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor,multiplier: 0.5),
                containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
           ])
        }
    }
