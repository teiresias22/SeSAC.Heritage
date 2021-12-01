//
//  ListUpTableViewCell.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/12/01.
//

import UIKit

class ListUpTableViewCell: UITableViewCell{
    
    static let identifier = "ListUpTableViewCell"

    @IBOutlet weak var listUpCellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*
        listUpCellView.backgroundColor = .customRed
        listUpCellView.layer.cornerRadius = 8
        
        titleLabel.textColor = .customWhite
        titleLabel.font = UIFont().MapoFlowerIsland16
        
        cityLabel.textColor = .customWhite
        cityLabel.font = UIFont().MapoFlowerIsland12
        
        locationLabel.textColor = .customWhite
        locationLabel.font = UIFont().MapoFlowerIsland12
         */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
