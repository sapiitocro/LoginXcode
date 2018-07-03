//
//  RegisterViewController.swift
//  CounterApp
//
//  Created by Juan Carlos on 2/07/18.
//  Copyright © 2018 Juan Carlos. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    //Se Define url del registro del Web Service
    let URL_USER_REGISTER = "https://integrador-mrpapita.c9users.io/v1/register.php"
    
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!


    @IBAction func buttonRegister(_ sender: Any) {
        //Crear parametros para enviar por Post
        let parameters: Parameters=[
            "username":textFieldUsername.text!,
            "password":textFieldPassword.text!,
            "name":textFieldName.text!,
            "email":textFieldEmail.text!,
            "phone":textFieldPhone.text!
        ]
        
        //Enviar mensjae por el post
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //Imprimir respuesta
                print(response)
                
                //Obtener json del servidor
                if let result = response.result.value {
                    
                    //Convertir en NSDictionary
                    let jsonData = result as! NSDictionary
                
                    
                    //mostrar mensaje en un alert
                    let alert = UIAlertController(title: "Mensaje", message: jsonData.value(forKey: "message") as! String?, preferredStyle: UIAlertControllerStyle.alert)
                    
           
                    //Verifica si un usuario fue creado correctamente
                    if jsonData.value(forKey: "message") as! String? == "Usuario creado Correctamente"{
                         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        
                        //cambia al viewController
                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        self.navigationController?.pushViewController(viewController, animated: true)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
