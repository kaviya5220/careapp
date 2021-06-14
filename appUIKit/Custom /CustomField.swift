//
//  CustomField.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import UIKit

class CustomField: UIView {
    let textField: CustomTextField = {
        let textField = CustomTextField()
        return textField
    }()
    
    let errorLabel: CustomLabel = {
        let label = CustomLabel(labelType: .secondary)
        label.textColor = .red
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        addConstraints()
        errorLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(errorLabel)
        self.addSubview(stackView)
    }
    
    private func addConstraints() {
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
       // textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
   
    
}
extension CustomField{
    func getFiledText()-> String? {
        return textField.text
    }
    func setError(errorMessage:String) {
        errorLabel.text = errorMessage
        errorLabel.isHidden = false
    }
    func removeError() {
        errorLabel.isHidden = true
    }
}
