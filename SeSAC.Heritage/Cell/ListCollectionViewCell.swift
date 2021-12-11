import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListCollectionViewCell"

    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        listTitle.font = UIFont().MapoFlowerIsland16
        listTitle.textColor = .customWhite
        listTitle.textAlignment = .center
        
        cellView.backgroundColor = .customBlue
        cellView.layer.shadowRadius = 4
    }
}
