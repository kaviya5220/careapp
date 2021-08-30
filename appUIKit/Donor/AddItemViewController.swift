//
//  AddItemViewController.swift
//  appUIKit
//
//  Created by Kaviya M on 25/08/21.
//

import UIKit

protocol canReceive{
    func passData(item:Item,item_image:String,description:[String])
}

class AddItemViewController: UIViewController,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UIAdaptivePresentationControllerDelegate, UINavigationControllerDelegate{
    let additeminteractor = AddItemInteractor()
    let presenter = AddItemPresenter()
    var categoryLabelDict:[String:[String]] = ["Books":["Author","Publisher","Published Year","Quantity"],
                                               "Food":["Expiry Date","Cuisine","Veg/Non Veg","Quantity"],
                                               "Cloth":["Size","Cloth Category","Gender","Quantity"]]
    let quantityStepper = UIStepper()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let bookStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let quantityStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
       // stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let quantitylabel:CustomLabel = {
        let field = CustomLabel(labelType: .primary)
        field.text = "Quantity"
        return field
    }()
    let addresslabel:CustomLabel = {
        let field = CustomLabel(labelType: .primary)
        field.text = "Address"
        return field
    }()
    let otherlabel:CustomLabel = {
        let field = CustomLabel(labelType: .primary)
        field.text = "Other Description"
        return field
    }()
    let textField4:UITextField = {
        let namefield = UITextField()
        namefield.placeholder = "Enter Quantity"
        namefield.text = "1"
        namefield.keyboardType = .numberPad
        namefield.borderStyle = .none
        namefield.translatesAutoresizingMaskIntoConstraints = false
        return namefield
    }()
   
    let scrollView : UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    let itemNameLabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Item Name"
        return label
    }()
    let itemname:UITextField = {
        let namefield = UITextField()
        namefield.placeholder = "Enter Item Name"
        namefield.borderStyle = .none
        namefield.translatesAutoresizingMaskIntoConstraints = false
        return namefield
    }()
    let label1:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
       // label.text = "Item Name"
        return label
    }()
    let textField1:UITextField = {
        let namefield = UITextField()
       // namefield.placeholder = "Enter Item Name"
        namefield.borderStyle = .none
        namefield.translatesAutoresizingMaskIntoConstraints = false
        return namefield
    }()
    let label2:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        //label.text = "Item Name"
        return label
    }()
    let textField2:UITextField = {
        let namefield = UITextField()
       // namefield.placeholder = "Enter Item Name"
        namefield.borderStyle = .none
        namefield.translatesAutoresizingMaskIntoConstraints = false
        return namefield
    }()
    let label3:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        //label.text = "Item Name"
        return label
    }()
    let textField3:UITextField = {
        let namefield = UITextField()
       // namefield.placeholder = "Enter Item Name"
        namefield.borderStyle = .none
        namefield.translatesAutoresizingMaskIntoConstraints = false
        return namefield
    }()
    let addresstextView:UITextView = {
        let textView = UITextView()
        textView.contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 5, right: 5)
     
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.backgroundColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    let othertextView:UITextView = {
        let textView = UITextView()
        textView.contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 5, right: 5)
     
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.backgroundColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    let itemimage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

        let newHeight = CGFloat(200.0)
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    let mySegmentedControl = UISegmentedControl (items: ["Books","Food","Cloth"])
    var pickerData : [Int] = [Int]()
    var myPickerView = UIPickerView()
    var toolBar = UIToolbar()
   
    
            
            @objc func segmentedValueChanged(_ sender:UISegmentedControl!)
            {
                switch sender.selectedSegmentIndex{
                
                case 1:
                    categorychosen = "Food"
                    
                    break
                case 2:
                    categorychosen = "Cloth"
                    break
                default:
                    categorychosen = "Book"
                    
                
                }
//                item.item_name = ""
//                item.address = ""
//                descriptionValue = ["","","","",""]
                setLabelandPlaceholder()
                resetValues()
            }
            
    func createToolBar() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(sender:)))

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 40))
     label.text = "Choose the year"
        let labelButton = UIBarButtonItem(customView:label)

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        toolBar.setItems([flexibleSpace,labelButton,flexibleSpace,doneButton], animated: true)

    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
        textField3.text = String(pickerData[row])
       // descriptionValue[2] = String(pickerData[row])
    }
    func createStepper(){
        
        quantityStepper.wraps = false
         
        quantityStepper.autorepeat = true
        
        quantityStepper.maximumValue = 50
        quantityStepper.minimumValue = 1
               
    }
        

    @objc func doneButtonPressed(sender: UIBarButtonItem) {
        
        if(textField3.text == ""){
            textField3.text = String(pickerData[0])
        }
        textField3.resignFirstResponder()
        
    }
    @objc func pickUp(_ textField : UITextField){

         // UIPickerView
         self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
         self.myPickerView.delegate = self
         self.myPickerView.dataSource = self
         self.myPickerView.backgroundColor = UIColor.white
         textField.inputView = self.myPickerView
         toolBar.barStyle = .default
         toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
         toolBar.sizeToFit()
     }
    
   
    var collapse : Bool = false
    public var itemImageName : String = ""
    var categorychosen : String = "Book"
    var delegate:canReceive?
    let datepicker = UIDatePicker()

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

    
    func createSegmentedControl(){
        mySegmentedControl.selectedSegmentIndex = 0
        mySegmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        mySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        mySegmentedControl.selectedSegmentTintColor = .white
        mySegmentedControl.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        mySegmentedControl.layer.borderWidth = 1
        mySegmentedControl.backgroundColor = UIColor.white
                
             
            }
    func resetValues(){
        itemname.text = ""
        textField1.text = ""
        textField2.text = ""
        textField3.text = ""
        
    }
    func setLabelandPlaceholder(){
        if(categorychosen == "Book"){
            label1.text = categoryLabelDict["Books"]![0]
            label2.text = categoryLabelDict["Books"]![1]
            label3.text = categoryLabelDict["Books"]![2]
            textField1.placeholder = "Enter " + categoryLabelDict["Books"]![0]
            textField2.placeholder = "Enter " + categoryLabelDict["Books"]![1]
            textField3.inputAccessoryView = toolBar
            pickUp(textField3)
            textField3.placeholder = "Enter " + categoryLabelDict["Books"]![2]
            
        }
        else if(categorychosen == "Food"){
            label1.text = categoryLabelDict["Food"]![0]
            label2.text = categoryLabelDict["Food"]![1]
            label3.text = categoryLabelDict["Food"]![2]
            textField1.placeholder = "Enter " + categoryLabelDict["Food"]![0]
            textField2.placeholder = "Enter " + categoryLabelDict["Food"]![1]
            textField3.placeholder = "Enter " + categoryLabelDict["Food"]![2]
            textField3.inputAccessoryView = .none
            textField3.inputView = .none
            
        }
        else {
            label1.text = categoryLabelDict["Cloth"]![0]
            label2.text = categoryLabelDict["Cloth"]![1]
            label3.text = categoryLabelDict["Cloth"]![2]
            textField1.placeholder = "Enter " + categoryLabelDict["Cloth"]![0]
            textField2.placeholder = "Enter " + categoryLabelDict["Cloth"]![1]
            textField3.placeholder = "Enter " + categoryLabelDict["Cloth"]![2]
            textField3.inputAccessoryView = .none
            textField3.inputView = .none
            
        }
        
        
        print("\(categoryLabelDict["Books"]![0])")
    }
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
    override func viewDidLoad() {
        super.viewDidLoad()
        createSegmentedControl()
        createToolBar()
        setLabelandPlaceholder()
        createStepper()
        addresstextView.delegate = self
        othertextView.delegate = self
        presenter.delegate = self
        itemimage.image =  resizeImage(image: UIImage(named:"additem")!, newWidth: 200)
        addresstextView.text = "Enter address"
        addresstextView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        othertextView.text = "Enter Other Description"
        othertextView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        let upload = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(upload_item(_:)))
        self.navigationItem.rightBarButtonItem = upload
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel(_:)))
        self.navigationItem.leftBarButtonItem = cancel
        quantityStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        self.title = "Add Item"
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseimage1(tapGestureRecognizer:)))
      
        itemimage.isUserInteractionEnabled = true
        itemimage.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func stepperValueChanged(_ sender:UIStepper!)
        {
        textField4.text = String(Int(sender.value))
        }
    @objc func upload_item(_ sender: UIButton) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy HH:mm"
        let formattedDate = format.string(from: date)
        let userdefaults = UserDefaults.standard
        let userid = userdefaults.integer(forKey: "userid")
        let item = Item(item_id: 0, item_name: itemname.text!, item_image: itemImageName, category: categorychosen, address: addresstextView.text!, Donar_ID: userid, visited_count: 0, date: formattedDate)
        
        var flag = 0
        flag = additeminteractor.addItem(item: item)
        switch categorychosen{
        case "Book":
            insertBook(item_id: flag)
        case "Food":
            insertFood(item_id: flag)
        case "Cloth":
            insertCloth(item_id: flag)
        default :
            break
        }
        var descriptionValue : [String] = ["","","","",""]
        descriptionValue[0] = textField1.text!
        descriptionValue[1] = textField2.text!
        descriptionValue[2] = textField3.text!
        descriptionValue[3] = textField4.text!
        descriptionValue[4] = othertextView.text!
        if(flag != 0){
            item.item_id = flag
            delegate?.passData(item:item,item_image: itemImageName,description: descriptionValue)
            if(valuesCheck()){
            presenter.showSuccessAlert()
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.dismissinsertView()
            }))
        }
        }
    func insertBook(item_id : Int){
        let book : Books = Books(author: textField1.text!, publisher: textField2.text!, year_of_publish: textField3.text!, quantity: Int(textField4.text!)!, others: othertextView.text!)
        additeminteractor.addBook(itemid: item_id, book: book)
        
    }
    func insertFood(item_id : Int){
        let food : Food = Food(expiry_date: textField1.text!, cusine: textField2.text!, vegnonveg: textField3.text!, quantity: Int(textField4.text!)!, others: othertextView.text!)
        additeminteractor.addFood(itemid: item_id, food: food)
        
    }
    func insertCloth(item_id : Int){
        let cloth : Cloth = Cloth(size: textField1.text!, clothCategory: textField2.text!, gender: textField3.text!, quantity: Int(textField4.text!)!, others: othertextView.text!)
        additeminteractor.addCloth(itemid: item_id, cloth: cloth)
        
    }
    func dismissinsertView(){
        self.dismiss(animated: true)
    }
    @objc func cancel(_ sender: UIButton) {
        if(valuesChanged()){
        self.present(actionSheet,animated: true)
        }
        else{
            self.dismiss(animated: true)
        }
    }
    func valuesChanged() -> Bool{
       
        if(itemname.text! == ""  && textField1.text! == "" && textField2.text! == "" &&
            textField3.text! == "" && textField4.text! == "1" && addresstextView.text! == "Enter address"){
            return false
        }
        else{
            return true
        }
    }
    func valuesCheck() -> Bool{
       
        if(itemname.text! == ""  || textField1.text! == "" || textField2.text! == "" ||
            textField3.text! == "" || textField4.text! == "1" || addresstextView.text! == "Enter address"){
            return false
        }
        else{
            return true
        }
    }
    @objc func chooseimage1(tapGestureRecognizer: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
    }

    override func viewDidLayoutSubviews() {
        for i in 1950 ... 2021{
            pickerData.append(i)
        }
        //super.viewDidLoad()
        view.backgroundColor = .white
        let contentViewSize = CGSize(width: self.view.frame.width, height: self.stackView.frame.height + 30)
        scrollView.contentSize = contentViewSize
        scrollView.delegate = self
        quantityStepper.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        
       
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        
        stackView.addArrangedSubview(itemimage)
        stackView.addArrangedSubview(mySegmentedControl)
        stackView.addArrangedSubview(bookStackView)
        bookStackView.addArrangedSubview(itemNameLabel)
        bookStackView.addArrangedSubview(itemname)
        bookStackView.addArrangedSubview(label1)
        bookStackView.addArrangedSubview(textField1)
        bookStackView.addArrangedSubview(label2)
        bookStackView.addArrangedSubview(textField2)
        bookStackView.addArrangedSubview(label3)
        bookStackView.addArrangedSubview(textField3)
        
        bookStackView.addArrangedSubview(quantitylabel)
        bookStackView.addArrangedSubview(quantityStackView)
        quantityStackView.addArrangedSubview(textField4)
        quantityStackView.addArrangedSubview(quantityStepper)
        stackView.addArrangedSubview(addresslabel)
        stackView.addArrangedSubview(addresstextView)
        stackView.addArrangedSubview(otherlabel)
        stackView.addArrangedSubview(othertextView)

        // Do any additional setup after loading the view.
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22) && textView == addresstextView {
            textView.text = ""

            textView.textColor = UIColor.black
        }
        else if textView.textColor == UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22) && textView == othertextView{
            
            textView.text = ""
            textView.textColor = UIColor.black
        }
  }
    func textViewDidEndEditing(_ textView: UITextView) {
        if addresstextView.text.isEmpty && textView == addresstextView {
            textView.text = "Enter Address"
            textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        }
        else if othertextView.text.isEmpty && textView == othertextView{
            textView.text = "Enter Other description"
            textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        itemImageName = imageName
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        DispatchQueue.main.async {
           
            self.itemimage.image = self.resizeImage(image: image, newWidth: 200)
           // self.itemimage.image = self.resizeImage(image: image, newWidth: 200)
                 }
        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
            
        ])
        
        
        compactConstraints.append(contentsOf: [

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
          
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.75),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 10),
           // stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
          //  quantityStackView.topAnchor.constraint(equalTo: quantitylabel.bottomAnchor),
            quantityStackView.centerXAnchor.constraint(equalTo: bookStackView.centerXAnchor),
//            addresstextView.topAnchor.constraint(equalTo: addresslabel.bottomAnchor),
//            addresstextView.bottomAnchor.constraint(equalTo: otherlabel.topAnchor),
//            othertextView.topAnchor.constraint(equalTo: ot.bottomAnchor),
//            addresstextView.bottomAnchor.constraint(equalTo: otherlabel.topAnchor),
            
           // stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
           
        ])
        
        regularConstraints.append(contentsOf: [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
          
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.5),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 10),
            quantityStackView.centerXAnchor.constraint(equalTo: bookStackView.centerXAnchor)

           

        ])
    }
}
extension AddItemViewController : AddItemPresenterDelegate{
    func showSuccessAlert() {
        self.present(alert, animated: true, completion: nil)
        }
}
