//
//  ViewController.swift
//  HWL11
//
//  Created by Даниил Евгеньевич on 15.05.2024.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var signUpLabel: UILabel!
    @IBOutlet var fullNameTextField: TextFieldWithIcon!
    @IBOutlet var emailTextField: TextFieldWithIcon!
    @IBOutlet var passwordTextField: TextFieldWithIcon!
    @IBOutlet var passwordConfirmationTextField: TextFieldWithIcon!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var agreementCheckBox: CheckBox!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //создали строку с измененным цветом всего текста
        var signUpLabelText = AttributedString(
            "Sign Up",
            attributes: AttributeContainer()
                .foregroundColor(.primaryLabel))
        //перекрасили только Up
        if let upRange = signUpLabelText.range(of: "Up") {
            signUpLabelText[upRange].uiKit.foregroundColor = .greenHighlight
        }
        
        signUpLabel.attributedText = NSAttributedString(signUpLabelText)
        
        var logInLabelText = AttributedString(
            "Have an account? Log In",
            attributes: AttributeContainer()
                .foregroundColor(.primaryLabel))
        if let logInRange = logInLabelText.range(of: "Log In") {
            logInLabelText[logInRange].uiKit.foregroundColor = .greenHighlight
        }
        
        loginLabel.attributedText = NSAttributedString(logInLabelText)
        
        /*
         let tapGestureRecognizer = UITapGestureRecognizer()
         //одним пальцем
         tapGestureRecognizer.numberOfTouchesRequired = 1
         //одним нажатием
         tapGestureRecognizer.numberOfTapsRequired = 1
         tapGestureRecognizer.addTarget(self, action: #selector(tapGestureAction(_:)))
         addGestureRecognizer(tapGestureRecognizer)
         */
        let tapLogInGestureRecorganizer = UITapGestureRecognizer()
        tapLogInGestureRecorganizer.numberOfTouchesRequired = 1
        tapLogInGestureRecorganizer.numberOfTapsRequired = 1
        tapLogInGestureRecorganizer.addTarget(self, action: #selector(tapLogInGestureAction(_:)))
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(tapLogInGestureRecorganizer)
        
        
        
        fullNameTextField.iconImage = UIImage(resource: .loginTextField)
        fullNameTextField.placeholder = "Full name"
        emailTextField.iconImage = UIImage(resource: .emailTextField)
        emailTextField.placeholder = "Email or Phone"
        passwordTextField.iconImage = UIImage(resource: .passwordTextField)
        passwordTextField.placeholder = "Password"
        passwordConfirmationTextField.iconImage = UIImage(resource: .passwordTextField)
        passwordConfirmationTextField.placeholder = "Confirm password"
        
        //square
        //checkmark.square
        
        agreementCheckBox.text = "Agree with terms and conditions."
        
    }
    
    @IBAction func signUpButtpnTapped(_ sender: UIButton) {
        
    }
    
    @objc private func tapLogInGestureAction(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else {
            print("Error taped")
            return
        }
        print("taped Log In")
        guard let logInVC = self.storyboard?.instantiateViewController(withIdentifier: "LogInVC") as?  LogInVC else {return}
        //передать значение на второе View
        
        self.present(logInVC, animated: true)
        
    }
    
    @IBAction func checkBoxValueChanged(_ sender: Any) {
        print("Tapped")
    }
    
    
}

/*
 +Сделать "Have an account? Log In" двухцветным
 +Сделать обработку тапа по этому лейблу через Tap Gesture Recognizer
 +Добавить переход на другой экран по этому тапу (опция sugue или кодом)
 +Написать класс для чекбокса с лейблом по дизайну
 +К чекбоксу добавить обработку нажатия и смену картинки с заполненной галочкой/квадратиком или без
 +Сохранять текущее состояние в bool свойство
 +Добавить обработку смены состояния чекбокса на view controller
 +*Добавить обработку смены состояния через ивент value changed
 +*Добавить @IBDesignable к чекбоксу с возможностью задания состояния чекбокса на сториборде
 
 
 */

