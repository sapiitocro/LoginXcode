//
//  ListaViewController.swift
//  CounterApp
//
//  Created by Juan Carlos on 2/07/18.
//  Copyright © 2018 Juan Carlos. All rights reserved.
//

import UIKit
import Alamofire

class ListaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var refresh: UIBarButtonItem!
    final let url = URL(string: "https://integrador-mrpapita.c9users.io/v2/reporte.php")
    
    var reportesArray: [Reporte] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelUserName: UILabel!
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    @IBAction func refresh(_ sender: Any) {
        reportesArray.removeAll()
        viewDidLoad()
    }
    
    @IBAction func buttonLogout(_ sender: Any) {
        //removing values from default
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        leadingConstraint.constant = -150
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
        downloadJson()
        tableView.delegate = self
        //hiding back button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "username"){
            //setting the name to label
            labelUserName.text = name
        }else{
            //send back to login view controller
        }
    
    }
    
    @IBOutlet weak var menuView: UIView!
    var menuShowing = false
    @IBAction func openMenu(_ sender: Any) {
        
        if(menuShowing){
            leadingConstraint.constant = -150
        }else{
            leadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        }
        menuShowing = !menuShowing
    }
    
    func downloadJson() {
        print("Llega aqui")
        let url = "https://integrador-mrpapita.c9users.io/v2/reporte.php"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let dictionary = response.result.value as? Dictionary<String, Any> {
                    if let teams = dictionary["teams"] as? Array<Dictionary<String, Any>> {
                        for team in teams {
                            let id = team["id"] as? String ?? ""
                            let id_user = team["id_user"] as? Int
                            let delito = team["delito"] as? String ?? ""
                            let tipo_delito = team["tipo_delito"] as? String ?? ""
                            let ubicacion = team["ubicacion"] as? String ?? ""
                            let latitud = team["latitud"] as? String ?? ""
                            let longitud = team["longitud"] as? String ?? ""
                            let descripcion_delito = team["descripcion_delito"] as? String ?? ""
                            let descripcion_delincuente = team["descripcion_delincuente"] as? String ?? ""
                            let estado = team["estado"] as? String ?? ""
                            let fecha_creacion = team["fecha_creacion"] as? String ?? ""
                            let reporte = Reporte(id: id, id_user: id_user!, delito: delito, tipo_delito: tipo_delito, ubicacion: ubicacion, latitud: latitud, longitud: longitud, descripcion_delito: descripcion_delito, descripcion_delincuente: descripcion_delincuente, estado: estado, fecha_creacion: fecha_creacion)
                            self.reportesArray.append(reporte)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
        ViewControllerTableViewCell
        
         let userID = UserDefaults.standard.string(forKey: "userid") as! String
        cell.delito=reportesArray[indexPath.row].delito
        cell.estado=reportesArray[indexPath.row].estado
        cell.loadData()
        
        let userIDGEmelo = reportesArray[indexPath.row].id_user
        if (userID as NSString).integerValue == userIDGEmelo 
        {
            print("-----------Si es = ---------")
            return cell
        }else{
            cell.delito=""
            cell.estado=""
            cell.loadData()
             print("-----------No es = ---------")
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigationSegue" {
            let mapViewController = segue.destination as! MapViewController
            
            mapViewController.navigationArray = reportesArray
            

        }
    }
}
   

  
    

   
    

