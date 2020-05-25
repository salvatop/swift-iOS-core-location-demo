//
//  Location.swift
//  coreLocationDemo
//
//  Created by salvatore palazzo on 2020-05-25.
//  Copyright © 2020 salvatore palazzo. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

protocol LocationDelegate {
    func applyOverlay(route: MKRoute)
}

struct Location {
    var locationManager = CLLocationManager()
    var delegate : LocationDelegate?
    
    func getAddress(address: String) {
         let geoCooder = CLGeocoder()
         geoCooder.geocodeAddressString(address) {
             (placemarks, error) in
             if error != nil {
                 print(error!)
             }
             guard let placemarks = placemarks else {
                 print("location not found!")
                 return
             }
             let location = placemarks.first?.location
             print(location!)
             self.drawMap(destination: location!.coordinate)
         }
     }
    
    func drawMap(destination: CLLocationCoordinate2D){
        let currentCoordinate = (locationManager.location?.coordinate)
        
        let currentPlaceMark = MKPlacemark(coordinate: currentCoordinate!)
        let destinationPlaceMark = MKPlacemark(coordinate: destination)
        
        let currentItem = MKMapItem(placemark: currentPlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlaceMark)
        
        let requestDestination = MKDirections.Request()
        requestDestination.source = currentItem
        requestDestination.destination = destinationItem
        requestDestination.transportType = .automobile
        requestDestination.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: requestDestination)
        
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                print(error)
            }
            return
        }
        let route = response.routes[0]
            self.delegate?.applyOverlay(route: route)
        }
    }
}
