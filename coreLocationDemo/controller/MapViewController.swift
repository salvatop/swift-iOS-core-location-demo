//
//  MapViewController.swift
//  coreLocationDemo
//
//  Created by salvatore palazzo on 2020-05-25.
//  Copyright © 2020 salvatore palazzo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var getDir: UIButton!
    @IBOutlet weak var inputText: UITextField!
    
    var loc = Location()
    
    //start and stop event related to the map
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        map.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        loc.delegate = self
    }
    
    @IBAction func getDirectionsAction(_ sender: UIButton) {
        let address = inputText.text!
        loc.getAddress(address: address)
    }
}

//MARK: -UIViewControllerExtension
extension UIViewController {
    
    func showLocationIsDisabledPopUp() {
        let allertController = UIAlertController(title: "Location Access Disabled", message: "please enable location", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        allertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Setting", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        allertController.addAction(openAction)
        self.present(allertController, animated: true, completion: nil)
        
    }
}
//MARK: -CLLocationManagerDelegate
extension UIViewController:CLLocationManagerDelegate {
    
    //triggered by location manager update
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        //zoom
        let span = MKCoordinateSpan(latitudeDelta:0.8, longitudeDelta: 0.8)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
  
        
        let pin = MKPointAnnotation()
        pin.coordinate = location
        map.addAnnotation(pin)
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
     if status == .denied {
        showLocationIsDisabledPopUp()
     }
   }
}

//MARK: -MKMapViewDelegate
extension UIViewController:MKMapViewDelegate {
    //render the line on the map between current pos and destination
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
}

//MARK: -MKMapViewDelegateOverlay
extension UIViewController:LocationDelegate {
    func applyOverlay(route: MKRoute) {
        map.addOverlay(route.polyline)
        map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
    }
}


