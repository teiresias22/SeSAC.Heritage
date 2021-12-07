import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import RealmSwift

class MapViewController: UIViewController {
    @IBOutlet weak var MKMapView: MKMapView!
    @IBOutlet weak var heritageLocation: UIButton!
    @IBOutlet weak var myLocation: UIButton!
    
    @IBOutlet weak var zoomIn: UIButton!
    @IBOutlet weak var zoomOut: UIButton!
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    
    var item = Heritage_List()
    var items = Heritage_List()
    
    var basicMapLength:CLLocationDistance = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = item.ccbaMnm1.localized()
        
        MKMapView.delegate = self
        locationManager.delegate = self
        
        setTopButton(heritageLocation, "landmark")
        setTopButton(myLocation, "plus")
        
        setZoomButton(zoomIn, "plus")
        setZoomButton(zoomOut, "plus")
        
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
        //checkUserLocationServicesAithorization()
        //startTrakingUserLocation()
    }
    
    func setZoomButton( _ target: UIButton, _ name: String){
        target.setImage(UIImage(named: name), for: .normal)
        target.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        target.contentMode = .scaleToFill
        target.setTitle("", for: .normal)
        target.contentVerticalAlignment = .fill
        target.contentHorizontalAlignment = .fill
        target.backgroundColor = .customWhite
        target.tintColor = .customBlack
        target.layer.borderWidth = 1
        target.layer.borderColor = UIColor.customBlack?.cgColor
    }
    
    @IBAction func zoomInButtonClicked(_ sender: UIButton) {
        basicMapLength = basicMapLength - 150
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func zoomOutButtonClicked(_ sender: UIButton) {
        basicMapLength = basicMapLength + 150
        locationManager.startUpdatingLocation()
    }
    
    //MapSetting
    //위치 권한 허용 확인
    func checkUserLocationServicesAithorization() {
        let authorizationStatus: CLAuthorizationStatus
        authorizationStatus = locationManager.authorizationStatus
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager() //위치확인
            checkLocationAuthorization(authorizationStatus) //권한 확인
        } else {
            showAlert(alertTitle: "위치 서비스", alertMessage: "iOS 위치 서비스를 켜주세요.")
        }
    }
    
    //위치 확인
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //권환 확인
    func checkLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            startTrakingUserLocation() //사용자 위치
        case .notDetermined:
            print("GPS 권한 설정되지 않음")
            setupLocationManager() //위치 확인
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
    
    //권한 비허용시 기본화면
    func defaultLocation() {
        let latitude = Double(item.latitude)!
        let longitude = Double(item.longitude)!
        var location = CLLocationCoordinate2D()
        let annotation = MKPointAnnotation()
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        
        if latitude == 0.0 && longitude == 0.0 {
            location = CLLocationCoordinate2D(latitude: 37.57606059397734, longitude: 126.9766761117934)
            annotation.title = "위치를 불러올수 없습니다."
        } else {
            location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            annotation.title = item.ccbaMnm1.localized()
        }
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        MKMapView.setRegion(region, animated: true)
        annotation.coordinate = location
        MKMapView.addAnnotation(annotation)
    }
    
    //권한 허용시 사용자 위치 업데이트
    func startTrakingUserLocation() {
        MKMapView.showsUserLocation = true //현위치
        centerViewOnUserLocation()
        //locationManager.startUpdatingLocation() //움직일때마다 현위치 업데이트
        previousLocation = getCenterLocation(for: MKMapView)
    }
    
    //현재 위치 반영
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: basicMapLength, longitudinalMeters: basicMapLength)
            MKMapView.setRegion(region, animated: true)
        }
    }
    
    //사용자 위치 가져오기
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    //비허용시 알림창 띄우기
    func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let allTheater = UIAlertAction(title: "확인", style: .cancel) { _ in
        }
        alert.addAction(allTheater)
        present(alert, animated: true)
    }
    
    /*
     realm의 string data들을 가져와서 Double로 만들어서 입력해줘야 하는데 for문은
     //핀정보 지역별 모든 문화재
    func allHeritageAnnotations() {
        let annotiations = MKMapView.annotations
        MKMapView.removeAnnotations(annotiations)
        
        for location in items {
            let latitude = Double(item.latitude)
            let longitude = Double(item.longitude)
            
            let heritageCoordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitudr)
            let heritageAnnotaion = MKPointAnnotation()
            
            heritageAnnotaion.title = location.location
            heritageAnnotaion.coordinate = heritageCoordinate
            MKMapView.addAnnotation(heritageAnnotaion)
        }
    }*/
    
    //핀정보 디테일 페이지의 문화제
    func heritageAnnotations() {
        let annotiations = MKMapView.annotations
        MKMapView.removeAnnotations(annotiations)
        
        let latitude = Double(item.latitude)
        let longitude = Double(item.longitude)
        
        let heritageCoordinate = CLLocationCoordinate2D(latitude: latitude ?? 37.472768797381, longitude: longitude ?? 127.10614430956028)
        let heritageAnnotation = MKPointAnnotation()
        
        heritageAnnotation.title = item.ccbaMnm1
        heritageAnnotation.coordinate = heritageCoordinate
        MKMapView.addAnnotation(heritageAnnotation)
    }
}

extension MapViewController: CLLocationManagerDelegate{
    //사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: basicMapLength, longitudinalMeters: basicMapLength)
        
        MKMapView.setRegion(region, animated: true)
        heritageAnnotations()
    }
    
    //5. 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //7. 앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상채를 알려줌
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
}

extension MapViewController: MKMapViewDelegate {
    //맵 어노테이션 클릭 시 이벤트 핸들링
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Go")
    }
}
