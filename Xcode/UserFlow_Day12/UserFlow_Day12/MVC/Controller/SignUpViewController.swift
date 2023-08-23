//
//  SignUpViewController.swift
//  UserFlow_Day12
//
//  Created by Imam MohammadUvesh on 10/11/21.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signupAccount: UIButton!
    @IBOutlet weak var alreadyUserSignin: UIButton!
   
    //MARK: LifeCycle Methods
  override func viewDidLoad() {
        super.viewDidLoad()
      configuration()
  }
}

//MARK: Helper Actions
extension SignUpViewController
{
    func configuration()
    {
        let contactImageTapped = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        contactImage.isUserInteractionEnabled = true
        contactImage.addGestureRecognizer(contactImageTapped)
        
        uiconfiguration()
    }
    func uiconfiguration()
    {
        contactImage.layer.cornerRadius = contactImage.frame.height/2
    }
    @objc
    func profileImageTapped()
    {
     let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true)
    }
    func showAlert(message: String)
    {
        let alertController = UIAlertController(title: "Alert", message:message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true)
    }
    func clearField()
    {
        firstName.text = nil
        lastName.text = nil
        emailID.text = nil
        password.text = nil
        contactImage.image = UIImage(systemName: "person.fill")
    }
}

extension SignUpViewController
{
    //MARK: Button Tap Actions
        @IBAction func signUpTap(_ sender: UIButton) {
            
            let tempImage = UIImage(systemName: "person.fill")

            guard let firstname = firstName.text, !firstname.isEmpty else
            {
                showAlert(message: "Please Enter Your Firstname")
                return
            }
            guard let lastname = lastName.text, !lastname.isEmpty else
            {
                showAlert(message: "Please Enter Your Lastname")
                return
            }
            guard let email = emailID.text, !email.isEmpty else
            {
                showAlert(message: "Please Enter Your Email")
                return
            }
            if !isValidEmail(email)
            {
                showAlert(message: "Please Enter Your Valid Email Address")
                return
            }
            guard let password = password.text, !password.isEmpty else
            {
                showAlert(message: "Please Enter Your Password")
                return
            }
            if !isValidPassword(password)
            {
                showAlert(message: "Please Enter Proper Password")
                return
            }
            if contactImage.image?.pngData() == tempImage?.pngData()
            {
                showAlert(message: "Please Check Profile Image")
                return
            }
            
            let filesname = UUID().uuidString
            profileImageSaved(filesName: filesname)
            
            let user = UserModel(firstname: firstname, lastname: lastname, email: email, password: password, profileImageName:filesname)
            DatabaseHelper.shareInstance.saveUser(userModel: user)
            
//            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
//            {
//                let register = User(context:context)
//                register.firstname = firstname
//                register.lastname = lastname
//                register.email = email
//                register.password = password
//                register.profileImageName = filesname
//
//        do {
//            try context.save()
//            }
//                catch let error {
//                    print(error.localizedDescription)
//                }
//            }
            showAlert(message: "Sign Up Sucessfully")
            clearField()
            print("All Validation Done Sucessfully")
            
        }
    
    func profileImageSaved(filesName: String)
    {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        print(documentURL) // MARK: Document URL
        
        let fileURL = documentURL?.appendingPathComponent(filesName)
            .appendingPathExtension("png")
            print(fileURL) // MARK: Final File URL (Name and Extension)
        
        if let imageData = contactImage.image?.pngData(), let url = fileURL
        {
            do {
                try imageData.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
        
        @IBAction func alreadyUserSignInTap(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
            
        }
}
// MARK: UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true)
        guard let selectedImage = info[.originalImage] as? UIImage else
        {
            return
        }
        contactImage.image = selectedImage
    }
}
extension SignUpViewController
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
///https://stackoverflow.com/questions/29666956/validation-of-email-in-swift-ios-application/53441176
///https://stackoverflow.com/questions/39284607/how-to-implement-a-regex-for-password-validation-in-swift
