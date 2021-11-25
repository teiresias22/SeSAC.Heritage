import UIKit

class MypageViewController: UIViewController {

    @IBOutlet weak var mypageVisitCount: UILabel!
    @IBOutlet weak var mypageVisitCountText: UILabel!
    
    @IBOutlet weak var mypageReviewCount: UILabel!
    @IBOutlet weak var mypageReviewCountText: UILabel!
    
    @IBOutlet weak var mypageCourseCount: UILabel!
    @IBOutlet weak var mypageCourseCountText: UILabel!
    
    @IBOutlet weak var mypageVistPlaceText: UIButton!
    @IBOutlet weak var mypageVistPlaceCollectionView: UICollectionView!
    
    @IBOutlet weak var mypageWantVisitPlaceText: UIButton!
    @IBOutlet weak var mypageWantVisitPlaceCollectionView: UICollectionView!
    
    @IBOutlet weak var mypageAnalysisTitle: UILabel!
    @IBOutlet weak var mypageAnalysisText: UILabel!
    
    @IBOutlet weak var mypageAnlysisPageText1: UILabel!
    @IBOutlet weak var mypageAnlysisPageView1: UIView!
    
    @IBOutlet weak var mypageAnlysisPageText2: UILabel!
    @IBOutlet weak var mypageAnlysisPageView2: UIView!
    
    @IBOutlet weak var mypageAnlysisPageText3: UILabel!
    @IBOutlet weak var mypageAnlysisPageView3: UIView!
    
    @IBOutlet weak var mypageAnlysisPageText4: UILabel!
    @IBOutlet weak var mypageAnlysisPageView4: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "마이페이지".localized()
        
        mypageVistPlaceCollectionView.delegate = self
        mypageVistPlaceCollectionView.dataSource = self
        
        mypageWantVisitPlaceCollectionView.delegate = self
        mypageWantVisitPlaceCollectionView.dataSource = self
        
        setLabel(mypageVisitCount, "\(128)")
        mypageVisitCount.textAlignment = .center
        setLabel(mypageVisitCountText, "방문")
        mypageVisitCountText.textAlignment = .center
        setLabel(mypageReviewCount, "\(12)")
        mypageReviewCount.textAlignment = .center
        setLabel(mypageReviewCountText, "후기")
        mypageReviewCountText.textAlignment = .center
        setLabel(mypageCourseCount, "\(2)")
        mypageCourseCount.textAlignment = .center
        setLabel(mypageCourseCountText, "코스")
        mypageCourseCountText.textAlignment = .center
        
        setButton(mypageVistPlaceText, "방문했어요")
        setButton(mypageWantVisitPlaceText, "방문하고싶어요")
        
        setLabel(mypageAnalysisTitle, "분석")
        setLabel(mypageAnalysisText, "지금까지 \(22)개를 방문한 문화재 전문가")
        
        setLabel(mypageAnlysisPageText1, "평가")
        setLabel(mypageAnlysisPageText2, "유형")
        setLabel(mypageAnlysisPageText3, "요일")
        setLabel(mypageAnlysisPageText4, "지역")
        
        setView(mypageAnlysisPageView1, (.customBlue ?? .systemBlue))
        setView(mypageAnlysisPageView2, (.customBlue ?? .systemBlue))
        setView(mypageAnlysisPageView3, (.customBlue ?? .systemBlue))
        setView(mypageAnlysisPageView4, (.customBlue ?? .systemBlue))
        
        collectionViewSet(mypageVistPlaceCollectionView)
        collectionViewSet(mypageWantVisitPlaceCollectionView)
        // Do any additional setup after loading the view.
    }
    
    func setLabel(_ target: UILabel, _ text: String) {
        target.text = text.localized()
    }
    
    func setButton(_ target: UIButton, _ text: String) {
        target.setTitle(text, for: .normal)
    }
    
    func setView(_ target: UIView, _ color: UIColor) {
        target.layer.cornerRadius = 6
        target.backgroundColor = color
    }
    
    func collectionViewSet(_ target: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let height = target.frame.height
        
        layout.itemSize = CGSize(width: height / 0.7 , height: height )
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .horizontal
        
        target.collectionViewLayout = layout
        target.backgroundColor = .clear
    }

}


extension MypageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mypageVistPlaceCollectionView {
            return 8
        }else {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mypageVistPlaceCollectionView {
            guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: MypageVistedPointCollectionViewCell.identifier, for: indexPath) as? MypageVistedPointCollectionViewCell else { return UICollectionViewCell() }
            
            //item.MypageVistedPointImage.backgroundColor = .customBlue
            
            return item
        }else {
            guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: MypageWantVisitedPointCollectionViewCell.identifier, for: indexPath) as? MypageWantVisitedPointCollectionViewCell else { return UICollectionViewCell() }
            
            //item.MypageWantVisitedPointImage.backgroundColor = .customRed
            
            return item
        }
    }
    /*
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if collectionView == bandCollectionView {
             guard let bandCell = bandCollectionView.dequeueReusableCell(withReuseIdentifier: "BandCollectionViewCell", for: indexPath) as? BandCollectionViewCell else {
                 return UICollectionViewCell()
             }

             return bandCell
         } else if collectionView == missionCollectionView {
             guard let missionCell = missionCollectionView.dequeueReusableCell(withReuseIdentifier: "MissionCollectionViewCell", for: indexPath) as? MissionCollectionViewCell else {
                 return UICollectionViewCell()
             }

             return missionCell
         } else if collectionView == pageCollectionView {
             guard let pageCell = pageCollectionView.dequeueReusableCell(withReuseIdentifier: "PageCollectionViewCell", for: indexPath) as? PageCollectionViewCell else {
                 return UICollectionViewCell()
             }
             pageCell.initializeData(pageList[indexPath.row].pageImage, pageList[indexPath.row].title, pageList[indexPath.row].detail, pageList[indexPath.row].subscribe)

             return pageCell
         } else {
             guard let topicCell = topicCollectionView.dequeueReusableCell(withReuseIdentifier: "TopicCollectionViewCell", for: indexPath) as? TopicCollectionViewCell else {
                 return UICollectionViewCell()
             }
             topicCell.initializeData(topicList[indexPath.row])

             return topicCell
         }
     }
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "ListDetail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
