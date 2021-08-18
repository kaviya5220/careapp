//
//  sampleViewController.swift
//  appUIKit
//
//  Created by Kaviya M on 17/08/21.
//

import UIKit

class sampleViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    var donorVal : User = User()
   // let a = donorVal.user_name
 //   var tot : ItemDetails = ItemDetails()
   //let  a = tot.item_name
    var pickerData : [Int] = [Int]()
  //  var txt_pickUpData = UITextField()
    var myPickerView = UIPickerView()
    var toolBar = UIToolbar()
    func createToolBar() {
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))

//        let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(todayButtonPressed(sender:)))

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(sender:)))

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: 40))
     label.text = "Choose the year"
        let labelButton = UIBarButtonItem(customView:label)

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        toolBar.setItems([flexibleSpace,labelButton,flexibleSpace,doneButton], animated: true)

    }
//    @objc func todayButtonPressed(sender: UIBarButtonItem) {
//        let dateFormatter = DateFormatter() // 1
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//
//        txt_pickUpData.text = dateFormatter.string(from: Date()) // 2
//
//        txt_pickUpData.resignFirstResponder()
//    }
    @objc func doneButtonPressed(sender: UIBarButtonItem) {
        txt_pickUpData.resignFirstResponder()
    }
//    func createDatePicker() {
//        datePicker.preferredDatePickerStyle = .inline
//       // datePicker.
//       // datePicker.datePickerMode = .date
//        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
//    }
//    @objc func datePickerValueChanged(datePicker: UIDatePicker) {
//
//    }
    @objc func doneClick(_ sender : UIBarButtonItem) {
          txt_pickUpData.resignFirstResponder()
      }
    @objc func cancelClick(_ sender : UIBarButtonItem) {
          txt_pickUpData.resignFirstResponder()
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
//    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick(_:)))
//       let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick(_:)))
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
       // self.txt_pickUpData.text = String(pickerData[row])
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickUp(txt_pickUpData)
    }
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
            let txt_pickUpData:CustomLoginTextField = {
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
               // button.addTarget(self, action: #selector(insertUser(_:)), for: .touchUpInside)
                button.layer.cornerRadius = 10
                return button
            }()
           
            
            
            override func viewDidLoad() {
                super.viewDidLoad()
                for i in 1950 ... 2021{
                    pickerData.append(i)
                }
                
              //  self.navigationController?.navigationBar.topItem?.title = "SignUp"
                toolBar.translatesAutoresizingMaskIntoConstraints = false
                setupConstraints()
                txt_pickUpData.delegate = self
                createToolBar()
                txt_pickUpData.inputAccessoryView = toolBar
               // view.addSubview(loginbutton)
               // view.addSubview(stackView)
                view.addSubview(txt_pickUpData)
            
              //  stackView.addArrangedSubview(loginlabel)
               // stackView.setCustomSpacing(50, after: loginlabel)
               // stackView.addArrangedSubview(email)
               // stackView.addArrangedSubview(password)
               // txt_pickUpData.inputAccessoryView = toolBar
              //  textField.inputView = datePicker
                
                
                
    //            view.addSubview(signupbutton)
               // view.addSubview(horizontalstackView)
               // horizontalstackView.addArrangedSubview(signuplabel1)
                //horizontalstackView.addArrangedSubview(signuplabel2)

                
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
        self.present(nav, animated: true, completion: nil)
        
       }
        

    }
    extension sampleViewController {
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            layoutTraitConstraintsUpdate(traitCollection: self.traitCollection,
                                         sharedConstraints:sharedConstraints,
                                         compactConstraints: compactConstraints,
                                         regularConstraints: regularConstraints)
        }
        
        private func setupConstraints() {
            
            sharedConstraints.append(contentsOf: [
               // stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -40)
            ])
            
            compactConstraints.append(contentsOf: [
                
//                loginbutton.widthAnchor.constraint(equalTo: self.view.widthAnchor,multiplier: 0.5),
//               // loginbutton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 30),
//                loginbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                txt_pickUpData.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                txt_pickUpData.centerYAnchor.constraint(equalTo: view.centerYAnchor),
           //     toolBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:-8),
              //  toolBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-8),
//                datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
//                datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-8),
//                datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8),
             //   horizontalstackView.topAnchor.constraint(equalTo: view.bottomAnchor,constant: -50),
               // horizontalstackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//                stackView.topAnchor.constraint(equalTo: loginbutton.bottomAnchor,constant: 10)
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
  
    extension sampleViewController : LoginPresenterDelegate{
        func showAlert() {
            self.present(alert, animated: true, completion: nil)
            }
        func showSignupSuccessAlert(){
            self.present(signUpSuccessAlert, animated: true, completion: nil)
        }
    }


