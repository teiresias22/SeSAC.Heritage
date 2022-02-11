//
//  SearchTableViewCell.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/11/30.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"

    @IBOutlet weak var searchCellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchCellView.backgroundColor = .customYellow
        searchCellView.layer.cornerRadius = 8
        
        titleLabel.textColor = .customBlack
        titleLabel.font = UIFont(name: "MapoFlowerIsland", size: 18)!
        titleLabel.numberOfLines = 0
        
        cityLabel.textColor = .customBlack
        cityLabel.font = .MapoFlowerIsland14
        
        locationLabel.textColor = .customBlack
        locationLabel.font = .MapoFlowerIsland14
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
