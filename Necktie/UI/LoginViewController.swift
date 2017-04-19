//
//  LoginViewController.swift
//  Necktie
//
//  Created by Ondra Kandera on 6/10/16.
//  Copyright © 2016 Necktie. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireObjectMapper
import IHKeyboardAvoiding
import KeychainAccess
import SwiftyUserDefaults

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    var activityIndicator: UIActivityIndicatorView! = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    // MARK: - IBOutlets
    
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
        
        // Prefill username
        if Defaults[.username].characters.count > 0 {
            loginTextField.text = Defaults[.username]
            loginLabel.frame.origin.y += 16
            loginLabel.alpha = 1.0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // Set keyboard to avoid containerView
        KeyboardAvoiding.avoidingView = loginButton
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
            login()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let characterCount = textField.text?.characters.count
        
        // Animates placeholder label
        if (textField === self.loginTextField && characterCount == 0) {
            loginLabel.frame.origin.y += 16
            UIView.animate(withDuration: 0.5, animations: {
                self.loginLabel.alpha = 1.0
                self.loginLabel.frame.origin.y -= 16
            })
        } else if (textField === passwordTextField && characterCount == 0) {
            passwordLabel.frame.origin.y += 16
            UIView.animate(withDuration: 0.5, animations: {
                self.passwordLabel.frame.origin.y -= 16
                self.passwordLabel.alpha = 1.0
            })
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let characterCount = textField.text?.characters.count
        
        if (textField === self.loginTextField && characterCount == 0) {
            UIView.animate(withDuration: 0.5, animations: {
                self.loginLabel.alpha = 0
            })
        } else if (textField === passwordTextField && characterCount == 0) {
            UIView.animate(withDuration: 0.5, animations: {
                self.passwordLabel.alpha = 0
            })
        }
    }
    
    // MARK: - IBActions
    
    // Checks if fields changed for login button animation
    @IBAction func textFieldChanged(_ sender: AnyObject) {
        if (loginTextField.text?.characters.count)! > 1 && (passwordTextField.text?.characters.count)! > 1 {
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
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        login()
    }
    
    @IBAction func facebookLogin(_ sender: AnyObject) {
        
    }
    
    // MARK: - Login
    
    func login() {
        let parameters: Parameters = ["client_id": Constant.clientId,
                                      "client_secret": Constant.clientSecret,
                                      "grant_type": "password",
                                      "username": loginTextField.text!,
                                      "password": passwordTextField.text!]
        
        let headers: HTTPHeaders = [:]
        
        show(activityIndicatorView: activityIndicator, on: loginButton)
        
        Alamofire.request(API.baseURL + API.OAuthPath, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let valueDictionary = value as! NSDictionary
                    let accessToken = valueDictionary.value(forKey: "access_token")
                    let refreshToken = valueDictionary.value(forKey: "refresh_token")
                    
                    let keychain = Keychain(service: Constant.App.bundleId)
                    keychain["access_token"] = accessToken as! String?
                    keychain["refresh_token"] = refreshToken as! String?
                    
                    Defaults[.username] = self.loginTextField.text!
                    Defaults[.isLoggedIn] = true
                    
                    self.getUser()
                    self.getSettings()
                    
                    self.dismiss(animated: true) {
                        self.dismiss(activityIndicatorView: self.activityIndicator, on: self.loginButton)
                    }
                case .failure(let error):
                    self.dismiss(activityIndicatorView: self.activityIndicator, on: self.loginButton)
                    
                    let alert = UIAlertController(title: String.Alert.error, message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: String.Alert.ok, style: .cancel, handler: nil)
                    let retryAction = UIAlertAction(title: String.Alert.retry, style: .default) { action in
                        log.info("Retry request")
                        
                        self.login()
                    }
                    alert.addAction(okAction)
                    alert.addAction(retryAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    log.error("Request Error: \(error)")
                }
        }
    }
    
    // MARK: - Get user
    
    func getUser() {
        APIManager.sharedManager.request(Router.profile)
            .validate()
            .responseObject(keyPath: "user") { (response: DataResponse<User>) in
                switch response.result {
                case .success(let user):
                    log.verbose("Current user: \(user.username!)")
                    
                    self.saveCurrentUser(user)
                case .failure(let error):
                    log.error("Error: \(error)")
                }
            }
    }
    
    // MARK: - Get settings
    
    func getSettings() {
        APIManager.sharedManager.request(Router.settings)
            .validate()
            .responseObject { (response: DataResponse<Settings>) in
                switch response.result {
                case .success(let settings):
                    log.info("Settings downloaded")
                    if let currency = settings.currency {
                        Defaults[.currency] = currency
                    }
                    if let itemsOnPage = settings.itemsOnPage {
                        Defaults[.itemsOnPage] = itemsOnPage
                    }
                case .failure(let error):
                    log.error("Error: \(error)")
                }
        }
    }

    // MARK: - Save current user
    
    func saveCurrentUser(_ user: User) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.setValue(encodedData, forKey: "currentUser")
        
        log.info("Saved current user to NSUserDefaults")
    }

}
