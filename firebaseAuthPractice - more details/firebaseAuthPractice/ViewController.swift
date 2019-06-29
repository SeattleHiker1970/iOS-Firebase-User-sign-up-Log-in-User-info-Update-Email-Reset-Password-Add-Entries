
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

