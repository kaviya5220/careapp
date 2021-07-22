//
//  SignupViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//



import UIKit
protocol SignUpProtocol {
    func signUpSUccessful()
}
class SignupViewController: UIViewController,UIScrollViewDelegate{
    var flag : Bool = true
    var delegate:SignUpProtocol?
    let signupInteractor = SignupInteractor()
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
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
    let address:UITextField = {
        let addressfield = CustomTextField()
        addressfield.placeholder = "Enter address"
        return addressfield
    }()
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
    let signuplabel1:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Already have an account?"
        label.font = UIFont(name: "TimesNewRomanPSMT", size: 18)
        label.textAlignment = .center
        
        return label
    }()
    let horizontalstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let signuplabel2:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Sign In"
        label.textColor = .systemBlue
        label.textAlignment = .center
        
        return label
    }()
    let submitbutton:UIButton = {
        let button = CustomButton(title: "SUBMIT", bgColor: .black)
        button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
        return button
    }()
    let emailerrorlabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.isHidden = true
        label.textAlignment = .center
        label.textColor = .systemRed
        return label
    }()
    let phoneerrorlabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.textColor = .systemRed
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
    
    let signUpPresenter = SignupPresenter()

    override func viewDidLayoutSubviews() {
        view.backgroundColor = .white
        setupConstraints()
        let contentViewSize = CGSize(width: self.view.frame.width, height: 450)
                scrollView.contentSize = contentViewSize
               // scrollView.frame = view.bounds
                scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .automatic
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        horizontalstackView.addArrangedSubview(signuplabel1)
        horizontalstackView.addArrangedSubview(signuplabel2)
        stackView.addArrangedSubview(signuplabel)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(address)
        stackView.addArrangedSubview(password)
        stackView.addArrangedSubview(emailField)
        
        stackView.addArrangedSubview(phone)
        stackView.addArrangedSubview(emailerrorlabel)
        stackView.setCustomSpacing(3, after: emailerrorlabel)
        stackView.addArrangedSubview(phoneerrorlabel)
        
        
        scrollView.addSubview(submitbutton)
        scrollView.addSubview(horizontalstackView)
       // view.addSubview(submitbutton)
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginClicked(_:)))
        signuplabel2.isUserInteractionEnabled = true
        signuplabel2.addGestureRecognizer(tap)
        
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints: sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
        self.navigationItem.setHidesBackButton(false, animated: false)
        signUpPresenter.delegate = self
    }
    @objc func loginClicked(_ sender: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)

    }
   
   


    
    @objc func insertUser(_ sender: UIButton) {
        flag = true
    
        
        if(signUpPresenter.validateEmailId(emailId: emailField.text!)==false){
            flag = false


        }
        if(signUpPresenter.validateMobile(mobile: phone.text!)==false){
            flag = false
        }
        if(flag){
            
            let user: User = User(user_name: name.text!, user_phone: phone.text!, user_address: address.text!, user_email:emailField.text!, user_password: password.text!)
            let credentials = Credentials(username: emailField.text!, password: password.text!)
           try? signupInteractor.insertInKeychain(credentials: credentials)
            signupInteractor.insertUser(user: user)
            delegate?.signUpSUccessful()
        
        }
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
       // let contentLayoutGuide = scrollView.contentLayoutGuide
        
        sharedConstraints.append(contentsOf: [
            //stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        compactConstraints.append(contentsOf: [
//            signuplabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            //scrollView.heightAnchor.constraint(equalToConstant: 500),
         //   stackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
           // stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            //stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.75),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -40),
          //  submitbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.5),
//            submitbutton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 30),
          //  submitbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalstackView.topAnchor.constraint(equalTo: submitbutton.bottomAnchor,constant: 50),
            horizontalstackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            submitbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.5),
            submitbutton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 30),
            submitbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
        ])
        
        regularConstraints.append(contentsOf: [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            submitbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.5),
//            submitbutton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 30),
//            submitbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalstackView.topAnchor.constraint(equalTo: submitbutton.bottomAnchor,constant: 20),
            horizontalstackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            horizontalstackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signuplabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            submitbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.25),
            submitbutton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20),
            submitbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)

        ])
    }
}
extension SignupViewController : SignUpPresenterDelegate{
    func removeEmailError() {
        emailerrorlabel.isHidden = true
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }

    func removeMobileNumberError() {
        phoneerrorlabel.isHidden = true
        phone.layer.borderWidth = 1
        phone.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }

    func showEmailError(errorMessage: String?) {
        emailerrorlabel.text = errorMessage
        emailField.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        emailField.layer.borderWidth = 3
        emailerrorlabel.isHidden = false
    }

    func showMobileError(errorMessage: String?) {
        phoneerrorlabel.text = errorMessage
        phone.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        phone.layer.borderWidth = 3
        phoneerrorlabel.isHidden = false
    }
}
