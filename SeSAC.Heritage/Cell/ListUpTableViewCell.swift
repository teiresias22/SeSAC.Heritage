//
//  ListUpTableViewCell.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/12/01.
//

import UIKit

class ListUpTableViewCell: UITableViewCell{
    static let identifier = "ListUpTableViewCell"

    @IBOutlet weak var ListUpCellView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
