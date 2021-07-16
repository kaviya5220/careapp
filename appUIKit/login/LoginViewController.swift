//
//  LoginViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import UIKit

class LoginViewController: UIViewController,SignUpProtocol {
  
    
    func signUpSUccessful() {
        print("Signup successful")
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        presenter.showSignupSuccessAlert()
    }
        let presenter = LoginPresenter()
        let loginInteractor = LoginInteractor()
        var userid : Int = 0
    
        let alert : UIAlertController = {
        let alert1 = UIAlertController(title: "Sign in Failed", message: "Your Email or Password is incorrect", preferredStyle: .alert)
        let okAction = UIAlertAction (title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert1.addAction(okAction)
        return alert1
        }()
        
        let signUpSuccessAlert : UIAlertController = {
        let alert1 = UIAlertController(title: "Succcess", message: "Sign Up Successful", preferredStyle: .alert)
        let okAction = UIAlertAction (title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert1.addAction(okAction)
        return alert1
        }()

        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.spacing = 20
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
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
        let loginlabel:CustomLabel = {
            let label = CustomLabel(labelType: .title)
            label.text = "LOGIN"
            label.font =  UIFont.systemFont(ofSize: 30, weight: .bold)
            label.textAlignment = .left
            label.font = UIFont(name: "TimesNewRomanPSMT", size: 35)
            return label
        }()
    let signuplabel1:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Don't have an account?"
        label.font = UIFont(name: "TimesNewRomanPSMT", size: 18)
        label.textAlignment = .center
        
        return label
    }()
    let signuplabel2:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Sign Up"
        label.textColor = .systemBlue
        label.textAlignment = .center
        
        return label
    }()
        let email:CustomLoginTextField = {
            let emailfield = CustomLoginTextField()
            emailfield.keyboardType = UIKeyboardType.emailAddress
            emailfield.autocapitalizationType = UITextAutocapitalizationType.none
            emailfield.placeholder = "Enter email"
            emailfield.leftViewMode = UITextField.ViewMode.always
            emailfield.leftViewMode = .always
            let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20) )
            var imageView = UIImageView(frame: CGRect(x: 8, y: 0, width: 30, height: 20))
            var image = UIImage(systemName: "envelope")
            imageView.image = image;
            outerView.addSubview(imageView)
            emailfield.leftView = outerView;
            return emailfield
        }()
        let password:CustomLoginTextField = {
            let password = CustomLoginTextField()
            password.isSecureTextEntry = true
            password.placeholder = "Enter password"
            password.leftViewMode = UITextField.ViewMode.always
            password.leftViewMode = .always
            let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20) )
            var imageView = UIImageView(frame: CGRect(x: 8, y: 0, width: 30, height: 20))
            var image = UIImage(systemName: "lock")
            imageView.image = image;
            outerView.addSubview(imageView)
            password.leftView = outerView;
            return password
        }()
        
        let loginbutton:CustomButton = {
            let button = CustomButton(title: "LOGIN", bgColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))
            button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
            button.layer.cornerRadius = 10
            return button
        }()
       
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
          //  self.navigationController?.navigationBar.topItem?.title = "SignUp"
            setupConstraints()
            view.addSubview(stackView)
        
            stackView.addArrangedSubview(loginlabel)
            stackView.setCustomSpacing(50, after: loginlabel)
            stackView.addArrangedSubview(email)
            stackView.addArrangedSubview(password)
            view.addSubview(loginbutton)
//            view.addSubview(signupbutton)
            view.addSubview(horizontalstackView)
            horizontalstackView.addArrangedSubview(signuplabel1)
            horizontalstackView.addArrangedSubview(signuplabel2)

            
            let tap = UITapGestureRecognizer(target: self, action: #selector(signUpClicked(_:)))
            signuplabel2.isUserInteractionEnabled = true
            signuplabel2.addGestureRecognizer(tap)
//            stackView.addArrangedSubview(loginbutton)
//            stackView.addArrangedSubview(signupbutton)
            layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                         sharedConstraints: sharedConstraints,
                                         compactConstraints: compactConstraints,
                                         regularConstraints: regularConstraints)
            
            view.backgroundColor = .white
            presenter.delegate = self
            
        }
    
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
   
    @objc func insertUser(_ sender: UIButton) {
        if sender == loginbutton{
           let isvalid = loginInteractor.Valid(email: email.text!, password: password.text!)
            if(isvalid){
                userid = loginInteractor.getuserid(email: email.text!)
                setsessionvariable(userid: userid)
                self.showToast(message: "Login Successfull", font: .systemFont(ofSize: 12.0))
                self.navigationController?.pushViewController(ReceiverViewController(), animated: true)
                
         }
            
            else{
                presenter.showAlert()
                }
            }
    }
   
    func setsessionvariable(userid : Int){
        let userDefaults =  UserDefaults.standard
            userDefaults.set(userid, forKey: "userid")
            userDefaults.synchronize()
     //   _ = UserDefaults.standard.string(forKey: "userid")
    }
    
   @objc func signUpClicked(_ sender: UITapGestureRecognizer){
        print("Clicked")
    let signUp = SignupViewController()
    let nav = UINavigationController()
    nav.viewControllers = [signUp]
    nav.modalPresentationStyle = .automatic //or .overFullScreen for transparency
    signUp.delegate = self
    self.present(nav, animated: true, completion: nil)
    
   }
    

}
extension LoginViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                     sharedConstraints:sharedConstraints,
                                     compactConstraints: compactConstraints,
                                     regularConstraints: regularConstraints)
    }
    
    private func setupConstraints() {
        
        sharedConstraints.append(contentsOf: [
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -40)
        ])
        
        compactConstraints.append(contentsOf: [
            loginbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.5),
            loginbutton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 30),
            loginbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalstackView.topAnchor.constraint(equalTo: view.bottomAnchor,constant: -50),
            horizontalstackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        regularConstraints.append(contentsOf: [
            loginbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.5),
            loginbutton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 30),
            loginbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalstackView.topAnchor.constraint(equalTo: view.bottomAnchor,constant: -50),
            horizontalstackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
}
struct Credentials {
    var email: String
    var password: String
    init(username : String, password : String) {
        self.email = username
        self.password = password
    }
}
enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}
extension LoginViewController : LoginPresenterDelegate{
    func showAlert() {
        self.present(alert, animated: true, completion: nil)
        }
    func showSignupSuccessAlert(){
        self.present(signUpSuccessAlert, animated: true, completion: nil)
    }
}

