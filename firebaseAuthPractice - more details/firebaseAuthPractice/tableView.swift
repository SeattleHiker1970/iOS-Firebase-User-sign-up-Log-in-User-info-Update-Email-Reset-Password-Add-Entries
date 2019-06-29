

import UIKit
import Firebase


class tableView: UITableViewController {

    
    // 4- globale array
    var globalArray = [String]()
    var postIDS = [String]()
    
    /*---------reference---------*/
   var ref: DatabaseReference!
   /*--------------Handle------------------*/

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*---------initializing---------*/
        ref = Database.database().reference()
        /*--------------------------------*/
        
      
         self.clearsSelectionOnViewWillAppear = false
       
        retrieve()

    }

    
    
    
    func retrieve(){
         self.globalArray.removeAll()
         self.postIDS.removeAll()
        /*------------11 retrieving data on App opening-------------*/
        let userID = Auth.auth().currentUser?.uid
        
        // read/retrieve from FB
        self.ref.child(userID!).observe(.value, with: { (snapshot) in
            
            
             print("this is the snapshot \(snapshot)")
            if let postDict = snapshot.value as? [String: Any] {
               print(postDict) //
               var key = postDict.keys  // array of keys
                print(key)
                
                for i in key{
                    print("\(i)")
                    self.postIDS.append(i)
                }
            } // end if let
            
           
            
            
            /*-------------------------*/
            // read/retrieve from FB
            self.ref.child(userID!).observe(.childAdded, with: { (snapshot) in
                
                if let entry = snapshot.value as? String{
                print("this is the entry \(entry)")
               
                self.globalArray.append(entry)
                self.tableView.reloadData()
                }
                })
            /*-------------------------*/
        })
        /*----------------------------------------------------*/
    }
    
    
    
    
    
    
    
    
    
    
    
  
// 7
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return globalArray.count
    }

    
    
    
    
    
    
    // 8
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tabelCell", for: indexPath)

         let entry = globalArray[indexPath.row]
        cell.textLabel?.text = entry

        return cell
    }
    
    
    
    
    
    
    
    
    // 9
    @IBAction func addEntry(_ sender: Any) {
        let ALERT =  UIAlertController(title: "Add", message: "Write your todo" , preferredStyle: .alert)
        
        ALERT.addTextField{ (ourTextField) in
            ourTextField.placeholder = "Enter text here"
        }
        
        
        let SaveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            if let valueExist = ALERT.textFields?.first {
                let inputValue = valueExist.text
               // print(inputValue!)
                /*******************************/
                self.appendToArray(txt: inputValue!)
                /******************************/
            }
        }
        
        
        let CanceleAction = UIAlertAction(title: "Cancele", style: .cancel, handler: nil)
        
        ALERT.addAction(SaveAction)
        ALERT.addAction(CanceleAction)
        self.present(ALERT, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    

    func appendToArray(txt: String){
    
       let userID = Auth.auth().currentUser?.uid
        
        // Write to FB
       let db = self.ref.child(userID!).childByAutoId()
        db.setValue(txt)
     
        
        //self.globalArray.removeAll()
       // self.tableView.reloadData()
        // read/retrieve from FB
        self.globalArray.removeAll()
        self.tableView.reloadData()
         // retrieve()
        
        //we dont need it because retrieve() is listening to changes
    
    } // end of appendToArray()
    
    
    
    
    

    
    
    
    
    
    
    

    //extra
    //didSelectRowAtIndexPath
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        /*--------------------------------*/

        let ALERT =  UIAlertController(title: "Edit", message: "Edit your todo" , preferredStyle: .alert)
        ALERT.addTextField{ (ourTextField) in
            ourTextField.placeholder = "Enter text here"
        }

        let SaveAction = UIAlertAction(title: "Save", style: .default) { (action) in

            if let valueExist = ALERT.textFields?.first {
                let inputValue = valueExist.text
              //  print(inputValue!)
                /*----------------*/
                let userID = Auth.auth().currentUser?.uid
                let post_ID = self.postIDS[indexPath.row]

              let db = self.ref.child("\(userID!)/\(post_ID)")

                db.setValue(inputValue!)

                /*----------------*/
              
            }
        }


        let CanceleAction = UIAlertAction(title: "Cancele", style: .cancel, handler: nil)

        ALERT.addAction(SaveAction)
        ALERT.addAction(CanceleAction)
        self.present(ALERT, animated: true)
        /*-------------------------*/
    }

    

    
    
    
    
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



//
//
//var db =  self.ref.child(user!.uid).observe(DataEventType.value, with: { (snapshot) in
//    let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//    /*-------------------------*/
//    print(postDict)
//    let entry = postDict["entry"]
//    print(entry)
