//
//  HomeViewController.swift
//  NoLez
//
//  Created by SATVEER SINGH on 07/08/21.
//

import UIKit

class HomeViewController: UIViewController, DisplayViewControllerDelegate{
    

    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var loginlabel: UILabel!
    @IBOutlet weak var prefLabel: UILabel!
    @IBOutlet weak var leadLabel: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var pref: UIButton!
    @IBOutlet weak var leaderboard: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func doSizeChange(data: CGFloat) {
        
        signupLabel.font = UIFont(name: signupLabel.font.fontName, size: data)
        loginlabel.font = UIFont(name: loginlabel.font.fontName, size: data)
        prefLabel.font = UIFont(name: prefLabel.font.fontName, size: data)
        leadLabel.font = UIFont(name: leadLabel.font.fontName, size: data)
    }
    
    func doLocationChange(cityloc: String, temperature: String, description: String) {
        desc.text = description
        city.text = cityloc
        temp.text = temperature
    }
    func changetheme(background: UIColor, textcolor: UIColor) {
        view.backgroundColor = background
        city.textColor = textcolor
        temp.textColor = textcolor
        desc.textColor = textcolor
        login.setTitleColor(textcolor, for: .normal)
        pref.setTitleColor(textcolor, for: .normal)
        signup.setTitleColor(textcolor, for: .normal)
        leaderboard.setTitleColor(textcolor, for: .normal)
    }
    
    
    
    @IBAction func preferencetapped(_ sender: Any) {
        self.performSegue(withIdentifier: "home", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "home"){
            let displayVC = segue.destination as! PreferencesViewController
            displayVC.delegate = self
        }
    }
    

}
