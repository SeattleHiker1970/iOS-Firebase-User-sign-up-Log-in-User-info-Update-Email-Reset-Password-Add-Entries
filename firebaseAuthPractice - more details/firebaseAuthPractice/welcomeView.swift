//
//  welcomeView.swift
//  firebaseAuthPractice
//
//  Created by Nasser Jeary on 2019-06-09.
//  Copyright © 2019 Nasser Jeary. All rights reserved.
//

import UIKit
import Firebase


class welcomeView: UIViewController {

    @IBOutlet weak var emailOutlet: UILabel!
    
    @IBOutlet weak var idOutlet: UILabel!
    
    @IBOutlet weak var statusOutlet: UILabel!
    
    
  
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        
        
    }
    


    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser != nil {
            // User is signed in.
            let user = Auth.auth().currentUser
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                  print(photoURL)
                emailOutlet.text = email!
                idOutlet.text = uid
            }
          
        } else {
            // No user is signed in.
           print("Please sign in")
        }
    }// end of viewWillAppear
    
    
    
    
 
    
    
    
    
    
    
    
    @IBAction func updateEmailBtn(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "update Email", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Current Email"
            textField.keyboardType = .emailAddress
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Current Password"
            textField.isSecureTextEntry = true
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New Email"
            textField.keyboardType = .emailAddress
        }
       
        
        let updateEmail = UIAlertAction(title: "Update", style: .default) { (_) in
            let emailField = alertController.textFields![0]
            let passwordField = alertController.textFields![1]
            let newEmail = alertController.textFields![2]
          
            
            
    /*-------------------------------------*/
     let user = Auth.auth().currentUser
    var credential: AuthCredential = EmailAuthProvider.credential(withEmail: emailField.text!, password: passwordField.text!)


            // Prompt the user to re-provide their sign-in credentials
            
            user?.reauthenticate(with: credential) { error in
                if let error = error {
        
                        print(error)
                    self.statusOutlet.text = "error"
                    
                } else {
                    // User re-authenticated.
                    self.statusOutlet.text = "You have been reauthenticated"
                    /*---------------------------*/
                     Auth.auth().currentUser?.updateEmail(to: newEmail.text!) { (error) in
                    
                        if(error != nil){
                            print(error)
                        }else{
                            print("email has been updated")
                            self.statusOutlet.text = "email has been updated"
                        }
                                }
                    /*---------------------------*/
                }
            }
// Auth.auth().currentUser?.updateEmail(to: emailField.text!) { (error) in
//
//    if(error != nil){
//        print(error)
//    }else{
//        print("email has been updated")
//        statusOutlet.text = "email has been updated"
//    }
//
//            }
       /*-----------------------------*/
        }
        
     
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(updateEmail)
        alertController.addAction(cancelAction)
        
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func updatePWBtn(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: "update Email", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Current Email"
            textField.keyboardType = .emailAddress
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Current Password"
            textField.isSecureTextEntry = true
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New Password"
            textField.isSecureTextEntry = true
        }
        
        
        let updatePW = UIAlertAction(title: "Update", style: .default) { (_) in
            let emailField = alertController.textFields![0]
            let currentPW = alertController.textFields![1]
            let newPW = alertController.textFields![2]
            
            
            /*----------------------------------------------*/
            
            let user = Auth.auth().currentUser
            var credential: AuthCredential = EmailAuthProvider.credential(withEmail: emailField.text!, password: currentPW.text!)

            
            // Prompt the user to re-provide their sign-in credentials
            
            user?.reauthenticate(with: credential) { error in
                if let error = error {
                    // An error happened.
                    self.statusOutlet.text = error.localizedDescription
                } else {
                                Auth.auth().currentUser?.updatePassword(to: newPW.text!) { (error) in
                                    if(error != nil){
                                        print(error)
                                        self.statusOutlet.text = error?.localizedDescription
                                    }else{
                                      self.statusOutlet.text = "Password has been updated"
                                    }
                                }
                }
            }
            
            
//            Auth.auth().currentUser?.updatePassword(to: newPW.text!) { (error) in
//                if(error != nil){
//                    print(error)
//                    self.statusOutlet.text = error?.localizedDescription
//                }else{
//                  self.statusOutlet.text = "Password has been updated"
//                }
//            }
            /*----------------------------------------------*/
        }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(updatePW)
            alertController.addAction(cancelAction)
            
            
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func deleteAccountBtn(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: "update Email", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Current Email"
            textField.keyboardType = .emailAddress
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Current Password"
            textField.isSecureTextEntry = true
        }
        
      
        
        let deleteAccount = UIAlertAction(title: "Confirm Deleting", style: .default) { (_) in
            let emailField = alertController.textFields![0]
            let currentPW = alertController.textFields![1]
           
            
            
            /*----------------------------------------------*/
            let user = Auth.auth().currentUser
            var credential: AuthCredential = EmailAuthProvider.credential(withEmail: emailField.text!, password: currentPW.text!)
            
            // Prompt the user to re-provide their sign-in credentials
            
            user?.reauthenticate(with: credential) { error in
                if let error = error {
                    // An error happened.
                    print(error)
                    self.statusOutlet.text = error.localizedDescription
                } else {
                    // User re-authenticated.
                                user?.delete { error in
                                    if let error = error {
                                        // An error happened.
                                        print(error)
                                        self.statusOutlet.text = error.localizedDescription
                                    } else {
                                        // Account deleted.
                                        self.statusOutlet.text = "Account been Deleted"
                                        self.performSegue(withIdentifier: "backtoHome", sender: self)
                                    }
                                }
                }
            }
            
            
            
//            let user = Auth.auth().currentUser
//

            /*----------------------------------------------*/
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(deleteAccount)
        alertController.addAction(cancelAction)
        
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    
}



//        // 2- option B: Generation different keys
//        self.ref.child(userID!).childByAutoId().setValue("1")
//        self.ref.child(userID!).childByAutoId().setValue("7")
//
//
//
//
//
//        // retrieve from firebase
//         self.ref.child(userID!).observe(.childAdded, with: { (snapshot) in
//           if let postDict = snapshot.value as? String  {
//            print(postDict)
//            }
//            // ...
//        })
