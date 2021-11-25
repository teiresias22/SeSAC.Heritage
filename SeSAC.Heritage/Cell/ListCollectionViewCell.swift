import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListCollectionViewCell"

    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listText: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        listTitle.font = .boldSystemFont(ofSize: 16)
        listText.font = .systemFont(ofSize: 14)
        listText.numberOfLines = 5
        
        cellView.backgroundColor = .clear
        cellView.layer.shadowColor = UIColor.white.cgColor
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowRadius = 10
    }

}
