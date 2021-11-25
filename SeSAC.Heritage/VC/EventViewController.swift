import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var eventFilterButton1: UIButton!
    @IBOutlet weak var eventFilterButton2: UIButton!
    @IBOutlet weak var eventFilterButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "문화유산 행사".localized()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    

}

extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        
        cell.evenntImage.backgroundColor = .customBlack
        cell.eventTextLine1.text = "행사제목이 들어갈곳 입니다."
        cell.eventTextLine2.text = "행사의 위치가 들어갈곳 입니다."
        cell.eventTextLine3.text = "행사의 기간이 들어갈곳 입니다."
        cell.eventCurrentText.text = "진행중"
        cell.eventKiendText.text = "행사종류"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "EventDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
