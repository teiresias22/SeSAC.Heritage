import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListCollectionViewCell"
    
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                listTitle.font = UIFont().MapoFlowerIsland14
                listTitle.textColor = .customBlack
                cellView.backgroundColor = .clear
            } else {
                listTitle.font = UIFont().MapoFlowerIsland16
                listTitle.textColor = .customBlue
                cellView.backgroundColor = .customBlue
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
