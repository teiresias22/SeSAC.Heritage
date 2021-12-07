import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListCollectionViewCell"

    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listText: UILabel!
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        listTitle.font = UIFont(name: "MapoFlowerIsland", size: 20)!
        listTitle.textColor = .white
        listTitle.textAlignment = .center
        
        listText.font = UIFont().MapoFlowerIsland14
        listText.textColor = .white
        listText.textAlignment = .center
        listText.numberOfLines = 3
        
        cellView.backgroundColor = .clear
        cellView.layer.shadowColor = UIColor.white.cgColor
        cellView.layer.shadowRadius = 10
    }
}
