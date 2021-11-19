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
    
    @IBOutlet weak var toDayLAbel: UILabel!
    @IBOutlet weak var toDayProgress: UIProgressView!
    
    @IBOutlet weak var allLabel: UIStackView!
    @IBOutlet weak var allProgress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDef = UserDefaults()
        
        nameLabel.text = "Имя:  \(userDef.string(forKey: "userName")!)"
        emailLabel.text = "Email:   \(userDef.string(forKey: "userEmail")!)"
        
        let count = Words().studyWordAll()
        let toDayCount = Words().studyWordDay()
        
        let allToDayCount = UserDefaults().integer(forKey: "userWordCount")
        
        toDayProgress.progress = Float((100 / allToDayCount) * toDayCount)
        allProgress.progress = Float((100 / count[1]) * count[0])
    }

    
}
