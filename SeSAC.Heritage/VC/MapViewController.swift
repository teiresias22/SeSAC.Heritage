import UIKit
import MapKit
import CoreLocation
import CoreLocationUI
import RealmSwift

class MapViewController: UIViewController {
    @IBOutlet weak var MKMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    
    let localRealm = try! Realm()
    var tasks: Results<Heritage_List>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.MKMapView.showsUserLocation = true
        self.MKMapView.setUserTrackingMode(.follow, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
}
    
/*
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS권한 허용됨")
        case .restricted, .notDetermined:
            print("GPS권한 허용되지 않음")
            DispatchQueue.main.async {
                self.getLocationUsagePermission()
            }
        case .denied:
            print("GPS권한 거부됨")
            DispatchQueue.main.async {
                self.getLocationUsagePermission()
            }
        default: print("GPS Default")
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline
        else {
            print("can't draw polyline")
            return MKOverlayRenderer()
        }
        let renderer = MKPolylineRenderer(polyline: polyLine)
            renderer.strokeColor = .orange
            renderer.lineWidth = 5.0
            renderer.alpha = 1.0

        return renderer
    }
}
*/
