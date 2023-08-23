//
//  LoginViewController.swift
//  UserFlow
//
//  Created by Yogesh Patel on 08/11/21.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signinButtonTapped(_ sender: UIButton){
        
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton){
        
    }
    
}

//DO Email, password - validation and empty condition
