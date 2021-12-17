import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import RealmSwift
import SwiftUI

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var myLocation: UIButton!
    @IBOutlet weak var heritageFilter: UIButton!
    
    @IBOutlet weak var listBarButton: TabBarButton!
    @IBOutlet weak var SearchBarButton: TabBarButton!
    @IBOutlet weak var mapBarButton: TabBarButton!
    @IBOutlet weak var myBarButton: TabBarButton!
    
    @IBOutlet weak var conteinerViewHeight: NSLayoutConstraint!
    
    let localRealm = try! Realm()
    var heritageData: Results<Heritage_List>!
    var locationManager = CLLocationManager()
    
    var heightStatus = false
    var city: String = ""
    var code: String = ""
    
    var runTimeInterval: TimeInterval? // 마지막 작업을 설정할 시간
    let mTimer: Selector = #selector(Tick_TimeConsole) // 위치 확인 타이머
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 14)!]
        
        setTopButton(myLocation, "street", .customBlue!)
        setTopButton(heritageFilter, "street", .customYellow!)
        secTabBarButtons()
        setAllAnnotations()
        
        
        mapView.delegate = self
        locationManager.delegate = self
        //정확도 설정 - 최고 높은 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치정보 사용권한 요청 - 실행중일때만 권한을 사용
        locationManager.requestWhenInUseAuthorization()
        //위치 업데이트 시작
        locationManager.startUpdatingLocation()
        //사용자 위치 보기 설정
        mapView.showsUserLocation = true
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: mTimer, userInfo: nil, repeats: true)
    }
    
    //Setting My Location Button
    func setTopButton(_ target: UIButton, _ text: String, _ color: UIColor) {
        target.setImage(UIImage(named: text), for: .normal)
        target.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        target.contentMode = .scaleToFill
        target.setTitle("", for: .normal)
        target.contentVerticalAlignment = .fill
        target.contentHorizontalAlignment = .fill
        target.layer.cornerRadius = 20
        target.tintColor = .customBlack
        target.backgroundColor = color
    }
    
    //My Location Button Clicked
    @IBAction func myLocationClicked(_ sender: UIButton) {
        checkUserLocationServicesAithorization()
    }
    
    @IBAction func heritageFilterClicked(_ sender: UIButton) {
        heightStatus = !heightStatus
        
        conteinerViewHeight.constant = heightStatus ? UIScreen.main.bounds.height * 0.35 : 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setAllAnnotations() {
        let annotiations = mapView.annotations
        mapView.removeAnnotations(annotiations)
        heritageData = localRealm.objects(Heritage_List.self)
        
        for location in heritageData {
            let heritageLatitude = Double(location.latitude)!
            let heritageLongitude = Double(location.longitude)!
            
            let heritageCoordinate = CLLocationCoordinate2D(latitude: heritageLatitude, longitude: heritageLongitude)
            let heritageAnnotaion = MKPointAnnotation()
            
            heritageAnnotaion.title = location.ccbaMnm1
            heritageAnnotaion.coordinate = heritageCoordinate
            mapView.addAnnotation(heritageAnnotaion)
        }
    }
    
    //권한 비허용시 기본화면
    func defaultLocation() {
        var location = CLLocationCoordinate2D()
        let annotation = MKPointAnnotation()
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        
        location = CLLocationCoordinate2D(latitude: 37.52413651649104, longitude: 126.98001340101837)
        
        annotation.title = "사용자의 위치를 확인할수 없습니다."
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }
    
    //위치 권한 허용 확인
    func checkUserLocationServicesAithorization() {
        let authorizationStatus: CLAuthorizationStatus
        authorizationStatus = locationManager.authorizationStatus
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization(authorizationStatus) //권한 확인
        } else {
            showAlert(alertTitle: "위치 서비스", alertMessage: "iOS 위치 서비스를 켜주세요.")
        }
    }
    
    //권환 확인
    func checkLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            //현재 위치 가져오기
            let userLocation = mapView.userLocation
            //현재 위치 기준으로 영역을 설정
            let region = MKCoordinateRegion(center: userLocation.location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            //맵 뷰의 영역을 설정
            mapView.setRegion(region, animated: true)
        case .notDetermined:
            print("GPS 권한 설정되지 않음")
        case .denied, .restricted:
            print("GPS 권한 요청 거부됨")
            showAlert(alertTitle: "위치 서비스", alertMessage: "iOS위치 서비스 권한 요청이 거부되어 서비스를 제공할수 없습니다.")
        default:
            print("GPS Default")
        }
        if #available(iOS 14.0, *) {
            let accurancyState = locationManager.accuracyAuthorization
            switch accurancyState {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default:
                print("DEFAULT")
            }
        }
    }
    
    //비허용시 알림창 띄우기
    func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let allTheater = UIAlertAction(title: "확인", style: .cancel) { _ in
        }
        alert.addAction(allTheater)
        present(alert, animated: true)
    }
}
    
extension MapViewController: CLLocationManagerDelegate{
    //사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        moveLocation(latitudeValue: (location.coordinate.latitude), longtudeValue: (location.coordinate.longitude), delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if let pm: CLPlacemark = placemarks?.first {
                let address: String = "\(pm.locality ?? "") \(pm.name ?? "")"
                //print("locationManager", address)
            }
        })
        locationManager.stopUpdatingLocation()
    }
    
    func moveLocation(latitudeValue: CLLocationDegrees, longtudeValue: CLLocationDegrees, delta span: Double) {
         let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
         let pSpanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
         let pRegion = MKCoordinateRegion(center: pLocation, span: pSpanValue)
         mapView.setRegion(pRegion, animated: true)
     }
    
    //5. 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //6. iOS14 미만: 앱이 위치 관리자를 생성하고,  승인 상태가 변경이 될 때 대리자에게 승인 상채를 알려줌
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
    //7. iOS14 이상: 앱이 위치 관리자를 생성하고,  승인 상태가 변경이 될 때 대리자에게 승인 상채를 알려줌
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        runTimeInterval = Date().timeIntervalSinceReferenceDate
    }
    
    @objc func Tick_TimeConsole() {
        guard let timeInterval = runTimeInterval else { return }
        let interval = Date().timeIntervalSinceReferenceDate - timeInterval
        if interval < 0.25 { return }
        let coordinate = mapView.centerCoordinate
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        // 지정된 위치의 지오 코드 요청
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let pm: CLPlacemark = placemarks?.first {
                let address: String = "\(pm.country ?? "") \(pm.administrativeArea ?? "") \(pm.locality ?? "") \(pm.subLocality ?? "") \(pm.name ?? "")"
                self.title = address.localized()
            }
        }
        runTimeInterval = nil
        
        //지도 중앙 좌표
        //var latitude = coordinate.latitude
        //var longitude = coordinate.longitude
    }
}

extension MapViewController {
    func secTabBarButtons() {
        setBarButton(listBarButton, "list.dash")
        listBarButton.tabBarButton.addTarget(self, action: #selector(listButtonClicked), for: .touchUpInside)
        
        setBarButton(SearchBarButton, "magnifyingglass")
        SearchBarButton.tabBarButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
        setBarButton(mapBarButton, "map")
        mapBarButton.tabBarButton.addTarget(self, action: #selector(mapButtonClicked), for: .touchUpInside)
        
        setBarButton(myBarButton, "person")
        myBarButton.tabBarButton.addTarget(self, action: #selector(mypageButtonClicked), for: .touchUpInside)
    }
    
    @objc func listButtonClicked() {
        guard let vc = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    @objc func searchButtonClicked() {
        guard let vc = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    @objc func mapButtonClicked() {
        guard let vc = UIStoryboard(name: "Map", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    @objc func mypageButtonClicked() {
        guard let vc = UIStoryboard(name: "ListUp", bundle: nil).instantiateViewController(withIdentifier: "ListUpViewController") as? ListUpViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false, completion: nil)
    }
    
    func setBarButton(_ target: TabBarButton, _ image: String){
        target.tabBarButton.setImage(UIImage(systemName: image), for: .normal)
        target.tabBarButton.imageEdgeInsets = UIEdgeInsets(top: 16, left: 36, bottom: 28, right: 36)
        target.tabBarButton.contentMode = .scaleToFill
        target.tabBarButton.setTitle("", for: .normal)
        target.tabBarButton.contentVerticalAlignment = .fill
        target.tabBarButton.contentHorizontalAlignment = .fill
        mapBarButton.tabBarActiveView.backgroundColor = .customBlue
    }
    
}
