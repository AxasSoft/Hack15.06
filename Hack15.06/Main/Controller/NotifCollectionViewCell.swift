//
//  NotifCollectionViewCell.swift
//  Hack15.06
//
//  Created by Сергей Майбродский on 15.06.2024.
//

import UIKit
import SDWebImage

class NotifCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 16
        dateTime.text = Int(Date().timeIntervalSince1970).toHour
    }
    
    func configure(text: String, link: String) {
        body.text = text
        image.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let url: URL = Constants.imageUrl.appendingPathComponent(link)
        image.sd_setImage(with: url)
    }
}
