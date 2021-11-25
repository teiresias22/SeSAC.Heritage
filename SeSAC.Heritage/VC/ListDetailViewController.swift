import UIKit

class ListDetailViewController: UIViewController {
    
    @IBOutlet weak var visitedCheckButton: UIButton!
    @IBOutlet weak var visitedCheckLabel: UILabel!
    
    @IBOutlet weak var wannavisitCheckButton: UIButton!
    @IBOutlet weak var wannavisitCheckLabel: UILabel!
    
    @IBOutlet weak var findWayButton: UIButton!
    @IBOutlet weak var findWayLabel: UILabel!
    
    @IBOutlet weak var detailSmallLabel1: UILabel!
    @IBOutlet weak var detailSmallLable2: UILabel!
    
    @IBOutlet weak var detailBigLabel1: UILabel!
    @IBOutlet weak var detailBigLabel2: UILabel!
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "문화유산 상세".localized()
        
        setButton(visitedCheckButton, "landmark", (.customRed ?? .black))
        setButton(wannavisitCheckButton, "plus", (.customBlue ?? .black))
        setButton(findWayButton, "walking", (.customYellow ?? .black))
        
        setLabel(visitedCheckLabel, "방문했어요")
        setLabel(wannavisitCheckLabel, "방문하고 싶어요")
        setLabel(findWayLabel, "길찾기")
        
        setLabel(detailSmallLabel1, "구분")
        setLabel(detailSmallLable2, "시대")
        
        setLabel(detailBigLabel1, "이름이 들어갈곳 입니다.")
        setLabel(detailBigLabel2, "소재지 상세정보가 들어갈곳 입니다.")
        
        detailImage.backgroundColor = .customBlack
        
        
        // Do any additional setup after loading the view.
    }
    
    func setButton( _ target: UIButton, _ name: String , _ color: UIColor){
        target.setImage(UIImage(named: name), for: .normal)
        target.contentMode = .scaleToFill
        target.setTitle("", for: .normal)
        target.tintColor = color
        target.contentVerticalAlignment = .fill
        target.contentHorizontalAlignment = .fill
    }
    
    func setLabel(_ target: UILabel, _ text: String){
        target.text = text.localized()
    }
    

    

}
