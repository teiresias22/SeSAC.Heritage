import UIKit
import SwiftUI

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "ListTableViewCell"
    
    @IBOutlet weak var listTabelCellView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        listTabelCellView.layer.cornerRadius = 8
        listTabelCellView.backgroundColor = .customYellow
        
        titleLabel.textColor = .customBlack
        titleLabel.font = UIFont(name: "MapoFlowerIsland", size: 18)!
        titleLabel.numberOfLines = 0
        
        cityLabel.textColor = .customBlack
        cityLabel.font = UIFont().MapoFlowerIsland14
        
        locationLabel.textColor = .customBlack
        locationLabel.font = UIFont().MapoFlowerIsland14
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
