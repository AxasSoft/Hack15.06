//
//  TaskController.swift
//  Hack15.06
//
//  Created by Сергей Майбродский on 15.06.2024.
//

import UIKit

class TaskController: UIViewController {
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var workerCount: UILabel!
    @IBOutlet weak var taskBody: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var responsibleAva: UIImageView!
    @IBOutlet weak var responsibleName: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    var isSecondTask = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firstImage.layer.cornerRadius = 8
        secondImage.layer.cornerRadius = 8
        
        completeButton.layer.cornerRadius = 8
        date.text = Int(Date().timeIntervalSince1970 + 60 * 60 * 24).toDay
        if isSecondTask {
            taskName.text = "Установка строительных лесов"
            workerCount.text = "8"
            date.text = Int(Date().timeIntervalSince1970 + 60 * 60 * 24 * 2).toDay
            taskBody.text = "Монтаж строительных лесов является ответственным этапом их использования. От этого зависит безопасность и эффективность рабочей бригады. Нарушение правил сборки часто заканчивается порчей имущества, серьёзными травмами или даже смертью на объекте. Правильно установленная конструкция — надёжная, прочная, устойчивая, жёсткая и безопасная. "
            
            responsibleName.text = "Семёнов Антон"
            responsibleAva.image = UIImage(resource: .avatar)
            firstImage.image = UIImage(resource: .image3)
            secondImage.image = UIImage(resource: .image4)
        }
    }
    
    @IBAction func completeTask(_ sender: UIButton){
        if isSecondTask {
            UserDefaults.standard.setValue(true, forKey: "secondComplete")
        } else {
            UserDefaults.standard.setValue(true, forKey: "firstComplete")
        }
        
        let alertVC = UIAlertController(title: "Сообщение", message: "Вы уверены что хотите отметить задачу как выполненную?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Да", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true)
    }
}
