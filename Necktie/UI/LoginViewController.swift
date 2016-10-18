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

    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegates
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        // Reset button
        loginButton.backgroundColor = UIColor.lightGray
        loginButton.isEnabled = false
        
        // Add motion effect to background and login container views
        applyMotionEffect(toView: backgroundView, magnitude: 10)
        applyMotionEffect(toView: containerView, magnitude: -20)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Set keyboard to avoid containerView
        IHKeyboardAvoiding.setAvoiding(containerView)
        IHKeyboardAvoiding.setPaddingForCurrentAvoidingView(-64)
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
    
    // MARK: - IBActions
    
    // Checks if fields changed for login button animation
    @IBAction func textFieldChanged(_ sender: AnyObject) {
        if (loginTextField.text?.characters.count)! > 3 && (passwordTextField.text?.characters.count)! > 3 {
            UIView.animate(withDuration: 0.3, animations: {
                self.loginButton.isEnabled = true
                self.loginButton.backgroundColor = UIColor().necktieBlue
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.loginButton.isEnabled = false
                self.loginButton.backgroundColor = UIColor.lightGray
            })
        }
    }
    
    @IBAction func login(_ sender: AnyObject) {
        Defaults[.isLoggedIn] = true
        dismiss(animated: true) { 
            
        }
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
