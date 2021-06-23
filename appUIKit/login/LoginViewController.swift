//
//  LoginViewController.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import UIKit


class LoginViewController: UIViewController {

        var db = DBHelper()
        let loginInteractor = LoginInteractor()
        var userid : Int = 0
        let alert : UIAlertController = {
            let alert1 = UIAlertController(title: "Sign in Failed", message: "Your Email or Password is incorrect", preferredStyle: .alert)
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
        let loginlabel:CustomLabel = {
            let label = CustomLabel(labelType: .title)
            label.text = "LOGIN"
            label.textAlignment = .center
            return label
        }()
        let email:CustomTextField = {
            let emailfield = CustomTextField()
            emailfield.keyboardType = UIKeyboardType.emailAddress
            emailfield.placeholder = "Enter email"
            return emailfield
        }()
        let password:CustomTextField = {
            let password = CustomTextField()
            password.isSecureTextEntry = true
            password.placeholder = "Enter password"
            return password
        }()
        
        let loginbutton:CustomButton = {
            let button = CustomButton(title: "LOGIN", bgColor: .systemBlue)
            button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
            return button
        }()
        let signupbutton:UIButton = {
            let button = CustomButton(title: "SIGNUP", bgColor: .systemGreen)
            button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
            return button
        }()
        
        let presenter = LoginPresenter()
        override func viewDidLoad() {
            super.viewDidLoad()
            setupConstraints()
            view.addSubview(stackView)
            stackView.addArrangedSubview(loginlabel)
            stackView.addArrangedSubview(email)
            stackView.addArrangedSubview(password)
            stackView.addArrangedSubview(loginbutton)
            stackView.addArrangedSubview(signupbutton)
            layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                         sharedConstraints: sharedConstraints,
                                         compactConstraints: compactConstraints,
                                         regularConstraints: regularConstraints)
            
            self.title = "Login"
            view.backgroundColor = .white
            navigationItem.title = .none
            presenter.delegate = self
            
        }
    
    private var sharedConstraints = [NSLayoutConstraint]()
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
   
    @objc func insertUser(_ sender: UIButton) {
        if sender == loginbutton{
           let isvalid = loginInteractor.Valid(email: email.text!, password: password.text!)
            if(isvalid){
                userid = DBHelper.getuserid(email: email.text!)
                setsessionvariable(userid: userid)
                self.showToast(message: "Login Successfull", font: .systemFont(ofSize: 12.0))
                let newVc = TabViewController()
                var vcArray = self.navigationController?.viewControllers
                vcArray!.removeLast()
                vcArray!.append(newVc)
                self.navigationController?.setViewControllers(vcArray!, animated: false)
            }
            else{
                presenter.showAlert()
                }
            }
        if sender == signupbutton{
            self.navigationController?.pushViewController(SignupViewController(), animated: true)
        }

    }
    func setsessionvariable(userid : Int){
        let userDefaults =  UserDefaults.standard
            userDefaults.set(userid, forKey: "userid")
            userDefaults.synchronize()
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
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        compactConstraints.append(contentsOf: [
            loginbutton.widthAnchor.constraint(equalTo: self.stackView.widthAnchor),
           // loginbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        regularConstraints.append(contentsOf: [
            loginlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
extension LoginViewController : LoginPresenterDelegate{
    func showAlert() {
        self.present(alert, animated: true, completion: nil)
        }
}

