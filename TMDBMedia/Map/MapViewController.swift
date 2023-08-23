//
//  MapViewController.swift
//  TMDBMedia
//
//  Created by JunHwan Kim on 2023/08/23.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    let locationButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "target")
        config.baseForegroundColor = .black
       let button = UIButton(configuration: config)
        return button
    }()
    lazy var filterBarButton: UIBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilteredTheaterAlert))
    
    
    
    let theaterList = TheaterList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButton()
        setMapView()
        setLocationManager()
        checkDeviceAuthorization()
        setLocationButton()
        showAllTheater()
    }
    
    func setBarButton() {
        navigationItem.rightBarButtonItem = filterBarButton
    }
    
    @objc func showFilteredTheaterAlert() {
        let alert = UIAlertController(title: "영화관 선택", message: nil, preferredStyle: .actionSheet)
        for theater in TheaterBrand.allCases {
            let alertAction = UIAlertAction(title: theater.title, style: .default) { _ in
                self.filteredTheater(theater: theater)
            }
            alert.addAction(alertAction)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func showAllTheater() {
        for annotation in theaterList.mapAnnotations {
            addAnnotationAtMapView(coordi: CLLocationCoordinate2D(latitude: annotation.latitude, longitude: annotation.longitude), title: annotation.location)
        }
    }
    
    func filteredTheater(theater: TheaterBrand) {
        if theater == .all {
            showAllTheater()
            return
        }
        mapView.removeAnnotations(mapView.annotations)
        theaterList.mapAnnotations.filter { $0.type == theater }.forEach { filteredTheater in
            addAnnotationAtMapView(coordi: CLLocationCoordinate2D(latitude: filteredTheater.latitude, longitude: filteredTheater.longitude), title: filteredTheater.location)
        }
    }
    
    func setLocationButton() {
        view.addSubview(locationButton)
        locationButton.addTarget(self, action: #selector(checkDeviceAuthorization), for: .touchUpInside)
        locationButton.snp.makeConstraints { make in
            make.bottom.equalTo(mapView.snp.bottom)
            make.trailing.equalTo(mapView.snp.trailing)
            make.height.width.equalTo(70)
        }
    }
    
    func setMapView() {
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setLocationManager() {
        locationManager.delegate = self
    }
    
    @objc func checkDeviceAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                    if #available(iOS 14.0, *) {
                        authorization = self.locationManager.authorizationStatus
                    } else {
                        authorization = CLLocationManager.authorizationStatus()
                    }
                self.checkAuthorizationStatus(authoStatus: authorization)
            } else {
                
            }
        }
    }
    
    func checkAuthorizationStatus(authoStatus: CLAuthorizationStatus) {
        switch authoStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied :
            mapView.setUserTrackingMode(.none, animated: false)
            setRegion(center: CLLocationCoordinate2D(latitude: 37.5176577, longitude: 126.8864088))
            DispatchQueue.main.async {
                self.locationSettingAlert()
            }
        case .authorizedWhenInUse, .authorized, .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.setUserTrackingMode(.follow, animated: true)
        @unknown default:
            print("dafault")
        }
    }
    
    func setRegion(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: true)
    }
    
    func addAnnotationAtMapView(coordi: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = coordi
        
        mapView.addAnnotation(annotation)
    }
    
    func locationSettingAlert() {
        let alertController = UIAlertController(title: "위치 권한을 설정해주세요", message: "현재 위치 권한이 설정되어있지 않습니다. 설정에 들어가서 위치 권한을 설정해주세요.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "설정으로", style: .default) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }

}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceAuthorization()
    }
}
