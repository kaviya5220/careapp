//
//  SignupViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//



import UIKit
import CryptoSwift
protocol SignUpProtocol {
    func signUpSUccessful()
}
class SignupViewController: UIViewController,UIScrollViewDelegate{
    var endata : String = ""
    var dcdata : String = ""
    var flag : Bool = true
    var delegate:SignUpProtocol?
    let signupInteractor = SignupInteractor()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let scrollView : UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    let signuplabel:CustomLabel = {
        let label = CustomLabel(labelType: .title)
        label.text = "SIGN UP"
        label.textAlignment = .center
        return label
    }()
    let name:UITextField = {
        let namefield = CustomTextField()
        
        namefield.placeholder = "Enter name"
        return namefield
    }()
//    let phone:CustomField = {
//        let field = CustomField()
//        field.textField.placeholder = "Enter phone"
//        return field
//    }()
    let address:UITextField = {
        let addressfield = CustomTextField()
        addressfield.placeholder = "Enter address"
        return addressfield
    }()
//    let emailField:CustomField = {
//        let field = CustomField()
//        field.textField.placeholder = "Enter email"
//        field.textField.keyboardType = UIKeyboardType.emailAddress
//        return field
//    }()
    let password:UITextField = {
        let password = CustomTextField()
        password.placeholder = "Enter password"
        password.isSecureTextEntry = true
        return password
    }()
    let emailField:UITextField = {
        let email = CustomTextField()
        email.placeholder = "Enter email"
        email.keyboardType = UIKeyboardType.emailAddress
        email.autocapitalizationType = UITextAutocapitalizationType.none
        return email
    }()
    let phone:UITextField = {
        let phone = CustomTextField()
        phone.placeholder = "Enter phone"
        phone.keyboardType = UIKeyboardType.phonePad
        return phone
    }()
    
    let submitbutton:UIButton = {
        let button = CustomButton(title: "SUBMIT", bgColor: .black)
        button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
        return button
    }()
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
    
    let signUpPresenter = SignupPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Signup"
        navigationItem.title = "SignUp"
//        navigationItem.
//        navigationItem.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        view.backgroundColor = .white
        setupConstraints()
        view.addSubview(stackView)
       // scrollView.addSubview(stackView)
        stackView.addArrangedSubview(signuplabel)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(address)
        stackView.addArrangedSubview(password)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(phone)
        stackView.addArrangedSubview(submitbutton)
        
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
        //print("ajhkjae\(stackView.heightAnchor)")
//        var bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y:35, width: self.name.widthAnchor, height: 1.0)
//        bottomLine.borderColor = UIColor.black.cgColor
//        bottomLine.backgroundColor = UIColor.black.cgColor
//        bottomLine.borderWidth = 1
//        name.borderStyle = UITextField.BorderStyle.none
//        name.layer.addSublayer(bottomLine)
////
        
        let contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
                scrollView.contentSize = contentViewSize
               // containerView.frame.size = contentViewSize
                scrollView.frame = view.bounds
                scrollView.delegate = self
        
      //  signUpPresenter.delegate = self
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
   
   


    
    @objc func insertUser(_ sender: UIButton) {
        flag = true
//        if(signUpPresenter.validateEmailId(emailId: emailField.getFiledText())==false){
//            flag = false
//
//
//        }
//        if(signUpPresenter.validateMobile(mobile: phone.getFiledText())==false){
//            flag = false
//        }
        if(flag){
            endata = try! aesEncrypt(password: password.text!)
            print(endata)
            let user: User = User(user_name: name.text!, user_phone: phone.text!, user_address: address.text!, user_email:emailField.text!, user_password: endata)
            signupInteractor.insertUser(user: user)
            delegate?.signUpSUccessful()
        
        }
    }
    func aesEncrypt(password:String) throws -> String {
        let key: String  = "secret0key000000"
        let iv:  String  = "0000000000000000"
        let data : [UInt8] = Array(password.utf8)
        let encrypted = try AES(key: key, iv: iv, padding: .pkcs7).encrypt(data)
        return Data(encrypted).base64EncodedString()
    }
    
}
extension SignupViewController {
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
            signuplabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
           // submitbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            //submitbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        regularConstraints.append(contentsOf: [
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //signuplabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           // submitbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            //submitbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
}
//extension SignupViewController : SignUpPresenterDelegate{
//    func removeEmailError() {
//        emailField.removeError()
//    }
//
//    func removeMobileNumberError() {
//        phone.removeError()
//    }
//
//    func showEmailError(errorMessage: String?) {
//        emailField.setError(errorMessage: "Email Format Wrong")
//    }
//
//    func showMobileError(errorMessage: String?) {
//        phone.setError(errorMessage: "Mobile Format Wrong")
//    }
//}
extension UITextField {
  func useUnderline() -> Void {
    let border = CALayer()
    let borderWidth = CGFloat(2.0) // Border Width
    border.borderColor = UIColor.red.cgColor
    
    border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
    border.borderWidth = borderWidth
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
}
