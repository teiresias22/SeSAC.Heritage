import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var eventDetailImage: UIImageView!
    
    @IBOutlet weak var eventDetailTitle: UILabel!
    @IBOutlet weak var eventDetailTextLine1: UILabel!
    @IBOutlet weak var eventDetailTextLine2: UILabel!
    @IBOutlet weak var eventDetailTextLine3: UILabel!
    @IBOutlet weak var eventDetailTextLine4: UILabel!
    
    @IBOutlet weak var eventDetailTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "문화유산 행사".localized()
        
        eventDetailImage.backgroundColor = .customBlack
        
        setLabel(eventDetailTitle, "행사명이 들어가는곳 입니다.")
        setLabel(eventDetailTextLine1, "행사 유형이 들어가는곳 입니다.")
        setLabel(eventDetailTextLine2, "행사 일정이 들어가는곳 입니다.")
        setLabel(eventDetailTextLine3, "행사 장소가 들어가는곳 입니다.")
        setLabel(eventDetailTextLine4, "행사 문의처가 들어가는곳 입니다.")
        // Do any additional setup after loading the view.
    }
    
    func setLabel(_ target: UILabel, _ text: String) {
        target.text = text.localized()
    }

    

}
