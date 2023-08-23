//
//  HomeViewController.swift
//  UserFlow_Day12
//
//  Created by Imam MohammadUvesh on 17/11/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    
    }

}
extension HomeViewController
{
    func config()
    {
        addButtons()
        navigationController?.isNavigationBarHidden = false
    }
    
    func addButtons()
    {
        let logout = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        navigationItem.rightBarButtonItem = logout
        
        let profile = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .plain, target: self, action: #selector(profileButtonTapped))
        
        let userList = UIBarButtonItem(title: "UserList", style: .plain, target: self, action: #selector(userListTapped))
        navigationItem.leftBarButtonItems = [profile, userList]
    }
    @objc func userListTapped()
    {
        if let userListViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserlistViewController") as? UserlistViewController
        {
            self.navigationController?.pushViewController(userListViewController, animated: true)
        }
        
    }
    
    @objc func logoutTapped()
    {
        UserDefaults.standard.removeObject(forKey: "emailKey")
        print(UserDefaults.standard.removeObject(forKey: "emailKey"))
        
        let window = (UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate).window
        if let singInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
        {
            let signInNavigationController = UINavigationController(rootViewController: singInViewController)
            window?.rootViewController = signInNavigationController
            window?.makeKeyAndVisible()
        }
        
    }
   
    @objc func profileButtonTapped()
    {
        if let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        {
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }
    }
    
}
