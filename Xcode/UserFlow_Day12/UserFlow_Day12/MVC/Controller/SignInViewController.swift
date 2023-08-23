//
//  SignInViewController.swift
//  UserFlow_Day12
//
//  Created by Imam MohammadUvesh on 10/11/21.
//

import UIKit

class SignInViewController: UIViewController {

   
    @IBOutlet weak var loginImage: UIImageView!
    
    @IBOutlet weak var loginEmail: UITextField!
    
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBOutlet weak var loginSignin: UIButton!
    
    @IBOutlet weak var noaccountSignupTapped: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Hide Back Button From NavigationController
        navigationController?.isNavigationBarHidden = true
    }
    
}

extension SignInViewController
{
    
    func signInshowAlert(message: String)
    {
        let signInAlertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        signInAlertController.addAction(ok)
        self.present(signInAlertController, animated:true)
    }
    
}
extension SignInViewController{
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        guard let email = loginEmail.text, !email.isEmpty else
        {
            signInshowAlert(message: "Please Enter Email")
            return
        }
        if !isValidEmail(email)
        {
            signInshowAlert(message: "Please Enter Proper Email")
            return
        }
        guard let password = loginPassword.text, !password.isEmpty else
        {
            signInshowAlert(message: "Please Enter Your Password")
            return
        }
        if !isValidPassword(password)
        {
            signInshowAlert(message: "Please Enter Proper Password")
            return
        }
        
        print("All Validation Done Successfully")
        
        guard let email = loginEmail.text else { return }
        guard let password = loginPassword.text else { return }
        
        let users = DatabaseHelper.shareInstance.getallUsers()
        let filterUsers = users.filter
        {
            $0.email == email && $0.password == password
        }
        if filterUsers.count > 0
        {
            if let user = filterUsers.first
            {
               if let userEmail = user.email
                {
                    UserDefaults.standard.set(userEmail, forKey: "emailKey")
                    print(UserDefaults.standard.set(userEmail, forKey: "emailKey"))
                   
                   let window = (UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate).window
                   if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                   {
                       let homeNavigationController = UINavigationController(rootViewController: homeViewController)
                       window?.rootViewController = homeNavigationController
                       window?.makeKeyAndVisible()
                   }
                }
            }
        }
        else
        {
            print("User Not Found!!!")
        }
        
}

    @IBAction func noAccountSignupTapped(_ sender: UIButton) {
        if let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        {
            self.navigationController?.pushViewController(signUpViewController, animated: true)
        }
        
}
}

extension SignInViewController
{
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let emailRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: password)
    }
    //"^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(mini),}$"
    //1 number 1 alphabet total 8 character
}
