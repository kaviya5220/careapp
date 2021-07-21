
import UIKit
protocol canReceive{
    func passData(item:Item,item_image:String)
}
class AddItemViewController: UIViewController,UIAdaptivePresentationControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate {
    public var itemImageName : String = ""
    var delegate:canReceive?
    let datePicker: UIDatePicker = UIDatePicker()
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
        stack.distribution = .fillProportionally

        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let stackView1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally

        stack.spacing = 3
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let stack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let quantity:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Quantity"
        return label
    }()
    let expirey:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Expiry Date"
        return label
    }()
    let quantityvalue:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "1"
        return label
    }()
    let scrollView : UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    let stepper : UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        stepper.autorepeat = true
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
//    let itemimage:UIImageView = {
//        let img = UIImageView()
//        img.image = UIImage(named: "dnimge")
//        img.contentMode = .scaleAspectFit
//        img.translatesAutoresizingMaskIntoConstraints = false
//        //img.layer.cornerRadius = 100
//        img.clipsToBounds = true
//        return img
//    }()
    var itemimage = UIImageView()
   
    
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
    let chooseImage:CustomButton = {
        let button = CustomButton(title: "Upload Image", bgColor: .blue)
        button.addTarget(self, action: #selector(chooseimage(_:)), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        return button
    }()
    
    let presenter = AddItemPresenter()

    override func viewDidLayoutSubviews() {
        print("layout")
        

        let upload = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(upload_item(_:)))
        self.navigationItem.rightBarButtonItem = upload
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel(_:)))
        self.navigationItem.leftBarButtonItem = cancel

        self.title = "Add Item"
        view.backgroundColor = .white
        itemimage.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        
        let contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
                scrollView.contentSize = contentViewSize
                //scrollView.frame = view.bounds
                scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .automatic
        
        view.addSubview(scrollView)
        
       
//        itemimage.layer.masksToBounds = true
//        itemimage.clipsToBounds = true
//        itemimage.layer.cornerRadius = itemimage.bounds.width/2
        scrollView.addSubview(itemimage)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(itemname)
        stackView.addArrangedSubview(itemDescription)
        stackView.addArrangedSubview(address)
        stackView.addArrangedSubview(stack)
        stack.addArrangedSubview(quantity)
        stack.addArrangedSubview(quantityvalue)
        stack.addArrangedSubview(stepper)
      
        itemimage.image = resizeImage(image: UIImage(named:"additem")!, newWidth: 200)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseimage1(tapGestureRecognizer:)))
            itemimage.isUserInteractionEnabled = true
            itemimage.addGestureRecognizer(tapGestureRecognizer)
//
//
        
        // scrollView.addSubview(stackView1)
       // stackView.addArrangedSubview(expirey)
       
        //stackView.addArrangedSubview(stack1)
      //  stack1.addArrangedSubview(expirey)
       
       // stackView.addArrangedSubview(datePicker)
        
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
        presenter.delegate = self
        self.isModalInPresentation = true
    }
    override func viewDidLoad() {
    //        datePicker.datePickerMode = .dateAndTime
    //        datePicker.preferredDatePickerStyle = .wheels
    //        datePicker.translatesAutoresizingMaskIntoConstraints = false
    //       // datePicker.calendar = .current
    //        datePicker.timeZone = NSTimeZone.local
    //        datePicker.backgroundColor = UIColor.white
    //        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    //        print("Load")
        }
//    @objc func datePickerValueChanged(_ sender: UIDatePicker){
//
//            // Create date formatter
//            let dateFormatter: DateFormatter = DateFormatter()
//
//            // Set date format
//            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
//
//            let selectedDate: String = dateFormatter.string(from: sender.date)
//
//            print("Selected value \(selectedDate)")
//        }

    @objc func cancel(_ sender: UIButton) {
        self.present(actionSheet,animated: true)
    }
    @objc func chooseimage(_ sender: UIButton) {
        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
       print("hi")
        print(itemImageName)
        
      
    }
    @objc func stepperValueChanged(_ sender:UIStepper!)
      {
         quantityvalue.text = String(Int(sender.value))
      }
    @objc func chooseimage1(tapGestureRecognizer: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
       print("hi")
        print(itemImageName)
        
      
    }
    @objc func upload_item(_ sender: UIButton) {
        let additeminteractor = AddItemInteractor()
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let formattedDate = format.string(from: date)
        print("date\(date)")
        let userdefaults = UserDefaults.standard
        let userid = userdefaults.integer(forKey: "userid")
        print(userid)
        let item: Item = Item(item_id: 0, item_name: itemname.text!, item_description: itemDescription.text!, item_image:itemImageName ,item_quantity: quantityvalue.text!, address: address.text!, Donar_ID: userid, visited_count: 0, date: formattedDate)
        var flag = 0
        flag = additeminteractor.addItem(item: item)
        print("Flag\(flag)")
        if(flag != 0){
            item.item_id = flag
            delegate?.passData(item:item,item_image: itemImageName)
            presenter.showSuccessAlert()
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.dismissinsertView()
               
            }))
           
            print("dismissing")
        }
        }
    func dismissinsertView(){
//        let presenter = navigationController?.viewControllers.first
//        print(presenter)
//        if let presenter = presentingViewController as? ReceiverViewController {
//            print(presenter.items)
//                presenter.items.append(item)
//            }
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
            print("presentationControllerDidAttemptToDismiss")
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
          //  datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
          //  stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])



        compactConstraints.append(contentsOf: [
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            datePicker.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.75),
//            datePicker.topAnchor.constraint(equalTo: self.stackView.bottomAnchor,constant: 10),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.75),
            stackView.topAnchor.constraint(equalTo: self.itemimage.bottomAnchor,constant: 50),
            stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            
//            quantity.leadingAnchor.constraint(equalTo: self.stack.leadingAnchor),
//            quantity.trailingAnchor.constraint(equalTo: self.quantityvalue.leadingAnchor),
//            quantityvalue.leadingAnchor.constraint(equalTo: self.quantity.leadingAnchor),
//            quantityvalue.trailingAnchor.constraint(equalTo: self.stack.trailingAnchor),
           
//            stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
//            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stack.topAnchor.constraint(equalTo:address.bottomAnchor,constant: 15),
//            stack.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.75),
//            stack1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stack1.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.75),
//
//            stack1.topAnchor.constraint(equalTo:stack.bottomAnchor,constant: 15),
            
//            stackView1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView1.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.75),
//            stackView1.topAnchor.constraint(equalTo: self.stackView.bottomAnchor,constant: 10),
            //stackView1.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor,constant: -80),
           // stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            itemimage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            itemimage.topAnchor.constraint(equalTo: self.scrollView.topAnchor,constant: 30),
            
//            datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            datePicker.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 30),
            
//            itemimage.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:10),
//            itemimage.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant:-10),
            //itemimage.bottomAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.bottomAnchor,constant: -10)
        ])

        regularConstraints.append(contentsOf: [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           
            stackView.topAnchor.constraint(equalTo: itemimage.bottomAnchor,constant:  15),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
           
//            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stack.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.5),
//            stack1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stack1.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.5),
//            stack.topAnchor.constraint(equalTo:address.bottomAnchor,constant: 15),
//            stack1.topAnchor.constraint(equalTo:stack.bottomAnchor,constant: 15),
//            stack1.bottomAnchor.constraint(equalTo:stackView.bottomAnchor),
//
            itemimage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            itemimage.widthAnchor.constraint(equalTo: view.widthAnchor),
            itemimage.topAnchor.constraint(equalTo: self.scrollView.topAnchor,constant: 20),
//            itemimage.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:10),
//            itemimage.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant:-10),
           // itemimage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
           
            
           
        ])
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        itemImageName = imageName
        print(itemImageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
       // itemimage.contentMode = .scaleAspectFit
      //  itemimage.image = resizeImage(image: image, newWidth: 200)
        DispatchQueue.main.async {
            self.itemimage.image = self.resizeImage(image: image, newWidth: 200)
                 }
        
        //itemimage.image = image
        dismiss(animated: true)
        print("setting image\(image)")
//        itemimage.image = UIImage
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

       // let scale = newWidth / image.size.width
        let newHeight = CGFloat(200.0)
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
extension AddItemViewController : AddItemPresenterDelegate{
    func showSuccessAlert() {
        self.present(alert, animated: true, completion: nil)
        }
}



    
