//
//  CreateAccount.swift
//  firebaseAuthPractice
//
//  Created by Nasser Jeary on 2019-06-09.
//  Copyright © 2019 Nasser Jeary. All rights reserved.
//

import UIKit
import Firebase


class CreateAccount: UIViewController {

   /*--------outlets-------------*/
    @IBOutlet weak var createEmailInput: UITextField!
    
    @IBOutlet weak var createPWInput: UITextField!
    
    @IBOutlet weak var createStatus: UILabel!
   /*---------------------------*/
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    
    
    
     /*--------------------------------------*/
    @IBAction func CreateAccountButton(_ sender: Any) {
        
        let newEmail = createEmailInput.text!
        let newPW = createPWInput.text!
        
        Auth.auth().createUser(withEmail: newEmail, password: newPW) { authResult, error in
            
            if(error != nil){
                print(error)
                self.createStatus.text = error?.localizedDescription
            }
            else{
            
            
            self.createStatus.text = "Your account has been created, return to login page and sign-in"
            }
        }
    }
    /*--------------------------------------*/
    
    
    
    
}// end of viewController
