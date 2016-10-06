//
//  LoginViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 6/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set delegates
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        // Reset button
        loginButton.backgroundColor = UIColor.lightGray
        loginButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField === self.loginTextField) {
            passwordTextField.becomeFirstResponder()
        } else if (textField === passwordTextField) {
            passwordTextField.resignFirstResponder()
            print("Done")
        }
        
        return true
    }
    
    // MARK: - IBActions
    
    // Checks if fields changed for login button animation
    @IBAction func textFieldChanged(_ sender: AnyObject) {
        if (loginTextField.text?.characters.count)! > 3 && (passwordTextField.text?.characters.count)! > 3 {
            UIView.animate(withDuration: 0.3, animations: {
                self.loginButton.isEnabled = true
                self.loginButton.backgroundColor = Color.necktieBlue
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.loginButton.isEnabled = false
                self.loginButton.backgroundColor = UIColor.lightGray
            })
        }
    }
    
    @IBAction func login(_ sender: AnyObject) {
        
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
