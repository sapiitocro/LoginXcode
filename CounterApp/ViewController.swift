//
//  ViewController.swift
//  CounterApp
//
//  Created by Juan Carlos on 2/07/18.
//  Copyright © 2018 Juan Carlos. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    let URL_USER_LOGIN = "https://integrador-mrpapita.c9users.io/v1/login.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    //the connected views
    //don't copy instead connect the views using assistant editor
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBAction func buttonLogin(_ sender: Any) {
        
        //getting the username and password
        let parameters: Parameters=[
            "username":textFieldUserName.text!,
            "password":textFieldPassword.text!
        ]
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        //getting user values
                        let userId = user.value(forKey: "id") as! Int
                        let userName = user.value(forKey: "username") as! String
                        let userEmail = user.value(forKey: "email") as! String
                        let userPhone = user.value(forKey: "phone") as! String
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userName, forKey: "username")
                        self.defaultValues.set(userEmail, forKey: "useremail")
                        self.defaultValues.set(userPhone, forKey: "userphone")
                        
                        //switching the screen
                        let listaViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListaViewController") as! ListaViewController
                        self.navigationController?.pushViewController(listaViewController, animated: true)
                        
                        self.dismiss(animated: false, completion: nil)
                    }else{
                        //error message in case of invalid credential
                        //self.labelMessage.text = "Usuario o Contraseña incorrecta"
                        
                        //mostrar mensaje en un alert
                        let alert = UIAlertController(title: "Mensaje", message: "Usuario o Contraseña incorrecta", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        //Muestra el mensaje
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //hiding the navigation button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //if user is already logged in switching to profile screen
        if defaultValues.string(forKey: "username") != nil{
            let listaViewController = self.storyboard?.instantiateViewController(withIdentifier: "ListaViewController") as! ListaViewController
            self.navigationController?.pushViewController(listaViewController, animated: true)
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func RegistrarButton(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

