//
//  ViewController.swift
//  Hack15.06
//
//  Created by Сергей Майбродский on 15.06.2024.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {
    
    @IBOutlet weak var allWorkersView: UIView!
    @IBOutlet weak var allWorkers: UILabel!
    @IBOutlet weak var dangerWorkersView: UIView!
    @IBOutlet weak var dangerWorkers: UILabel!
    @IBOutlet weak var allTechniqueView: UIView!
    @IBOutlet weak var allTechnique: UILabel!
    @IBOutlet weak var workStopTechniqueView: UIView!
    @IBOutlet weak var workStopTechnique: UILabel!
    
    @IBOutlet weak var notifCollection: UICollectionView!
    @IBOutlet weak var notifHint: UILabel!
    @IBOutlet weak var taskDate: UILabel!
    
    @IBOutlet weak var firstTaskView: UIView!
    @IBOutlet weak var firstTaskDate: UILabel!
    @IBOutlet weak var firstTaskDeadline: UILabel!
    
    @IBOutlet weak var secondTaskView: UIView!
    @IBOutlet weak var secondTaskDate: UILabel!
    @IBOutlet weak var secondTaskDeadline: UILabel!
    
    @IBOutlet weak var taskEmptyStack: UIStackView!
    @IBOutlet weak var returnTaskButton: UIButton!
    
    //    "Работники на строительном участке №1 работают без отдыха более 2 мин."
    var notifications: [String] = []
    var links: [String] = []
    
    //timer
    var repeatSend = false
    var timer = Timer()
    var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTaskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openFirstTask)))
        secondTaskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSecondTask)))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        notifHint.isHidden = false
        notifCollection.isHidden = true
        
        allWorkersView.layer.cornerRadius = 8
        dangerWorkersView.layer.cornerRadius = 8
        allTechniqueView.layer.cornerRadius = 8
        workStopTechniqueView.layer.cornerRadius = 8
        returnTaskButton.layer.cornerRadius = 8
        
        taskDate.text = Int(Date().timeIntervalSince1970).toDay
        
        firstTaskView.layer.cornerRadius = 8
        secondTaskView.layer.cornerRadius = 8
        firstTaskDate.text = Int(Date().timeIntervalSince1970).toDayAndHour
        secondTaskDate.text = Int(Date().timeIntervalSince1970 + 60 * 60 * 2 + 300).toDayAndHour
        
        firstTaskDeadline.text = Int(Date().timeIntervalSince1970 + 60 * 60 * 24).toDay
        secondTaskDeadline.text = Int(Date().timeIntervalSince1970 + 60 * 60 * 24 * 2).toDay
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getData), userInfo: nil, repeats: true)
        
        taskEmptyStack.isHidden = true
        if UserDefaults.standard.bool(forKey: "firstComplete") == true {
            firstTaskView.isHidden = true
        } else {
            firstTaskView.isHidden = false
        }
        
        if UserDefaults.standard.bool(forKey: "secondComplete") == true {
            secondTaskView.isHidden = true
        } else {
            secondTaskView.isHidden = false
        }
        
        if UserDefaults.standard.bool(forKey: "secondComplete") == true && UserDefaults.standard.bool(forKey: "firstComplete") == true  {
            taskEmptyStack.isHidden = false
        }
        
    }
    
    @objc func openFirstTask(_ sender: UIView){
        let sBoard = UIStoryboard(name: "Main", bundle: .main)
        let vc = sBoard.instantiateViewController(withIdentifier: "TaskVC") as! TaskController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openSecondTask(_ sender: UIView){
        let sBoard = UIStoryboard(name: "Main", bundle: .main)
        let vc = sBoard.instantiateViewController(withIdentifier: "TaskVC") as! TaskController
        vc.isSecondTask = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func getData() {
        seconds += 1
        if seconds % 5 == 0 {
            firstly {
                MainModel.getData()
            } .done { [weak self] data in
                if data.count > 0 {
                    if data[0].heap ?? 0 >= 3 {
                        self?.notifications = []
                        self?.links = []
                        self?.notifications.append("Работники соборались группой \(data[0].heap ?? 0) человек(а)")
                        self?.links.append(data[0].frameUrl ?? "")
                    } else {
                        self?.notifications = []
                        self?.links = []
                        self?.links.append(data[0].frameUrl ?? "")
                    }
                }
                
            } .catch { [weak self] _ in
                
            }
        }
        notifCollection.reloadData()
    }
    
    @IBAction func returnTask(_ sender: UIButton) {
        UserDefaults.standard.setValue(false, forKey: "firstComplete")
        UserDefaults.standard.setValue(false, forKey: "secondComplete")
        viewWillAppear(true)
    }
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if links.count == 0 {
            notifHint.isHidden = false
            notifCollection.isHidden = true
        } else {
            notifHint.isHidden = true
            notifCollection.isHidden = false
        }
        return links.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "notifCell", for: indexPath) as! NotifCollectionViewCell
        cell.configure(text: notifications.count > 0 ? notifications[indexPath.item] : "", link: links[indexPath.item] )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 358)
    }
    
}
