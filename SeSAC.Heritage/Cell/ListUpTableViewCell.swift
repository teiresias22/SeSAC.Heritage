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
        
        listUpCellView.backgroundColor = .customBlue
        listUpCellView.layer.cornerRadius = 8
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
