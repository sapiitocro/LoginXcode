//
//  MapViewController.swift
//  CounterApp
//
//  Created by Juan Carlos Salazar Ortega on 4/07/18.
//  Copyright © 2018 Juan Carlos. All rights reserved.
//

import UIKit
//import GoogleMaps
import MapKit
import Alamofire
//import CoreLocation
class customPin: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubtitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubtitle
        self.coordinate = location
    }
    
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    //AIzaSyBaF4u_5YseILYSH55tLg8lDFSXEjLb9b0
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var navigationArray: [Reporte] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        mapView.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = 15.3
            locationManager.delegate = self
         //   locationManager.startUpdatingLocation()
            
        
        } else {
          print("Enciende lo servicion de ubicacion o GPS")
        }
        
      
       // let location1 = CLLocationCoordinate2D(latitude: -12.042562815144823,longitude: -76.95113893530424)
       // let location2 = CLLocationCoordinate2D(latitude: -12.043968836653324,longitude: -76.95406254313048)
       // let location3 = CLLocationCoordinate2D(latitude: -12.043139914415804,longitude: -76.95659991285856)

      //  let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
      //  self.mapView.setRegion(region, animated: true)
 
      //  let pin1 =  customPin(pinTitle: "Prueba1", pinSubtitle: "Esto es un pin", location: location1)
      //  let pin2 =  customPin(pinTitle: "Prueba2", pinSubtitle: "Esto es un pin", location: location2)
      //  let pin3 =  customPin(pinTitle: "Prueba3", pinSubtitle: "Esto es un pin", location: location3)

        
      //  self.mapView.addAnnotation(pin1)
      //  self.mapView.addAnnotation(pin2)
      //  self.mapView.addAnnotation(pin3)
      //  self.mapView.delegate = self
        
        var i = 0
        repeat{
            print("se envio la informacion")
            print(navigationArray.count)
            let lat = (navigationArray[i].latitud as NSString).doubleValue
            let long = (navigationArray[i].longitud as NSString).doubleValue

            let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let pin = customPin(pinTitle: navigationArray[i].delito, pinSubtitle: navigationArray[i].tipo_delito, location: location)
            
            if navigationArray[i].estado == "Aprobado" {
                 self.mapView.addAnnotation(pin)
                print("------------------------------------------Se mostro Pin")
            }
           
            print(navigationArray[i].latitud)
            print(navigationArray[i].longitud)
            print(navigationArray[i].delito)
            i = i + 1
        }while i < navigationArray.count
        self.mapView.delegate = self
    }

    
    @IBAction func navigation(_ sender: Any) {
        print("Se ejecuta a cada rato")
        locationManager.startUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named: "pin")
        annotationView.canShowCallout = true
        return annotationView
    }
    // Mark: CLLocationManager Delegates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009))
        print("--------------- Ubicacion----------------")
        self.mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
 
        
        
    }
    
 
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("No es posible acceder a tu ubicacion")
    }
}
