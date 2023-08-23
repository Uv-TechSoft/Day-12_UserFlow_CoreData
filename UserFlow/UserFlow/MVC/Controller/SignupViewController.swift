//
//  SignupViewController.swift
//  UserFlow
//
//  Created by Yogesh Patel on 08/11/21.
//

import UIKit

class SignupViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
        

}

// MARK: - Helper Method
extension SignupViewController{
    
    func configuration(){
        let profileImageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        //profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(profileImageViewTapGesture)
        
        uiConfiguration()
    }
    
    func uiConfiguration(){
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    }
    
    @objc
    func profileImageTapped(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    func showAlert(message: String){
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(ok)
        
        self.present(alertController, animated: true)
    }
}

// MARK: - Actions
extension SignupViewController{
    
    @IBAction func signinButtonTapped(_ sender: UIButton){
        
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton){
        guard let firstname = firstnameField.text, !firstname.isEmpty else {
            showAlert(message: "please enter your firstname")
            return
        }
        guard let lastname = lastnameField.text, !lastname.isEmpty else {
            showAlert(message: "please enter your lastname")
            return
        }
        guard let emailname = emailField.text, !emailname.isEmpty else {
            showAlert(message: "please enter your email address")
            return
        }
        guard let passwordname = passwordField.text, !passwordname.isEmpty else {
            showAlert(message: "please enter your password")
            return
        }
        
        //Navigation | Operation Code
        print("All validation done")
    }
    
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension SignupViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let selectedImage = info[.originalImage] as? UIImage else{
            return
        }
        profileImageView.image = selectedImage
    }
}
