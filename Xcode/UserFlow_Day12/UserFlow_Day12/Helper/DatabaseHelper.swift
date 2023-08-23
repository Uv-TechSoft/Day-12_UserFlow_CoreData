//
//  DatabaseHelper.swift
//  UserFlow_Day12
//
//  Created by Imam MohammadUvesh on 13/11/21.
//

import Foundation
import CoreData
import UIKit

// SingleTonClass CRUD Operation

class DatabaseHelper
{
     static let shareInstance = DatabaseHelper()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: UserModel is Structure name or a Model Class Name
    func saveUser(userModel: UserModel)
    {
        if let context = context
        {
            let user = User(context: context)
            user.firstname = userModel.firstname
            user.lastname = userModel.lastname
            user.email = userModel.email
            user.password = userModel.password
            user.profileImageName = userModel.profileImageName
            
            saveContext()
        }
    }
    
    // Set<String>
    func getallUsers() -> [User]
    {
        var userArray = [User]()
        //MARK: entityName is Coredate's Entity Name
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            userArray = try context?.fetch(fetchRequest) as? [User] ?? []
        } catch {
            print(error.localizedDescription)
        }
        return userArray
    }
    
    func updateUser(currentUser: User, userModel: UserModel)
    {
        currentUser.firstname = userModel.firstname
        currentUser.lastname = userModel.lastname
        currentUser.email = userModel.email
        currentUser.password = userModel.password
        currentUser.profileImageName = userModel.profileImageName
        
        saveContext()
        
    }
    
    func deleteUser(user: User)
    {
        context?.delete(user)
        saveContext()
    }
    
    func saveContext()
    {
        if let context = context
        {
            do {
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
