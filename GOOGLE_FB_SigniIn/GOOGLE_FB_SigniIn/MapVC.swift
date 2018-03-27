//
//  MapVC.swift
//  GOOGLE_FB_SigniIn
//
//  Created by Appinventiv Mac on 27/03/18.
//  Copyright © 2018 Appinventiv Mac. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: UIViewController {

    var lat,lng:CLLocationDegrees!
    let locationManager = CLLocationManager()
    var mapView:GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
    override func loadView() {
       
        let camera = GMSCameraPosition.camera(withLatitude: 28.516682, longitude: 77.258041, zoom: 16.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 28.516682, longitude: 77.258041)
        marker.title = "Noida"
        marker.snippet = "India"
        marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.lat = locValue.latitude
        self.lng = locValue.longitude
    }
    

    
}
