
import UIKit
protocol canReceive{
    func passData(item:Item,item_image:String,description:[String])
}


class AddItemTableViewController: UIViewController,UIAdaptivePresentationControllerDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,chooseCategory,UIViewControllerTransitioningDelegate {
    func chooseCategory(category: String) {
        categorychosen = category
        addItemTableView.reloadData()
        addItemTableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .automatic)
    }
    let item :Item = Item()
    var descriptionValue : [String] = ["","","","",""]
    var collapse : Bool = false
    let additeminteractor = AddItemInteractor()
    var categoryLabelDict:[String:[String]] = ["Books":["Author","Publisher","Year","Quantity"],
                                               "Food":["Expiry Date","Cuisine","Veg/Non Veg","Quantity"],
                                               "Cloth":["Size","Cloth Category","Gender","Quantity"]]

    public var itemImageName : String = ""
    var categorychosen : String = ""
    var delegate:canReceive?
    
    var itemimage = UIImageView()
    let addItemTableView = UITableView()


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
        if(textView.tag == 14){
            descriptionValue[4] = textView.text!
        }
        else if(textView.tag == 2){
            item.address = textView.text!
        }
            if textView.contentSize.height >= 120.0
            {
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
        if textView.textColor == UIColor.lightGray && textView.tag == 2 {
            textView.text = nil

            textView.textColor = UIColor.black
        }
        else if textView.textColor == UIColor.lightGray && textView.tag == 14{
            
            textView.text = nil
            textView.textColor = UIColor.black
        }
  }
    func textViewDidEndEditing(_ textView: UITextView) {
        if item.address.isEmpty && textView.tag == 2 {
            textView.text = "Enter the Adddress"
            textView.textColor = UIColor.lightGray
        }
        else if descriptionValue[4].isEmpty && textView.tag == 14 {
            textView.text = "Enter Other description"
            textView.textColor = UIColor.lightGray
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            return  collapse && categorychosen != "" ? 5 : 0
        }
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            if(indexPath.row == 0){
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemname", for: indexPath) as! ItemNameTableViewCell
        cell.itemname.tag = Int(String(indexPath.section)+String(indexPath.row))!
        cell.itemname.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        return cell;
        }

        else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcategory", for: indexPath) as! CategoryTableViewCell
            cell.categoryButton.addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
            if(categorychosen != ""){
                cell.categoryButton.setTitle(categorychosen, for: .normal)
                cell.categoryButton.setTitleColor(.black, for: .normal)
            }
            else{
                cell.categoryButton.setTitle("choose a category", for: .normal)
            }
            return cell;
            }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemaddress", for: indexPath) as! TextViewTableViewCell
            cell.textView.delegate = self
            cell.textView.tag = Int(String(indexPath.section)+String(indexPath.row))!
            cell.label.text = "Address"
            if(item.address == ""){
                
            cell.textView.text = "Enter Address"
                cell.textView.textColor = UIColor.lightGray
            }
            else{
                cell.textView.text = item.address
                cell.textView.textColor = UIColor.black
            }
          
            return cell;
        }
        }
        
        else {
            if(indexPath.row == 4){
                let cell : TextViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemdescription5", for: indexPath) as! TextViewTableViewCell
                cell.textView.delegate = self
                cell.textView.tag = Int(String(indexPath.section)+String(indexPath.row))!
                cell.label.text = "Other Description"
                if(descriptionValue[4] == ""){
                    
                cell.textView.text = "Enter other description"
                cell.textView.textColor = UIColor.lightGray
                }
                else{
                    cell.textView.text = descriptionValue[4]
                    cell.textView.textColor = UIColor.black
                }
                return cell
            }
            else{
            let cell : DescriptionTableViewCell
            
            switch indexPath.row{
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "itemdescription1", for: indexPath) as! DescriptionTableViewCell
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "itemdescription2", for: indexPath) as! DescriptionTableViewCell
            case 2:
                cell = tableView.dequeueReusableCell(withIdentifier: "itemdescription3", for: indexPath) as! DescriptionTableViewCell
                
            default:
                cell = tableView.dequeueReusableCell(withIdentifier: "itemdescription4", for: indexPath) as! DescriptionTableViewCell
            
            
            }
            cell.textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
            cell.textField.delegate = self
            cell.textField.tag = Int(String(indexPath.section)+String(indexPath.row))!
            switch categorychosen
            {
            case "Book":
                cell.categoryClicked = categoryLabelDict["Books"]![indexPath.row]
                cell.textField.placeholder = "Enter "+categoryLabelDict["Books"]![indexPath.row]
            case "Food":
                cell.categoryClicked = categoryLabelDict["Food"]![indexPath.row]
                cell.textField.placeholder = "Enter "+categoryLabelDict["Food"]![indexPath.row]
            case "Cloth":
                cell.categoryClicked = categoryLabelDict["Cloth"]![indexPath.row]
                cell.textField.placeholder = "Enter "+categoryLabelDict["Cloth"]![indexPath.row]
            default:
                cell.categoryClicked = ""
            }
            return cell;
        }
        }
    }
    @objc func textChanged(_ textField : UITextField){
        let tableRow = textField.tag
        switch tableRow{
        case 0:
            item.item_name = textField.text!
        case 10:
            descriptionValue[0] = textField.text!
        case 11:
            descriptionValue[1] = textField.text!
        case 12:
            descriptionValue[2] = textField.text!
        case 13:
            descriptionValue[3] = textField.text!
        default:
            return
        }
    }
    @objc func selectCategory(_ sender: UIButton) {
        let vc = CategoryViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
        if(indexPath.row == 1){
            return 80
        }
        else if(indexPath.row == 0){
            return 70
        }
        
        else{
            return 120
        }
        }
        else{
            return 80
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 1){
        return "Description"
        }
        else{
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if(section == 1){
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? DescriptionTableViewHeader ?? DescriptionTableViewHeader(reuseIdentifier: "header")
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "arrowtriangle.right.fill")
        let attachmentString = NSMutableAttributedString(attachment: attachment)
        header.arrowLabel.attributedText = attachmentString
        header.setCollapsed(!collapse)
        header.section = section
        header.delegate = self
        return header
    }
    else{
        return UIView()
    }
        }
    let presenter = AddItemPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        let upload = UIBarButtonItem(title: "Upload", style: .plain, target: self, action: #selector(upload_item(_:)))
        self.navigationItem.rightBarButtonItem = upload
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel(_:)))
        self.navigationItem.leftBarButtonItem = cancel
        self.title = "Add Item"
        view.backgroundColor = .white
        itemimage.translatesAutoresizingMaskIntoConstraints = false
        addItemTableView.dataSource = self
        addItemTableView.delegate = self
        addItemTableView.register(ItemNameTableViewCell.self, forCellReuseIdentifier: "itemname")
        addItemTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "itemcategory")
        addItemTableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: "itemaddress")
        addItemTableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "itemdescription1")
        addItemTableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "itemdescription2")
        addItemTableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "itemdescription3")
        addItemTableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "itemdescription4")
        addItemTableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: "itemdescription5")
        addItemTableView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        view.addSubview(addItemTableView)
        view.addSubview(itemimage)
        itemimage.image = resizeImage(image: UIImage(named:"additem")!, newWidth: 200)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseimage1(tapGestureRecognizer:)))
            itemimage.isUserInteractionEnabled = true
            itemimage.addGestureRecognizer(tapGestureRecognizer)
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
        self.present(actionSheet,animated: true)
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
            addItemTableView.topAnchor.constraint(equalTo:itemimage.bottomAnchor,constant: 5),
            addItemTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            addItemTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            addItemTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            
            itemimage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            itemimage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 30),

        ])

        regularConstraints.append(contentsOf: [
            addItemTableView.topAnchor.constraint(equalTo:itemimage.bottomAnchor,constant: 10),
            addItemTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            addItemTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            addItemTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            
            itemimage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            itemimage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 10),
            itemimage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
            itemimage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25)

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
            self.itemimage.image = self.resizeImage(image: image, newWidth: 200)
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
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CategorySizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
extension AddItemTableViewController : AddItemPresenterDelegate{
    func showSuccessAlert() {
        self.present(alert, animated: true, completion: nil)
        }
}
extension AddItemTableViewController: CollapsibleTableViewHeaderDelegate {

    func toggleSection(_ header: DescriptionTableViewHeader, section: Int) {
        let collapsed = !collapse
        collapse.toggle()
        header.setCollapsed(collapsed)
        addItemTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        
    }
}
class CategorySizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        return CGRect(x: 0, y: bounds.height / 1.75, width: bounds.width, height: 170)
    }
}
extension UITableView {

    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)

        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}



