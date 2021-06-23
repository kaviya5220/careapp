//
//  SignupViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//



import UIKit
import CryptoSwift

class SignupViewController: UIViewController{
    var endata : String = ""
    var dcdata : String = ""
    var flag : Bool = true
    let signupInteractor = SignupInteractor()
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
    let phone:CustomField = {
        let field = CustomField()
        field.textField.placeholder = "Enter phone"
        return field
    }()
    let address:UITextField = {
        let addressfield = CustomTextField()
        addressfield.placeholder = "Enter address"
        return addressfield
    }()
    let emailField:CustomField = {
        let field = CustomField()
        field.textField.placeholder = "Enter email"
        field.textField.keyboardType = UIKeyboardType.emailAddress
        return field
    }()
    let password:UITextField = {
        let password = CustomTextField()
        password.placeholder = "Enter password"
        password.isSecureTextEntry = true
        return password
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
        view.backgroundColor = .white
        setupConstraints()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
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
        
        navigationItem.title = .none
        signUpPresenter.delegate = self
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    @objc func insertUser(_ sender: UIButton) {
        flag = true
        if(signUpPresenter.validateEmailId(emailId: emailField.getFiledText())==false){
            flag = false
            
//           dcdata = try! aesDecrypt()
//            print(dcdata)
            
        }
        if(signUpPresenter.validateMobile(mobile: phone.getFiledText())==false){
            flag = false
        }
        if(flag){
            endata = try! aesEncrypt(password: password.text!)
            print(endata)
            let user: User = User(user_name: name.text!, user_phone: phone.getFiledText()!, user_address: address.text!, user_email: emailField.getFiledText()!, user_password: endata)
        signupInteractor.insertUser(user: user)
        self.showToast(message: "Submitted Successfully", font: .systemFont(ofSize: 12.0))
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
        
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
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
           // submitbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            //submitbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        regularConstraints.append(contentsOf: [
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            signuplabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
           // submitbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            //submitbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
}
extension SignupViewController : SignUpPresenterDelegate{
    func removeEmailError() {
        emailField.removeError()
    }
    
    func removeMobileNumberError() {
        phone.removeError()
    }
    
    func showEmailError(errorMessage: String?) {
        emailField.setError(errorMessage: "Email Format Wrong")
    }
    
    func showMobileError(errorMessage: String?) {
        phone.setError(errorMessage: "Mobile Format Wrong")
    }
    
   
    
}

