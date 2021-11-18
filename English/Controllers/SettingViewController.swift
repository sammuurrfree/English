//
//  SettingViewController.swift
//  English
//
//  Created by Преподаватель on 18.11.2021.
//

import UIKit

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "main")
        self.present(vc!, animated: true)
    }

    @IBAction func exitButton(_ sender: Any) {
        UserDefaults().set(0, forKey: "userId")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login")
        self.present(vc!, animated: true)
    }
    

}
