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
            stack.distribution = .fillProportionally
            stack.spacing = 10
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        let createlabel:UILabel = {
            let label = CustomLabel(labelType: .primary)
            label.text = "Create a new account"
            label.font = UIFont.italicSystemFont(ofSize: 20)
            return label
        }()
        let loginlabel:UILabel = {
            let label = CustomLabel(labelType: .title)
            label.text = "LOGIN"
            return label
        }()
        let email:UITextField = {
            let emailfield = CustomTextField()
            emailfield.placeholder = "Enter email"
            return emailfield
        }()
        let password:UITextField = {
            let password = CustomTextField()
            password.placeholder = "Enter password"
            return password
        }()
        
        let loginbutton:UIButton = {
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
            self.title = "Login"
            view.backgroundColor = .white
            view.addSubview(loginlabel)
            view.addSubview(stackView)
            stackView.addArrangedSubview(email)
            stackView.setCustomSpacing(20, after: email)
            stackView.addArrangedSubview(password)
            stackView.setCustomSpacing(20, after: password)
            view.addSubview(loginbutton)
            view.addSubview(createlabel)
            view.addSubview(signupbutton)
            
            loginlabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 30).isActive = true
            loginlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            
            stackView.topAnchor.constraint(equalTo: self.loginlabel.bottomAnchor,constant: 45).isActive = true
            stackView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant:10).isActive = true
            stackView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor, constant:-10).isActive = true
            
            loginbutton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor,constant: 25).isActive = true
            loginbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            
            createlabel.topAnchor.constraint(equalTo: self.loginbutton.bottomAnchor,constant: 30).isActive = true
            createlabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            
            signupbutton.topAnchor.constraint(equalTo: self.createlabel.bottomAnchor,constant: 15).isActive = true
            signupbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            
            navigationItem.title = .none
            
            presenter.delegate = self
            
        }
        
        @objc func insertUser(_ sender: UIButton) {
            if sender == loginbutton{
               let isvalid = loginInteractor.Valid(email: email.text!, password: password.text!)
                if(isvalid){
                    userid = db.getuserid(email: email.text!)
                    setsessionvariable(userid: userid)
                    self.showToast(message: "Login Successfull", font: .systemFont(ofSize: 12.0))
                    self.navigationController?.pushViewController(TabViewController(), animated: true)
                }
                else{
                    presenter.showAlert()
                    }
                }
            if sender == signupbutton{
                let vc = SignupViewController()
                vc.modalPresentationStyle = .automatic //or .overFullScreen for transparency
                self.present(vc, animated: true, completion: nil)
            }

    }
    func setsessionvariable(userid : Int){
        let userDefaults =  UserDefaults.standard
            userDefaults.set(userid, forKey: "userid")
            userDefaults.synchronize()
    }

}
extension LoginViewController : LoginPresenterDelegate{
    func showAlert() {
        print("Hiii")
        self.present(alert, animated: true, completion: nil)
    }
}
