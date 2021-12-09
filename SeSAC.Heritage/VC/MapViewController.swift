import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import RealmSwift

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var heritageLocation: UIButton!
    @IBOutlet weak var myLocation: UIButton!
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    
    var locationManager = CLLocationManager()
    
    var item = Heritage_List()
    var items = Heritage_List()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = item.ccbaMnm1.localized()
        
        setTopButton(heritageLocation, "landmark")
        setTopButton(myLocation, "plus")
        
        //위치정보 사용권한 요청 - 실행중일때만 권한을 사용
        locationManager.requestWhenInUseAuthorization()
        //현재 위치를 지도에 표시하도록 설정
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        defaultLocation()
        // Do any additional setup after loading the view.
    }
    
    func setTopButton( _ target: UIButton, _ name: String){
        target.setImage(UIImage(named: name), for: .normal)
        target.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        target.contentMode = .scaleToFill
        target.setTitle("", for: .normal)
        target.contentVerticalAlignment = .fill
        target.contentHorizontalAlignment = .fill
        target.backgroundColor = .customWhite
        target.layer.cornerRadius = 20
        target.tintColor = .customBlack
    }
    
    @IBAction func heritageLocationClicked(_ sender: UIButton) {
        defaultLocation()
    }
    
    @IBAction func myLocationClicked(_ sender: UIButton) {
        checkUserLocationServicesAithorization()
    }
    
    //권한 비허용시 기본화면
    func defaultLocation() {
        let latitude = Double(item.latitude)!
        let longitude = Double(item.longitude)!
        var location = CLLocationCoordinate2D()
        let annotation = MKPointAnnotation()
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        
        if latitude == 0.0 && longitude == 0.0 {
            location = CLLocationCoordinate2D(latitude: 37.57606059397734, longitude: 126.9766761117934)
            annotation.title = "위치가 기록되지 않았습니다."
        } else {
            location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.title = item.ccbaMnm1.localized()
        }
        
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
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(region, animated: true)
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
