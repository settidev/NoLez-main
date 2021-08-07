//
//  WelcomeScreenVC.swift
//  Nolez
//
//  Created by Kunal Gambhir on 07/08/2021.
//

import UIKit

class WelcomeScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
  
    @IBAction func logOutbtnClicked(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "userName")
        self.navigationController?.popViewController(animated: true)
    }
    
}
