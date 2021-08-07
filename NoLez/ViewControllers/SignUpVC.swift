//
//  SignUpVC.swift
//  Nolez
//
//  Created by Kunal Gambhir on 07/08/2021.
//

import UIKit
import CoreData
struct EmployeeModel {
    var username : String?
    var Password : String?
    var ConfirmPassword : String?
}
class SignUpVC: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
       
    }
    // Save data locally
    private func saveDataInLocalStorage(instance: EmployeeModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "SignUpData", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(instance.username, forKey: "userName")
        newUser.setValue(instance.Password, forKey: "password")
        newUser.setValue(instance.ConfirmPassword, forKey: "confirmPassword")
        do {
            try context.save()
            print("Data Saved SuccessFully")
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Failed saving")
        }
    }
    
    
    @IBAction func SignUpBtnClicked(_ sender: UIButton) {
        if userNameTextField.text! == "" || passwordTextField.text! == "" || ConfirmPassword.text! == ""{
            
            let alert = UIAlertController(title: "ERROR!!!", message: "Please fill all the required Field", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            
        }else{
            if passwordTextField.text! != ConfirmPassword.text!{
                let alert = UIAlertController(title: "ERROR!!!", message: "please check password and confirm password are not same.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
            }else{
                let instance = EmployeeModel(username: userNameTextField.text!, Password: passwordTextField.text!, ConfirmPassword: ConfirmPassword.text!)
                saveDataInLocalStorage(instance: instance)
            }
            
        }
       
        
        
    }
    
}
