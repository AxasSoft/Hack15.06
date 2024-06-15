//
//  NotifCollectionViewCell.swift
//  Hack15.06
//
//  Created by Сергей Майбродский on 15.06.2024.
//

import UIKit

class NotifCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var body: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 16
        dateTime.text = Int(Date().timeIntervalSince1970).toHour
    }
    
    func configure(text: String) {
        body.text = text
    }
}
