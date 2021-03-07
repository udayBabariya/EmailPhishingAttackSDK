//
//  ViewController.swift
//  EmailPhishingAttackDemo
//
//  Created by Uday on 07/03/21.
//

import UIKit
import EmailPhishingAttack

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        EmailPhishingAttack.shared.attack1 { (status) in
            print(">>> Attack1 Status: \(status)")
        }
        sleep(1)
        EmailPhishingAttack.shared.attack2 { (status) in
            print(">>> Attack2 Status: \(status)")
        }
    }


}

