//
//  LoginControllerViewController.swift
//  ProyectoPM1ApexStats
//
//  Created by MAC on 6/12/21.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblLogin.text = "Inicio de sesión"
        
        //Añadimos un gesto para poder salir del teclado
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.barTintColor = .systemBackground
    }
    
    @objc func handleTap() {
        txtUser.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }
    
    //Outlets
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    //Funcion para mostrar el TabBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //Aqui iniciamos sesion para ello verificamos el login
    @IBAction func Login(_ sender: UIButton) {
        
        var strUser, strPassword : String
        
        //Asignacion de TextViews a las variables de inicio de sesion
        strUser = txtUser.text!
        strPassword = txtPassword.text!
        if(strPassword == "" || strUser == ""){
            print("Error")
            let alertaInformativa = UIAlertController(title: "Fallo al iniciar sesión", message: "No deje campos vacíos", preferredStyle: UIAlertController.Style.alert)
            alertaInformativa.addAction(UIAlertAction(title: "tabien", style: .destructive, handler: { (action: UIAlertAction!) in
                
                alertaInformativa.dismiss(animated: true, completion: nil)
                
            }))
            self.present(alertaInformativa, animated: true, completion: nil)
            return
        }
        
        wsLogin(strUser, strPassword)
        limpiarTodo()
       
        
    }
    
    func AbrirPantalla(){
         let vista = storyboard?.instantiateViewController(identifier: "viewStats")
                   navigationController?.pushViewController(vista!, animated: true)
                   self.tabBarController?.tabBar.isHidden = true
                    let systemSoundID: SystemSoundID = 1016
                              AudioServicesPlaySystemSound(systemSoundID)
        
    }
    func MostrarMensaje(){
            let alertaInformativa = UIAlertController(title: "Fallo de inicio de sesion", message: "Usuario o contraseña incorrectos.", preferredStyle: UIAlertController.Style.alert)
                alertaInformativa.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (action: UIAlertAction!) in
                    
                    alertaInformativa.dismiss(animated: true, completion: nil)
                    
                    
                }))
                
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                print("Estoy vibrando")
                self.present(alertaInformativa, animated: true, completion: nil)    }
    
    func wsLogin(_ Username: String, _ Password:String)
    {
        var Existe: Bool = false
        let liga = "https://dev-rodolfo.azurewebsites.net/api/TEC_Peticiones?code=q4e9jCWB9g0i2AYtBRaS6ne2IrrKyvYxlhvMvzT92AwbtvUbt253WQ=="
    
        let json: [String: Any] = [
            "Method":2,
            "Data": [
                "Username":Username,
                "Password":Password
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard let url = URL(string: liga) else {return}
        var peticion = URLRequest(url: url)
        peticion.httpMethod = "POST"
        peticion.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        peticion.httpBody = jsonData
   
        URLSession.shared.dataTask(with: peticion){
            (data,response,error) in DispatchQueue.main.async {
               
                //Codigo
                let usuario = try! JSONSerialization.jsonObject(with: data!, options: [])
                let res = usuario as! Dictionary<String,Any>
                let diccionario: Array = res["Content"] as! Array<Any>
                if (diccionario.count>0){
                    let values: Dictionary = diccionario[0] as! [String:Any]
              
                      let ID: Int? = values["ID"] as! Int
                                  let Username:String = values["Username"] as! String
                     let Name:String = values["Name"] as! String
                     let Password:String = values["Password"] as! String
                    if(Username != ""){
                                    StaticUserData.globalID = ID!
                                    StaticUserData.globalName = Name
                                        StaticUserData.globalUsername = Username
                                         StaticUserData.globalPassword = Password
                                        self.AbrirPantalla()
                                  }
                }
                else{
                    self.MostrarMensaje()
                }
                print(Existe)
                
            }
        }.resume()
        
       
    }
    
    func limpiarTodo(){
        txtUser.text = ""
        txtPassword.text = ""
    }
          
          /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
