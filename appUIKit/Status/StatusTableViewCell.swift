//
//  StatusTableviewCellTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 12/07/21.
//

import UIKit

class StatusTableViewCell: UITableViewCell,UIViewControllerTransitioningDelegate {
    var status: Status? {
        didSet {
            guard let Status = status else {return}
          //  let name = Status.item_name
            Item_Namelabel.text = Status.item_name
            donarnamelabel.text = Status.name
            statusvaluelabel.text = Status.status
        }
    }
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    let Item_Namelabel:CustomLabel = {
        let label = CustomLabel(labelType: .title)
        label.textAlignment = .center
        return label
    }()
    let Postedbylabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Posted By :"
        return label
    }()
    let donarnamelabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    let statuslabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Status :"
        return label
    }()
    let statusvaluelabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    let viewProfilelabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "View Profile"
        label.textAlignment = .right
        label.textColor = .systemBlue
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewProfleClicked(_:)))
       viewProfilelabel.isUserInteractionEnabled = true
       viewProfilelabel.addGestureRecognizer(tap)
        
    
        
      
        containerView.addSubview(Item_Namelabel)
        containerView.addSubview(Postedbylabel)
        containerView.addSubview(donarnamelabel)
        containerView.addSubview(statuslabel)
        containerView.addSubview(statusvaluelabel)
        containerView.addSubview(viewProfilelabel)
        self.contentView.addSubview(containerView)
        
        

        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:5).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        
        
        Item_Namelabel.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 15).isActive = true
        Item_Namelabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        Item_Namelabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        Postedbylabel.topAnchor.constraint(equalTo:self.Item_Namelabel.bottomAnchor,constant: 5).isActive = true
        Postedbylabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        donarnamelabel.topAnchor.constraint(equalTo:self.Item_Namelabel.bottomAnchor,constant: 5).isActive = true
        donarnamelabel.leadingAnchor.constraint(equalTo:self.Postedbylabel.trailingAnchor,constant: 10).isActive = true
        
        statuslabel.topAnchor.constraint(equalTo:self.donarnamelabel.bottomAnchor,constant: 5).isActive = true
        statuslabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        statusvaluelabel.topAnchor.constraint(equalTo:self.donarnamelabel.bottomAnchor,constant: 5).isActive = true
        statusvaluelabel.leadingAnchor.constraint(equalTo:self.statuslabel.trailingAnchor,constant: 10).isActive = true
        
        viewProfilelabel.topAnchor.constraint(equalTo:self.statusvaluelabel.bottomAnchor,constant: 5).isActive = true
        viewProfilelabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        
       
      
    }
    @objc func viewProfleClicked(_ sender: UITapGestureRecognizer){
        print("Clicked")
        let vc = DonarprofileViewController()
        vc.donar_id = status!.donar_id
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        //self.present(vc, animated: true, completion: nil)
     

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
    

}
class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        return CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height: bounds.height / 2)
    }
}


