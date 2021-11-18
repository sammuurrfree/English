//
//  ProfilViewController.swift
//  English
//
//  Created by Преподаватель on 18.11.2021.
//

import UIKit

class ProfilViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDef = UserDefaults()
        
        nameLabel.text = "Имя:  \(userDef.string(forKey: "userName")!)"
        emailLabel.text = "Email:   \(userDef.string(forKey: "userEmail")!)"
    }

    
}
