import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListCollectionViewCell"

    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listText: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        listTitle.font = UIFont(name: "MapoFlowerIsland", size: 20)!
        listTitle.textColor = .white
        listTitle.textAlignment = .center
        
        listText.font = UIFont().MapoFlowerIsland16
        listText.textColor = .white
        listText.textAlignment = .center
        listText.numberOfLines = 5
        
        cellView.backgroundColor = .clear
        cellView.layer.shadowColor = UIColor.white.cgColor
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowRadius = 10
    }
}
