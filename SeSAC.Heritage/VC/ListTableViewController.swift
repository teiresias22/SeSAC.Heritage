import UIKit

class ListTableViewController: UIViewController {
    
    @IBOutlet weak var listTable: UITableView!
    
    var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "문화유산 목록".localized()
        
        listTable.delegate = self
        listTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
}

extension ListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.listTableImage.backgroundColor = .customBlack
        cell.listTableTilte.text = "제목이 들어갈곳 입니다".localized()
        cell.listTableText1.text = "첫번째 내용이 들어갈 곳".localized()
        cell.listTableText2.text = "두번째 내용이 들어갈 곳".localized()
        cell.listTableText3.text = "세번째 내용이 들어갈 곳".localized()
        cell.listTableText4.text = "네번째 내용이 들어갈 곳".localized()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ListDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
