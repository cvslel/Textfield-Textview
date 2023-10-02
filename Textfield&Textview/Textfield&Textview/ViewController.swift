//
//  ViewController.swift
//  Textfield&Textview
//
//  Created by Cenker Soyak on 2.10.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let nameSurnameTextfield = UITextField()
    let emailTextfield = UITextField()
    let phoneTextfield = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createUI()
        
        nameSurnameTextfield.delegate = self
        emailTextfield.delegate = self
        phoneTextfield.delegate = self
        
        }

    func createUI(){
        
        nameSurnameTextfield.placeholder = "Enter your name & surname: "
        nameSurnameTextfield.textColor = .red
        nameSurnameTextfield.font = UIFont.boldSystemFont(ofSize: 15)
        nameSurnameTextfield.borderStyle = .roundedRect
        nameSurnameTextfield.layer.borderColor = UIColor.black.cgColor
        view.addSubview(nameSurnameTextfield)
        nameSurnameTextfield.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
        }
        
        emailTextfield.placeholder = "Enter your mail address: "
        emailTextfield.textColor = .blue
        emailTextfield.font = UIFont.italicSystemFont(ofSize: 15)
        emailTextfield.borderStyle = .roundedRect
        emailTextfield.layer.borderColor = UIColor.black.cgColor
        view.addSubview(emailTextfield)
        emailTextfield.snp.makeConstraints { make in
            make.top.equalTo(nameSurnameTextfield.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
        }
        
        //The third text field was to be created for the user's phone number and given a placeholder of "Enter Phone Number". The text color was to be green and the font to be underline.
        
        phoneTextfield.placeholder = "Enter your phone number: "
        phoneTextfield.textColor = .green
        phoneTextfield.borderStyle = .roundedRect
        phoneTextfield.layer.borderColor = UIColor.black.cgColor
        view.addSubview(phoneTextfield)
        phoneTextfield.snp.makeConstraints { make in
            make.top.equalTo(emailTextfield.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameSurnameTextfield {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let newText = currentText.replacingCharacters(in: stringRange, with: string)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: phoneTextfield.text!, attributes: underlineAttribute)
        phoneTextfield.attributedText = underlineAttributedString
        return textField == phoneTextfield ? newText.count <= 10 : true
      }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextfield {
          if let text = textField.text {
            var isValid = validateEmail(enteredEmail: text)
            if isValid {
              let alert = UIAlertController(title: "Success", message: "The Email is Correct Format", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default))
              present(alert, animated: true)
            } else {
              let alert = UIAlertController(title: "Fail", message: "The Email is not in Correct Format", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default))
              present(alert, animated: true)
            }
          }
        }
      }
    
    func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
      }
}
