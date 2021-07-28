
import UIKit
protocol canReceive{
    func passData(item:Item,item_image:String)
}
class AddItemViewController: UIViewController,UIAdaptivePresentationControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate,UITextViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1 // number of session
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return countryList.count // number of dropdown items
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return countryList[row] // dropdown item
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedCountry = countryList[row] // selected item
    category.text = selectedCountry
    }
    let toolBar = UIToolbar(frame:CGRect(x:0, y:0, width:100, height:44))
    func dismissPickerView() {
      
       toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
        toolBar.translatesAutoresizingMaskIntoConstraints = false
       category.inputAccessoryView = toolBar
    }
    @objc func action() {
          view.endEditing(true)
    }
    var selectedCountry: String?
    var countryList = ["BOOKS", "CLOTHES", "FOOD","ELECTRONICS"]
    var country : String = ""
    let dataArray = ["English", "Maths", "History", "German", "Science"]
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
    let stack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let category:UITextField = {
    let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        
    label.text = "Item Name"
    return label
    }()
    let itemNameLabel:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    label.text = "Item Name"
    return label
    }()
    let itemQuantityLabel:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    label.text = "Quantity"
    return label
    }()
    let itemDescriptionLabel:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    label.text = "Item Description"
    return label
    }()
    let itemLocation:CustomLabel = {
    let label = CustomLabel(labelType: .primary)
    label.text = "Address"
    return label
    }()
    let quantity:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Selected Quantity"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    let choosecategory:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Choose Category"
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
    var itemimage = UIImageView()
   
    
    let itemname:CustomTextField = {
        let namefield = CustomTextField()
        namefield.placeholder = "Enter Item Name"
        return namefield
    }()
    let itemDescription:UITextView = {
        let description = UITextView()
        description.contentInsetAdjustmentBehavior = .automatic
      //  textView.center = self.view.center
        description.textAlignment = NSTextAlignment.justified
        description.isScrollEnabled = false
        description.font = UIFont.systemFont(ofSize: 18)
        description.layer.borderWidth = 1.5
        description.layer.cornerRadius = 2
        description.layer.borderColor = UIColor.systemGray.cgColor
        //textView.textColor = UIColor.blue
        description.backgroundColor = UIColor.white
        description.text = "Enter Item Description"
        description.textColor = UIColor.lightGray
      
        //textView.text = "Enter your notes here"
       // textView.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    let itemQuantity:CustomTextField = {
        let quantity = CustomTextField()
        quantity.placeholder = "Enter Item Quantity"
        return quantity
    }()
    let address:UITextView = {
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
      //  textView.center = self.view.center
        textView.textAlignment = NSTextAlignment.justified
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.layer.borderWidth = 1.5
        textView.layer.cornerRadius = 2
        textView.layer.borderColor = UIColor.systemGray.cgColor
        //textView.textColor = UIColor.blue
        textView.backgroundColor = UIColor.white
        textView.text = "Placeholder"
        textView.textColor = UIColor.lightGray
      
        //textView.text = "Enter your notes here"
       // textView.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
        
    let chooseImage:CustomButton = {
        let button = CustomButton(title: "Upload Image", bgColor: .blue)
        button.addTarget(self, action: #selector(chooseimage(_:)), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        return button
    }()
    func textViewDidChange(_ textView: UITextView)
        {
        print("1")
            if address.contentSize.height >= 120.0
            {
                address.isScrollEnabled = true
                itemDescription.isScrollEnabled = true
            }
            else
            {
                let size = CGSize(width: view.frame.width, height: .infinity)
                let approxSize = textView.sizeThatFits(size)
                
                textView.constraints.forEach {(constraint) in
                    
                            if constraint.firstAttribute == .height{
                                    constraint.constant = approxSize.height
                                }
                            }
                address.isScrollEnabled = false
                itemDescription.isScrollEnabled = false
            }
        }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("2")
        if textView.textColor == UIColor.lightGray && textView == address {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        if textView.textColor == UIColor.lightGray && textView == itemDescription{
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("3")
        if textView.text.isEmpty && textView == address {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
        if textView.text.isEmpty && textView == itemDescription {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }

    let UIPicker: UIPickerView = UIPickerView()
    let presenter = AddItemPresenter()

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
             UIPicker.delegate = self as UIPickerViewDelegate
             UIPicker.dataSource = self as UIPickerViewDataSource
        UIPicker.translatesAutoresizingMaskIntoConstraints = false
        category.inputView = UIPicker
           //  UIPicker.center = self.view.center
        dismissPickerView()

        let upload = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(upload_item(_:)))
        self.navigationItem.rightBarButtonItem = upload
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel(_:)))
        self.navigationItem.leftBarButtonItem = cancel
        address.delegate = self
        itemDescription.delegate = self
        self.title = "Add Item"
        view.backgroundColor = .white
        itemimage.translatesAutoresizingMaskIntoConstraints = false
       
        let contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        scrollView.contentSize = contentViewSize
//        scrollView.frame = view.bounds
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .automatic
        setupConstraints()
        
        view.addSubview(scrollView)
       
        scrollView.addSubview(stackView)
        scrollView.addSubview(itemimage)
        stackView.addArrangedSubview(itemNameLabel)
        stackView.addArrangedSubview(itemname)
//        stackView.addArrangedSubview(itemDescriptionLabel)
//        stackView.addArrangedSubview(itemDescription)
//        stackView.addArrangedSubview(itemQuantityLabel)
//        stackView.addArrangedSubview(stack)
//        stack.addArrangedSubview(quantity)
//        stack.addArrangedSubview(quantityvalue)
//        stack.addArrangedSubview(stepper)
        stackView.addArrangedSubview(itemLocation)
        stackView.addArrangedSubview(address)
        stackView.addArrangedSubview(choosecategory)
        stackView.addArrangedSubview(category)
        
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
        presenter.delegate = self
        self.isModalInPresentation = true
    }
    override func viewDidLoad() {
        itemimage.image = resizeImage(image: UIImage(named:"additem")!, newWidth: 200)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseimage1(tapGestureRecognizer:)))
            itemimage.isUserInteractionEnabled = true
            itemimage.addGestureRecognizer(tapGestureRecognizer)
    
        }

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
        format.dateFormat = "dd-MM-yyyy HH:mm"
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
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.75),
          //  stackView.topAnchor.constraint(equalTo: self.itemimage.bottomAnchor,constant: 15),
           // stackView.bottomAnchor.constraint(equalTo: self.address.topAnchor),
//            stack.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
//            stack.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            
            itemimage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            itemimage.topAnchor.constraint(equalTo: self.scrollView.topAnchor,constant: 30),
            itemimage.bottomAnchor.constraint(equalTo: self.stackView.topAnchor),
            
//            address.topAnchor.constraint(equalTo: stackView.bottomAnchor),
//            address.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.75),
//            address.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            address.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
////            address.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            //toolBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -60),
//            toolBar.centerXAnchor.constraint(equalTo: category.centerXAnchor),
//            //toolBar.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
//           // toolBar.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
//            toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
        ])

        regularConstraints.append(contentsOf: [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: -25),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
          //  stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          //  stack.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            //stack.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
           
            itemimage.topAnchor.constraint(equalTo: self.scrollView.topAnchor,constant: 20),
            itemimage.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor,constant: -100),
            
            itemimage.leadingAnchor.constraint(equalTo:self.scrollView.leadingAnchor,constant: 30),
            itemimage.trailingAnchor.constraint(equalTo:stackView.leadingAnchor,constant: -30),
           
            
           
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



    
