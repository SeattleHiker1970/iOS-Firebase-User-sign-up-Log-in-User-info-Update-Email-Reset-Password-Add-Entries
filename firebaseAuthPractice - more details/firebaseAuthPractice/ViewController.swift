
// 1- create the interface

/* - from the main view to create view (segue from orange circle button to create view)(show)
 
 - from the main view to create view (segue from orange circle button to welcome view)(present modaly)
 
 - add the identifier of both segue    "create"   "welcome"
 */

// 2- coonect the button as actions


// connect
// 2- create the firebase project  on the console


/* 3- create two classes type of viewConterller for the new view
 and assign them on storyboard
 
  - link the outlets
*/



// 4- close Xcode and go add firebase project
// https://firebase.google.com/docs

// then follow instroctions on this page:
// https://firebase.google.com/docs/auth/ios/password-auth



// cd your project
// pod init
// open pod then add:    pod 'FirebaseUI/Auth'
// pod install



/* go and create a firebase project on your console then
click on iOS icon there
 
- iOS bundel identifer is the one you have in Xcode
 - then once you click register App download GoogleServicesInfo.plist add it to your project
 
 - Import the Firebase module in your UIApplicationDelegate
 
 - in delegate as well addd ( FirebaseApp.configure() ) to this function didFinishLaunchingWithOptions: method:
 
 - import Firebase in viewController  as well
 
 - Enable signin with Email on firebase console

 */




import UIKit
import Firebase



class ViewController: UIViewController {

    @IBOutlet weak var signInEmail: UITextField!
    
    @IBOutlet weak var signInPw: UITextField!
    
    
    @IBOutlet weak var signInStatus: UILabel!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    
    
    
    @IBAction func segueToCreate(_ sender: Any) {
        performSegue(withIdentifier: "create", sender: self)
    }
    
    
    
    
    
    
    @IBAction func logInButton(_ sender: Any) {
        
        
        let Email = signInEmail.text!
        let PW = signInPw.text!
        
        Auth.auth().signIn(withEmail: Email, password: PW) { [weak self] user, error in
            guard let strongSelf = self else { return }
            
            if(error != nil){
                print(error)
                self?.signInStatus.text = error?.localizedDescription
            }else{
            
            self?.signInStatus.text = "signIn successfully!"
                self?.performSegue(withIdentifier: "welcome", sender: self)
            }
        }
        
        
       
    }
    
    
    
    
    
    
  
    
    
    
    
    //@IBAction func exit(segue: UIStoryboardSegue){}
 @IBAction func exit(segue: UIStoryboardSegue){
    
    let firebaseAuth = Auth.auth()
    do {
        try firebaseAuth.signOut()
        self.signInStatus.text = "signed out successfully"
    } catch let signOutError as NSError {
        print ("Error signing out: %@", signOutError)
        return
    }
    
    }
    
    
    
    
    
    
  
    
} // end of viewController

