//
//  EventTableViewCell.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/11/21.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    static let identifier = "EventTableViewCell"

    @IBOutlet weak var eventViewPage: UIView!
    @IBOutlet weak var evenntImage: UIImageView!
    
    @IBOutlet weak var eventTextLine1: UILabel!
    @IBOutlet weak var eventTextLine2: UILabel!
    @IBOutlet weak var eventTextLine3: UILabel!
    
    @IBOutlet weak var eventKiendText: UILabel!
    @IBOutlet weak var eventCurrentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        eventViewPage.layer.cornerRadius = 8
        eventViewPage.backgroundColor = .customWhite
        eventViewPage.layer.shadowColor = UIColor.gray.cgColor
        eventViewPage.layer.shadowRadius = 5
        eventViewPage.layer.shadowOpacity = 0.8
        
        evenntImage.layer.cornerRadius = 11
        evenntImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        eventKiendText.backgroundColor = .customBlue
        eventCurrentText.backgroundColor = .customBlue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
