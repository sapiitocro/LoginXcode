//
//  DelitoViewController.swift
//  CounterApp
//
//  Created by Juan Carlos on 3/07/18.
//  Copyright © 2018 Juan Carlos. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import CoreLocation


class DelitoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate ,CLLocationManagerDelegate{
  
    //Se Define url del registro del Web Service
    let URL_USER_REGISTER = "https://integrador-mrpapita.c9users.io/v2/reporte.php"
   // var locationManager = CLLocationManager()
    
    @IBOutlet weak var delito: UITextField!
    @IBOutlet weak var tipodelito: UITextField!
    @IBOutlet weak var altura: UITextField!
    @IBOutlet weak var superior: UITextField!
    @IBOutlet weak var inferior: UITextField!

    @IBOutlet weak var opcional: UITextField!
    @IBOutlet weak var altoViewDescripcion: NSLayoutConstraint!
    
    @IBOutlet weak var posicionDescripcion: NSLayoutConstraint!
    @IBOutlet weak var altoViewDelito: NSLayoutConstraint!
  //  @IBOutlet weak var descripciondelincuente: UITextView!
  //  @IBOutlet weak var descripciondelito: UITextView!
    
    let tipoDelito = ["", "Asalto a transeuntes", "Robo a casas", "Vandalismo","Agresores","Delincuencia juvenil","Consumo de drogas","Otros"]
    @IBOutlet weak var pickerTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        //altoView.constant = -1
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        pickerTextField.inputView = pickerView
        
       
    }
    let locationManager = CLLocationManager()

    let manager = CLLocationManager()
    let locationss = CLLocation()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
       // let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        print("---------------------------------------------------------Mi nueva Latitud")
        print(myLocation.latitude)
      //  let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
     //   map.setRegion(region, animated: true)
        let defaults = UserDefaults.standard
        defaults.set(myLocation.latitude,     forKey: "latitud")
        defaults.set(myLocation.longitude,      forKey: "longitud")
        defaults.synchronize()
       // self.map.showsUserLocation = true
    }
    
    
    @IBOutlet weak var Delincuen: UIView!
    
    @IBAction func nextPage(_ sender: Any) {
   //     altoViewDescripcion.constant = 350
    //    altoViewDelito.constant = 0
        altoViewDescripcion.constant = 350
        altoViewDelito.constant = 0
        UIView.animate(withDuration: 0.7, animations: {self.view.layoutIfNeeded()})
       // posicionDescripcion.constant = 500
    }
    @IBAction func atrasPage(_ sender: Any) {
        altoViewDescripcion.constant = 0
        altoViewDelito.constant = 350
        UIView.animate(withDuration: 0.7, animations: {self.view.layoutIfNeeded()})

    }
    
    @IBAction func crearReporte(_ sender: Any) {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        print(dateFormatter.string(from: date))
        
        var descripciondelin = "Altura: "
        descripciondelin.append(altura.text!)
        descripciondelin.append("| Vestimenta Superior: ")
        descripciondelin.append(superior.text!)
        descripciondelin.append("| Vestimenta Inferior: ")
        descripciondelin.append(inferior.text!)
        descripciondelin.append("| Datos Opcionales: ")
        descripciondelin.append(opcional.text!)
        print("-----------------------------")
        print(descripciondelin)
        print("-----------------------------")
        
        var locationManager = CLLocationManager()
        
        var ubicacion:CLLocation!
        
        
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                
                locationManager.requestWhenInUseAuthorization()
            }
            ubicacion = locationManager.location
            let defaults = UserDefaults.standard
            defaults.set(ubicacion.coordinate.latitude,     forKey: "latitud")
            defaults.set(ubicacion.coordinate.longitude,      forKey: "longitud")
            defaults.synchronize()
            
        }
        
        
  
        
        
        let userID = UserDefaults.standard.string(forKey: "userid") as! String
        let latitudz = UserDefaults.standard.string(forKey: "latitud") as! String
        let longitudz = UserDefaults.standard.string(forKey: "longitud") as! String
        let parameters: Parameters=[
            "id_user": userID,
            "delito":delito.text!,
            "tipodelito":tipodelito.text!,
            "descripciondelito": "hvv",
            "descripciondelincuente":descripciondelin,
            "fecha": dateFormatter.string(from: date) as! String,
            "latitud":latitudz,
            "longitud":longitudz,
          
        ]
   //     print(parameters)
        //Enviar mensjae por el post
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //Imprimir respuesta
                print(response)
                print(parameters)
                //Obtener json del servidor
                if let result = response.result.value {
                    
                    //Convertir en NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    
                    //mostrar mensaje en un alert
                    let alert = UIAlertController(title: "Mensaje", message: jsonData.value(forKey: "message") as! String?, preferredStyle: UIAlertControllerStyle.alert)
                    
                    
                    
                    
                    //Verifica si un reporte fue creado correctamente
                    if jsonData.value(forKey: "message") as! String? == "Reporte creado Correctamente"{
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        //cambia al viewController
                        let listaViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListaViewController") as! ListaViewController
                        self.navigationController?.pushViewController(listaViewController, animated: true)
                        print("correcto")
                        //Muestra el mensaje
                        self.present(alert, animated: true, completion: nil)
                    }else {
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                    
                    
                    
                }
        }
    }
    
    @IBAction func cancelarButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipoDelito.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipoDelito[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = tipoDelito[row]
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
