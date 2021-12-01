import UIKit
import SwiftUI

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "ListTableViewCell"
    
    @IBOutlet weak var listTabelCellView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        listTabelCellView.layer.cornerRadius = 12
        listTabelCellView.backgroundColor = .customYellow
        
        countLabel.textColor = .customBlack
        countLabel.font = UIFont().MapoFlowerIsland16
        countLabel.textAlignment = .center
        
        categoryLabel.textColor = .customBlack
        categoryLabel.font = UIFont().MapoFlowerIsland14
        
        titleLabel.textColor = .customBlack
        titleLabel.font = UIFont().MapoFlowerIsland16
        
        cityLabel.textColor = .customBlack
        cityLabel.font = UIFont().MapoFlowerIsland14
        cityLabel.textAlignment = .center
        
        locationLabel.textColor = .customBlack
        locationLabel.font = UIFont().MapoFlowerIsland14
        locationLabel.textAlignment = .center
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
