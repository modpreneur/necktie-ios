//
//  LoginViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 6/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import IHKeyboardAvoiding
import SwiftyUserDefaults

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    @IBOutlet var backgroundView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var facebookButton: UIButton!

    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegates
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        // Reset button
        loginButton.backgroundColor = UIColor.lightGray
        loginButton.isEnabled = false
        
        // Set default alpha for labels
        loginLabel.alpha = 0
        passwordLabel.alpha = 0
        
        // Set corner radius
        loginTextField.layer.cornerRadius = 3
        passwordTextField.layer.cornerRadius = 3
        facebookButton.layer.cornerRadius = 3
        
        // Style login button
        loginButton.backgroundColor = UIColor.clear
        loginButton.layer.cornerRadius = 3
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.2).cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Set keyboard to avoid containerView
        IHKeyboardAvoiding.setAvoiding(loginButton)
        //IHKeyboardAvoiding.setPaddingForCurrentAvoidingView(-118)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Dismiss keyboard when tapping outside text fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField === self.loginTextField) {
            passwordTextField.becomeFirstResponder()
        } else if (textField === passwordTextField) {
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField === self.loginTextField) {
            UIView.animate(withDuration: 0.5, animations: {
                self.loginLabel.alpha = 1.0
            })
        } else if (textField === passwordTextField) {
            UIView.animate(withDuration: 0.5, animations: {
                self.passwordLabel.alpha = 1.0
            })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField === self.loginTextField && (textField.text?.characters.count)! == 0) {
            UIView.animate(withDuration: 0.5, animations: {
                self.loginLabel.alpha = 0
            })
        } else if (textField === passwordTextField && (textField.text?.characters.count)! == 0) {
            UIView.animate(withDuration: 0.5, animations: {
                self.passwordLabel.alpha = 0
            })
        }
    }
    
    // MARK: - IBActions
    
    // Checks if fields changed for login button animation
    @IBAction func textFieldChanged(_ sender: AnyObject) {
        if (loginTextField.text?.characters.count)! > 3 && (passwordTextField.text?.characters.count)! > 3 {
            UIView.animate(withDuration: 0.5, animations: {
                self.loginButton.isEnabled = true
                self.loginButton.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.3)
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.loginButton.isEnabled = false
                self.loginButton.backgroundColor = UIColor.clear
            })
        }
    }
    
    @IBAction func login(_ sender: AnyObject) {
        Defaults[.isLoggedIn] = true
        dismiss(animated: true) { 
            
        }
    }
    
    @IBAction func facebookLogin(_ sender: AnyObject) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
