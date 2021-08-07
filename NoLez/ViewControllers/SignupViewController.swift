//
//  SignupViewController.swift
//  NoLez
//
//  Created by SATVEER SINGH on 07/08/21.
//

import UIKit
import CoreData
class SignupViewController: UIViewController {

    
        var window: UIWindow?
        @IBOutlet weak var userNameTxtField: UITextField!
        
        @IBOutlet weak var PasswordTxtField: UITextField!
        var DataArry = [EmployeeModel]()
        
    //     MARKUP:- VIEW LIFE CYCLE
        override func viewDidLoad() {
            super.viewDidLoad()
            if let vale = UserDefaults.standard.value(forKey: "userName"){
                Alreadylogin()
            }
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            
            fetchResultFromLocalStorage()
        }
        
        //Fetch Local Data
        private func fetchResultFromLocalStorage() {
            self.DataArry.removeAll()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SignUpData")
            do {
                let result = try context.fetch(fetchRequest)
                for data in result as! [NSManagedObject] {
                    let userName = data.value(forKey: "userName") as? String ?? ""
                    let password = data.value(forKey: "password") as? String ?? ""
                    
                    let instance = EmployeeModel(username: userName, Password: password, ConfirmPassword: "")
                    self.DataArry.append(instance)
                    
                }
                print("Get Data SuccessFully")
            } catch {
                print("Failed")
            }
        }

        
        @IBAction func loginBtnPressed(_ sender: UIButton) {
            
            if userNameTxtField.text! == "" || PasswordTxtField.text! == "" {
                
                let alert = UIAlertController(title: "ERROR!!!", message: "Please fill all the required Field", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                
            }else{
                
                for single in DataArry{
                    
                    if single.username == userNameTxtField.text! && single.Password == PasswordTxtField.text!{
                        //login successfully
                        UserDefaults.standard.setValue(userNameTxtField.text!, forKey: "userName")
                       UserDefaults.standard.setValue(PasswordTxtField.text!, forKey: "password")
                        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeScreenVC") as! WelcomeScreenVC
                        navigationController?.pushViewController(vc, animated: true)
                        
                        
                    }
                }
            }
            
            
            
        }
        
        @IBAction func signupButtonClicked(_ sender: UIButton) {
            
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        func Alreadylogin(){
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeScreenVC") as! WelcomeScreenVC
            navigationController?.pushViewController(vc, animated: false)
           
        }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        
    }



