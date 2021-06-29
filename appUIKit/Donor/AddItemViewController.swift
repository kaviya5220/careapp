
import UIKit
protocol canReceive{
    func passData()
}
class AddItemViewController: UIViewController,UIAdaptivePresentationControllerDelegate, UINavigationControllerDelegate {

    var db = DBHelper()
    var delegate:canReceive?
    let alert : UIAlertController = {
    let alert1 = UIAlertController(title: "Success", message: "Item Posted Successfully", preferredStyle: .alert)
    return alert1
    }()
    
    private var actionSheet: UIAlertController {
        let actionSheet = UIAlertController(
            title: "",
            message: "Discard Changes?",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(.init(
            title: "Yes",
            style: .destructive,
            handler: { _ in self.dismiss(animated: true) }
        ))
        actionSheet.addAction(.init(
            title: "No",
            style: .default
        ))
        return actionSheet
    }

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
   
    let itemlabel:CustomLabel = {
        let label = CustomLabel(labelType: .title)
        label.text = "ITEM DETAILS "
        label.textAlignment = .center
        return label
    }()
    let itemname:CustomTextField = {
        let namefield = CustomTextField()
        namefield.placeholder = "Enter Item Name"
        return namefield
    }()
    let itemDescription:CustomTextField = {
        let description = CustomTextField()
        description.placeholder = "Enter Item Descrption"
        return description
    }()
    let itemQuantity:CustomTextField = {
        let quantity = CustomTextField()
        quantity.placeholder = "Enter Item Quantity"
        return quantity
    }()
    let address:UITextField = {
        let addressfield = CustomTextField()
        addressfield.placeholder = "Enter address"
        return addressfield
    }()
    let addbutton:CustomButton = {
        let button = CustomButton(title: "UPLOAD ITEM", bgColor: .white)
        button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        return button
    }()
    
    let presenter = AddItemPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        let upload = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(insertUser(_:)))
        self.navigationItem.rightBarButtonItem = upload
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel(_:)))
        self.navigationItem.leftBarButtonItem = cancel

        self.title = "Add Item"
        view.backgroundColor = .white
        setupConstraints()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(itemlabel)
        stackView.addArrangedSubview(itemname)
        stackView.addArrangedSubview(itemDescription)
        stackView.addArrangedSubview(itemQuantity)
        stackView.addArrangedSubview(address)
        stackView.addArrangedSubview(addbutton)
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
        presenter.delegate = self
    }

    @objc func cancel(_ sender: UIButton) {
        self.present(actionSheet,animated: true)
    }
    @objc func insertUser(_ sender: UIButton) {
        let userdefaults = UserDefaults.standard
        let userid = userdefaults.integer(forKey: "userid")
        print(userid)
        let item: Item = Item(item_id: 0, item_name: itemname.text!, item_description: itemDescription.text!, item_quantity: itemQuantity.text!, address: address.text!, Donar_ID: userid)
        var flag = false
        flag = DBHelper.insertItem(itemarg: item)
        if(flag == true){
            presenter.showSuccessAlert()
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.dismissinsertView()
               
            }))
            delegate?.passData()
            print("dismissing")
        }
        }
    func dismissinsertView(){
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)


    }
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()

    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
            print("dismiss")
            return false
        }

        func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
            present(actionSheet, animated: true)
        }

}
extension AddItemViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints:sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
    }
    private func setupConstraints() {

        sharedConstraints.append(contentsOf: [
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])



        compactConstraints.append(contentsOf: [
            itemlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
           // addbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            //addbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])

        regularConstraints.append(contentsOf: [
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            itemlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
}
extension AddItemViewController : AddItemPresenterDelegate{
    func showSuccessAlert() {
        self.present(alert, animated: true, completion: nil)
        }
}



    
