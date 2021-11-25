import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "ListTableViewCell"

    @IBOutlet weak var listTableImage: UIImageView!
    
    @IBOutlet weak var listTableTilte: UILabel!
    @IBOutlet weak var listTableText1: UILabel!
    @IBOutlet weak var listTableText2: UILabel!
    @IBOutlet weak var listTableText3: UILabel!
    @IBOutlet weak var listTableText4: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
