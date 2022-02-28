import UIKit
import MapKit
import CoreLocation
import RealmSwift
import SnapKit

class MapViewController: BaseViewController {
    let mainView = MapView()
    var viewModel = ListViewModel()
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    var locationManager = CLLocationManager()
        
    let stockCodeInformation = StockCodeInformation()
    let cityInformation = CityInformation()
    
    var runTimeInterval: TimeInterval?
    let mTimer: Selector = #selector(Tick_TimeConsole)
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "지도".lowercased()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "MapoFlowerIsland", size: 18)!]
        
        setMapView()
        createPickerView()
        
        mainView.userLocationButton.addTarget(self, action: #selector(myLocationClicked), for: .touchUpInside)
        mainView.filterButton.addTarget(self, action: #selector(filterButtonClicked), for: .touchUpInside)
    }
    
    override func addChild(_ childController: UIViewController) {
        
    }
    
    func setAddChild(){
        let child = AnnotaionViewController()
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    
    
    
    
    func setMapView(){
        mainView.mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mainView.mapView.showsUserLocation = true
        Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: mTimer, userInfo: nil, repeats: true)
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
                
        // 피커뷰 확인 취소 버튼 세팅
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let btnDone = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(onPickDone(_:)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let btnCancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(onPickCancel))
        toolBar.setItems([btnCancel , space , btnDone], animated: true)
        toolBar.isUserInteractionEnabled = true
            
        // 텍스트필드 입력 수단 연결
        mainView.textField.inputView = pickerView
        mainView.textField.inputAccessoryView = toolBar
    }
     
    @objc func onPickDone(_ sender: UIDatePicker) {
        filerAnnotations()
        mainView.textField.resignFirstResponder()
    }
    @objc func onPickCancel() {
        mainView.textField.resignFirstResponder()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        filerAnnotations()
    }
    
    @objc func myLocationClicked() {
        checkUserLocationServicesAithorization()
    }
    
    @objc func filterButtonClicked() {
        mainView.textField.becomeFirstResponder()
    }
    
    // MARK: - Conditional code cleanup required
    func filerAnnotations(){
        //MapPin Filter
        if viewModel.cityCode.value != "00" && viewModel.stockCode.value != 0 {
            let firstTesk =  localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(viewModel.stockCode.value)'")
            tasks = firstTesk.filter("ccbaCtcd='\(viewModel.cityCode.value)'")
        } else if viewModel.cityCode.value == "00" && viewModel.stockCode.value != 0 {
            tasks = localRealm.objects(Heritage_List.self).filter("ccbaKdcd='\(viewModel.stockCode.value)'")
        } else if viewModel.cityCode.value != "00" && viewModel.stockCode.value == 0 {
            tasks = localRealm.objects(Heritage_List.self).filter("ccbaCtcd='\(viewModel.cityCode.value)'")
        }
        
        let annotiations = mainView.mapView.annotations
        mainView.mapView.removeAnnotations(annotiations)
        
        for location in tasks {
            let heritageLatitude = Double(location.latitude)!
            let heritageLongitude = Double(location.longitude)!
            
            let heritageCoordinate = CLLocationCoordinate2D(latitude: heritageLatitude, longitude: heritageLongitude)
            let heritageAnnotaion = MKPointAnnotation()
            
            heritageAnnotaion.title = location.ccbaMnm1
            heritageAnnotaion.coordinate = heritageCoordinate
            mainView.mapView.addAnnotation(heritageAnnotaion)
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
        mainView.mapView.setRegion(region, animated: true)
        annotation.coordinate = location
        mainView.mapView.addAnnotation(annotation)
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
            let userLocation = mainView.mapView.userLocation
            //현재 위치 기준으로 영역을 설정
            let region = MKCoordinateRegion(center: userLocation.location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            //맵 뷰의 영역을 설정
            mainView.mapView.setRegion(region, animated: true)
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
        mainView.mapView.setRegion(pRegion, animated: true)
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
        let coordinate = mainView.mapView.centerCoordinate
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        // 지정된 위치의 지오 코드 요청
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let pm: CLPlacemark = placemarks?.first {
                let address: String = "\(pm.country ?? "") \(pm.administrativeArea ?? "") \(pm.locality ?? "") \(pm.subLocality ?? "") \(pm.name ?? "")"
                //self.title = address.localized()
            }
        }
        runTimeInterval = nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print(#function)
    }
}

// MARK: PickerViewSetting
extension MapViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return cityInformation.city.count
        } else if component == 1 {
            return stockCodeInformation.stockCode.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(cityInformation.city[row].city)"
        } else if component == 1 {
            return "\(stockCodeInformation.stockCode[row].text)"
        } else {
            return "이 메세지를 봤다면 개발자에게 알려주세요!"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            viewModel.cityCode.value = cityInformation.city[row].code
        } else if component == 1 {
            viewModel.stockCode.value = stockCodeInformation.stockCode[row].code
        } else {
            print("이거 보면 망한거임")
        }
        filerAnnotations()
    }
}
