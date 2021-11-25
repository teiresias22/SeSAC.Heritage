import UIKit

class ListCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListCategoryCollectionViewCell"

    @IBOutlet weak var listCategoryImage: UIImageView!
    @IBOutlet weak var listCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        listCategoryLabel.textAlignment = .center
        listCategoryLabel.font = UIFont.systemFont(ofSize: 12)
    }

}
