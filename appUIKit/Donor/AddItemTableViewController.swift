
import UIKit
protocol canReceive{
    func passData(item:Item,item_image:String,description:[String])
}


class AddItemTableViewController: UIViewController,UIAdaptivePresentationControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
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
                item.item_name = ""
                item.address = ""
                descriptionValue = ["","","","",""]
                addItemTableView.reloadData()
                print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
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
        let cell = self.addItemTableView.cellForRow(at: IndexPath(row: 3, section: 1)) as! DescriptionTableViewCell
        cell.textField.text = String(pickerData[row])
        descriptionValue[2] = String(pickerData[row])
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(categorychosen == "Book"){
            print("\(categorychosen)")
            self.pickUp(textField)
        }
        
        

    }
    @objc func doneButtonPressed(sender: UIBarButtonItem) {
        
        let cell = self.addItemTableView.cellForRow(at: IndexPath(row: 3, section: 1)) as! DescriptionTableViewCell
        if(cell.textField.text == ""){
            cell.textField.text = String(pickerData[0])
        }
        cell.textField.resignFirstResponder()
        
    }
    @objc func pickUp(_ textField : UITextField){

         // UIPickerView
         self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
         self.myPickerView.delegate = self
         self.myPickerView.dataSource = self
         self.myPickerView.backgroundColor = UIColor.white
         textField.inputView = self.myPickerView

         // ToolBar
         //let toolBar = UIToolbar()
         toolBar.barStyle = .default
         toolBar.isTranslucent = true
      toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
         toolBar.sizeToFit()

         // Adding Button ToolBar
     
 //       toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
 //       toolBar.isUserInteractionEnabled = true
 //   textField.inputAccessoryView = toolBar

     }
    
   
    let item :Item = Item()
    var descriptionValue : [String] = ["","","","",""]
    var collapse : Bool = false
    let additeminteractor = AddItemInteractor()
    var categoryLabelDict:[String:[String]] = ["Books":["Author","Publisher","Published Year","Quantity"],
                                               "Food":["Expiry Date","Cuisine","Veg/Non Veg","Quantity"],
                                               "Cloth":["Size","Cloth Category","Gender","Quantity"]]
    public var itemImageName : String = ""
    var categorychosen : String = "Book"
    var delegate:canReceive?
    var itemimage = UIImageView()
    let addItemTableView = UITableView()
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

    func textViewDidChange(_ textView: UITextView)
        {
        
        if(textView.tag == 16){
            descriptionValue[4] = textView.text!
        }
        else if(textView.tag == 15){
            item.address = textView.text!
        }
            if textView.contentSize.height >= 120.0
            {
                print("Hii")
                textView.isScrollEnabled = true
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
                textView.isScrollEnabled = false
            }
        }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22) && textView.tag == 15 {
            textView.text = nil

            textView.textColor = UIColor.black
        }
        else if textView.textColor == UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22) && textView.tag == 16{
            
            textView.text = nil
            textView.textColor = UIColor.black
        }
  }
    func textViewDidEndEditing(_ textView: UITextView) {
        if item.address.isEmpty && textView.tag == 15 {
            textView.text = "Enter Address"
            textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        }
        else if descriptionValue[4].isEmpty && textView.tag == 16 {
            textView.text = "Enter Other description"
            textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(section == 1){
//            return  collapse && categorychosen != "" ? 5 : 0
//        }
        if(section == 0){
            return 1
        }
        return 7
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 1){
          
            if(indexPath.row == 5) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemaddress", for: indexPath) as! TextViewTableViewCell
            cell.textView.delegate = self
            cell.textView.tag = Int(String(indexPath.section)+String(indexPath.row))!
            cell.label.text = "Address"
                cell.textView.text = item.address
            if(item.address == ""){
                
            cell.textView.text = "Enter Address"
                cell.textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
            }
            else{
                cell.textView.text = item.address
                cell.textView.textColor = UIColor.black
            }
          
            return cell;
        }
           else if(indexPath.row == 6){
                let cell : TextViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemdescription5", for: indexPath) as! TextViewTableViewCell
                cell.textView.delegate = self
                cell.textView.tag = Int(String(indexPath.section)+String(indexPath.row))!
                cell.label.text = "Other Description"
            cell.textView.text = descriptionValue[4]
                if(descriptionValue[4] == ""){
                    
                cell.textView.text = "Enter other description"
                cell.textView.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
                }
                else{
                    cell.textView.text = descriptionValue[4]
                    cell.textView.textColor = UIColor.black
                }
                return cell
            }
            else if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemname", for: indexPath) as! ItemNameTableViewCell
            cell.itemname.tag = Int(String(indexPath.section)+String(indexPath.row))!
                cell.itemname.text = item.item_name
            cell.itemname.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
            return cell
            }
            else if(indexPath.row == 4){
            let cell : QuantityTableViewCell
        
            
                cell = tableView.dequeueReusableCell(withIdentifier: "itemquantity", for: indexPath) as! QuantityTableViewCell
            cell.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
                cell.textField.text = descriptionValue[3]
          //  cell.textField.delegate = self
            cell.textField.tag = Int(String(indexPath.section)+String(indexPath.row))!
//                if(indexPath.row == 4){
                    cell.myUIStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
//                }
            switch categorychosen
            {
            case "Book":
                if(indexPath.row == 3){
                    cell.textField.delegate = self
                    cell.textField.inputAccessoryView = toolBar
                    cell.stackView.axis = .horizontal
                }
                cell.categoryClicked = categoryLabelDict["Books"]![indexPath.row - 1]
                cell.textField.placeholder = "Enter "+categoryLabelDict["Books"]![indexPath.row - 1]
            case "Food":
                cell.categoryClicked = categoryLabelDict["Food"]![indexPath.row - 1]
                cell.textField.placeholder = "Enter "+categoryLabelDict["Food"]![indexPath.row - 1]
            case "Cloth":
                cell.categoryClicked = categoryLabelDict["Cloth"]![indexPath.row - 1]
                cell.textField.placeholder = "Enter "+categoryLabelDict["Cloth"]![indexPath.row - 1]
            default:
                cell.categoryClicked = ""
            }
            return cell;
        }
            else{
            let cell : DescriptionTableViewCell
        
            
                cell = tableView.dequeueReusableCell(withIdentifier: "itemdescription", for: indexPath) as! DescriptionTableViewCell
            cell.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
                cell.textField.text = descriptionValue[indexPath.row-1]
          //  cell.textField.delegate = self
            cell.textField.tag = Int(String(indexPath.section)+String(indexPath.row))!
//                if(indexPath.row == 4){
//                    cell.myUIStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
//                }
                if(indexPath.row == 3 && categorychosen == "Book"){
                    cell.textField.delegate = self
                    cell.textField.inputAccessoryView = toolBar
                    cell.stackView.axis = .horizontal
                    cell.stackView.spacing = 15
                    cell.stackView.distribution = .fillEqually
                    cell.textField.textAlignment = .right
                }
                else{
                    cell.stackView.axis = .vertical
                    cell.textField.textAlignment = .left
                    cell.textField.inputAccessoryView = .none
                }
            switch categorychosen
            {
            case "Book":
               
                cell.categoryClicked = categoryLabelDict["Books"]![indexPath.row - 1]
                cell.textField.placeholder = "Enter "+categoryLabelDict["Books"]![indexPath.row - 1]
            case "Food":
                cell.categoryClicked = categoryLabelDict["Food"]![indexPath.row - 1]
                cell.textField.placeholder = "Enter "+categoryLabelDict["Food"]![indexPath.row - 1]
            case "Cloth":
                cell.categoryClicked = categoryLabelDict["Cloth"]![indexPath.row - 1]
                cell.textField.placeholder = "Enter "+categoryLabelDict["Cloth"]![indexPath.row - 1]
            default:
                cell.categoryClicked = ""
            }
            return cell;
        }
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemimage", for: indexPath) as! DonorImageTableViewCell
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseimage1(tapGestureRecognizer:)))
            cell.mySegmentedControl.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
            cell.itemimage.isUserInteractionEnabled = true
            cell.itemimage.addGestureRecognizer(tapGestureRecognizer)
            cell.itemimage.image = resizeImage(image: UIImage(named:"additem")!, newWidth: 200)
            return cell
        }
    }
    @objc func textChanged(_ textField : UITextField){
        let tableRow = textField.tag
        switch tableRow{
        case 10:
            item.item_name = textField.text!
        case 11:
            descriptionValue[0] = textField.text!
        case 12:
            descriptionValue[1] = textField.text!
        case 13:
            descriptionValue[2] = textField.text!
        case 14:
            descriptionValue[3] = textField.text!
            if Double(textField.text!) != nil {
                let cell = self.addItemTableView.cellForRow(at: IndexPath(row: 4, section: 1)) as! QuantityTableViewCell
                cell.myUIStepper.value = Double(textField.text!)!
                   }
        default:
            return
        }
    }
    @objc func stepperValueChanged(_ sender:UIStepper!)
        {
            let cell = self.addItemTableView.cellForRow(at: IndexPath(row: 4, section: 1)) as! QuantityTableViewCell
            cell.textField.text = String(Int(sender.value))
        descriptionValue[3] = String(Int(sender.value))
            print("UIStepper is now \(Int(sender.value))")
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 1){
            if(indexPath.row == 5 || indexPath.row == 6){
            return 120
        }
        else{
            if((categorychosen == "Book" && indexPath.row == 3) || indexPath.row == 4){
                return 50
            }
            return 80
        }
        }
        return 250
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 1 ){
        return 40.0
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 1){

        let tview = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 25))
            let label = UILabel(frame: CGRect(x: 10, y: -6.25, width: 100, height: 50))
        label.text = "Details"
            label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
            label.baselineAdjustment = .alignCenters
            tview.backgroundColor = #colorLiteral(red: 0.9076080322, green: 0.9077602029, blue: 0.9075879455, alpha: 1)
        self.view.addSubview(tview)
        tview.addSubview(label)

        return tview
        }
        return nil
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if(section == 1){
//        return "Details"
//        }
//        else{
//            return ""
//        }
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
            return nil
        }
    let presenter = AddItemPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1950 ... 2021{
            pickerData.append(i)
        }
        self.addItemTableView.sectionHeaderHeight = 40
      //  view.addSubview(tview)
       
        
      //  self.navigationController?.navigationBar.topItem?.title = "SignUp"
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        createToolBar()
        let upload = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(upload_item(_:)))
        self.navigationItem.rightBarButtonItem = upload
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel(_:)))
        self.navigationItem.leftBarButtonItem = cancel
        self.title = "Add Item"
        view.backgroundColor = .white
        itemimage.translatesAutoresizingMaskIntoConstraints = false
        addItemTableView.dataSource = self
        addItemTableView.delegate = self
        addItemTableView.register(DonorImageTableViewCell.self, forCellReuseIdentifier: "itemimage")
        addItemTableView.register(ItemNameTableViewCell.self, forCellReuseIdentifier: "itemname")
        addItemTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "itemcategory")
        addItemTableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: "itemaddress")
        addItemTableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "itemdescription")
        addItemTableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: "itemdescription5")
        addItemTableView.register(QuantityTableViewCell.self, forCellReuseIdentifier: "itemquantity")
        addItemTableView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        view.addSubview(addItemTableView)
       // view.addSubview(itemimage)
        
        
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
        presenter.delegate = self
        self.isModalInPresentation = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddItemTableViewController.keyboardWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddItemTableViewController.keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
       // NSNotificationCenter.default.addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardWillHide(notification: Notification) {
        addItemTableView.setBottomInset(to: 0.0)
    }
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            addItemTableView.setBottomInset(to: keyboardHeight)
        }
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
        var valueEntered : Bool = false
        for i in 0...4{
            if(descriptionValue[i] != ""){
                valueEntered = true
                break
            }
        }
        if(item.item_name == "" && item.address == "" && valueEntered == false){
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
    @objc func upload_item(_ sender: UIButton) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy HH:mm"
        let formattedDate = format.string(from: date)
        let userdefaults = UserDefaults.standard
        let userid = userdefaults.integer(forKey: "userid")
        item.date = formattedDate
        item.visited_count = 0
        item.Donar_ID = userid
        item.category = categorychosen
        item.item_image = itemImageName
        var flag = 0
        flag = additeminteractor.addItem(item: item)
        switch categorychosen{
        case "Book":
            insertBook(item_id: flag, value: descriptionValue)
        case "Food":
            insertFood(item_id: flag, value: descriptionValue)
        case "Cloth":
            insertCloth(item_id: flag, value: descriptionValue)
        default :
            break
        }
        if(flag != 0){
            item.item_id = flag
            delegate?.passData(item:item,item_image: itemImageName,description: descriptionValue)
            presenter.showSuccessAlert()
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.dismissinsertView()
            }))
        }
        }
    func insertBook(item_id : Int,value : [String]){
        let book : Books = Books(author: value[0], publisher: value[1], year_of_publish: value[2], quantity: Int(value[3])!, others: value[4])
        additeminteractor.addBook(itemid: item_id, book: book)
        
    }
    func insertFood(item_id : Int,value : [String]){
        let food : Food = Food(expiry_date: value[0], cusine: value[1], vegnonveg: value[2], quantity: Int(value[3])!, others: value[4])
        additeminteractor.addFood(itemid: item_id, food: food)
        
    }
    func insertCloth(item_id : Int,value : [String]){
        let cloth : Cloth = Cloth(size: value[0], clothCategory: value[1], gender: value[2], quantity: Int(value[3])!, others: value[4])
        additeminteractor.addCloth(itemid: item_id, cloth: cloth)
        
    }
    func dismissinsertView(){
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()

    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
            return false
        }

        func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
            present(actionSheet, animated: true)
        }

}
extension AddItemTableViewController {
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
            addItemTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 20),
            addItemTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            addItemTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            addItemTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            
//            itemimage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            itemimage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 30),

        ])

        regularConstraints.append(contentsOf: [
            addItemTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,constant: 10),
            addItemTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            addItemTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            addItemTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            

        ])
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
            let cell = self.addItemTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! DonorImageTableViewCell
            cell.itemimage.image = self.resizeImage(image: image, newWidth: 200)
           // self.itemimage.image = self.resizeImage(image: image, newWidth: 200)
                 }
        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

        let newHeight = CGFloat(200.0)
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
extension AddItemTableViewController : AddItemPresenterDelegate{
    func showSuccessAlert() {
        self.present(alert, animated: true, completion: nil)
        }
}


extension UITableView {

    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}



