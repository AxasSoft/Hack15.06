//
//  NotificationController.swift
//  Hack15.06
//
//  Created by Сергей Майбродский on 15.06.2024.
//

import UIKit

class NotificationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func close(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
}
