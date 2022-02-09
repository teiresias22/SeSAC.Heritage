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
    @IBOutlet weak var locationFilter: UIButton!
    
    @IBOutlet weak var conteinerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pinConteinerViewHeight: NSLayoutConstraint!
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    var locationManager = CLLocationManager()
    
    var heightStatus = false
    var city: String?
    var code: Int?
    
    var runTimeInterval: TimeInterval?
    let mTimer: Selector = #selector(Tick_TimeConsole)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 14)!]
        
        setMyLocationButton()
        setFilterButton(heritageFilter, .customYellow!, "종류별")
        setFilterButton(locationFilter, .customBlue!, "지역별")
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: mTimer, userInfo: nil, repeats: true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        filerAnnotations()
    }
    
    //Map Pin Setting
    // MARK: - Conditional code cleanup required
    func filerAnnotations(){
        //case 0 : 필터를 선택하지 않은 경우 > 둘다 nil인 경우
        if code == nil && city == nil {
            tasks = localRealm.objects(Heritage_List.self).filter("ccbaCtcd='11'")
        }
        
        //case 1 : 한종류의 필터만 선택한 경우 > 둘중 하나가 nil인 경우?
        else if code != nil && city == nil {
            if code! == 0 {
                tasks = localRealm.objects(Heritage_List.self).filter("ccbaCtcd='11'")
            } else {
                tasks = localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(code!)'")
            }
        }
        //case 1 : 한종류의 필터만 선택한 경우 > 둘중 하나가 nil인 경우?
        else if code == nil && city != nil {
            if city! == "00" {
                tasks = localRealm.objects(Heritage_List.self).filter("ccbaKdcd='11'")
            } else {
                tasks = localRealm.objects(Heritage_List.self).filter("ccbaCtcd='\(city!)'")
            }
        }
        
        //case 2 : 두종류의 필터를 선택한 경우 > 둘다 nil이 아닌 경우
        else if code != nil && city != nil {
            if code! == 0 && city! == "00" {
                tasks = localRealm.objects(Heritage_List.self)
            } else if code! != 0 && city! == "00" {
                tasks = localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(code!)'")
            } else if code! == 0 && city! != "00" {
                tasks = localRealm.objects(Heritage_List.self).filter("ccbaCtcd='\(city!)'")
            } else {
                let firstTesk =  localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(code!)'")
                tasks = firstTesk.filter("ccbaCtcd='\(city!)'")
            }
        }
        
        let annotiations = mapView.annotations
        mapView.removeAnnotations(annotiations)
        
        for location in tasks {
            let heritageLatitude = Double(location.latitude)!
            let heritageLongitude = Double(location.longitude)!
            
            let heritageCoordinate = CLLocationCoordinate2D(latitude: heritageLatitude, longitude: heritageLongitude)
            let heritageAnnotaion = MKPointAnnotation()
            
            heritageAnnotaion.title = location.ccbaMnm1
            heritageAnnotaion.coordinate = heritageCoordinate
            mapView.addAnnotation(heritageAnnotaion)
        }
    }
    
    //Setting My Location Button
    func setMyLocationButton() {
        myLocation.setImage(UIImage(named: "street"), for: .normal)
        myLocation.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        myLocation.contentMode = .scaleToFill
        myLocation.setTitle("", for: .normal)
        myLocation.contentVerticalAlignment = .fill
        myLocation.contentHorizontalAlignment = .fill
        myLocation.layer.cornerRadius = 20
        myLocation.tintColor = .customBlack
        myLocation.backgroundColor = .customWhite
    }
    
    //Setting Filter Button
    func setFilterButton(_ target: UIButton, _ color: UIColor, _ title: String) {
        target.setTitle(title, for: .normal)
        target.setImage(UIImage(systemName: "text.chevron.right"), for: .normal)
        target.imageEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        target.contentVerticalAlignment = .center
        target.contentHorizontalAlignment = .center
        target.layer.cornerRadius = 20
        target.tintColor = .customBlack
        target.backgroundColor = color
    }
    
    //My Location Button Clicked
    @IBAction func myLocationClicked(_ sender: UIButton) {
        checkUserLocationServicesAithorization()
    }
    
    @IBAction func heritageFilterClicked(_ sender: UIButton) {
        let vc = children.first as! PickerViewController
        vc.filterTag = "heritage"
        setContenierView()
    }
    
    @IBAction func locationFilterClicked(_ sender: UIButton) {
        let vc = children.first as! PickerViewController
        vc.filterTag = "city"
        setContenierView()
    }
    
    func setContenierView() {
        heightStatus = !heightStatus
        conteinerViewHeight.constant = heightStatus ? UIScreen.main.bounds.height * 0.2 : 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
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

// MARK: - CLLocationManagerDelegate
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

// MARK: - MKMapViewDelegate
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(#function)
        pinConteinerViewHeight.constant = UIScreen.main.bounds.height * 0.2
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print(#function)
        pinConteinerViewHeight.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
