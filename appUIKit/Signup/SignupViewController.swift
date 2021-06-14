//
//  SignupViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//



import UIKit

class SignupViewController: UIViewController {
    var flag : Bool = true
    let signupInteractor = SignupInteractor()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let signuplabel:CustomLabel = {
        let label = CustomLabel(labelType: .title)
        label.text = "SIGN UP"
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
        return field
    }()
    let password:UITextField = {
        let password = CustomTextField()
        password.placeholder = "Enter password"
        return password
    }()
    
    let addbutton:UIButton = {
        let button = CustomButton(title: "SUBMIT", bgColor: .black)
        button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
        return button
    }()
    
    let signUpPresenter = SignupPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Signup"
        view.backgroundColor = .white
        view.addSubview(stackView)
        view.addSubview(signuplabel)
        stackView.addArrangedSubview(name)
        stackView.setCustomSpacing(25, after: name)
        stackView.addArrangedSubview(address)
        stackView.setCustomSpacing(25, after: address)
        stackView.addArrangedSubview(password)
        stackView.setCustomSpacing(25, after: password)
        stackView.addArrangedSubview(emailField)
        stackView.setCustomSpacing(25, after: emailField)
        stackView.addArrangedSubview(phone)
        stackView.setCustomSpacing(25, after: phone)
        view.addSubview(addbutton)
        
        signuplabel.translatesAutoresizingMaskIntoConstraints = false
        signuplabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 30).isActive = true
        signuplabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.signuplabel.bottomAnchor,constant: 25).isActive = true
        stackView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:20).isActive = true
        stackView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant:-10).isActive = true
        
        addbutton.translatesAutoresizingMaskIntoConstraints = false
        addbutton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor,constant: 25).isActive = true
        addbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        navigationItem.title = .none
        signUpPresenter.delegate = self
    }

    @objc func insertUser(_ sender: UIButton) {
        flag = true
        if(signUpPresenter.validateEmailId(emailId: emailField.getFiledText())==false){
            flag = false
        }
        if(signUpPresenter.validateMobile(mobile: phone.getFiledText())==false){
            flag = false
        }
        if(flag){
            let user: User = User(user_name: name.text!, user_phone: phone.getFiledText()!, user_address: address.text!, user_email: emailField.getFiledText()!, user_password: password.text!)
        signupInteractor.insertUser(user: user)
        self.showToast(message: "Submitted Successfully", font: .systemFont(ofSize: 12.0))
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
        
        }
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

