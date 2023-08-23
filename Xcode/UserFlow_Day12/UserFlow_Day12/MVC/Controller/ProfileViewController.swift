//
//  ProfileViewController.swift
//  UserFlow_Day12
//
//  Created by Imam MohammadUvesh on 18/11/21.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var updateAccount: UIButton!
    
    var currentUser: User?
    
    //MARK: LifeCycle Methods
  override func viewDidLoad() {
        super.viewDidLoad()
      navigationController?.isNavigationBarHidden = false
      configuration()
  }
}

//MARK: Helper Actions
extension ProfileViewController
{
    func configuration()
    {
        let contactImageTapped = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        contactImage.isUserInteractionEnabled = true
        contactImage.addGestureRecognizer(contactImageTapped)
        
        uiconfiguration()
        getUserDetails()
    }
    func uiconfiguration()
    {
        contactImage.layer.cornerRadius = contactImage.frame.height/2
    }
    func getUserDetails()
    {
        if let email = UserDefaults.standard.string(forKey: "emailKey")
        {
            let filterUser = DatabaseHelper.shareInstance.getallUsers().filter
            {
                $0.email == email
            }.first
            if let currentUser = filterUser
            {
                self.currentUser = currentUser
                firstName.text = currentUser.firstname
                lastName.text = currentUser.lastname
                emailID.text = currentUser.email
                password.text = currentUser.password
                
                let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                let fileURL = documentURL?.appendingPathComponent(currentUser.profileImageName ?? "").appendingPathExtension("png")
                
                contactImage.image = UIImage(contentsOfFile: fileURL?.path ?? "")
                
            }
        }
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
}

extension ProfileViewController
{
    //MARK: Button Tap Actions
        @IBAction func updateTap(_ sender: UIButton) {
            
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
            if let currentUser = currentUser
            {
                let userModel = UserModel(firstname: firstname, lastname: lastname, email: email, password: password, profileImageName: currentUser.profileImageName ?? "")
                profileImageSaved(filesName: currentUser.profileImageName ?? "")
                UserDefaults.standard.set(email, forKey: "emailKey")
                DatabaseHelper.shareInstance.updateUser(currentUser: currentUser, userModel: userModel)
            }
            
            print("User Update Sucessfully")
            
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
extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
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
extension ProfileViewController
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
