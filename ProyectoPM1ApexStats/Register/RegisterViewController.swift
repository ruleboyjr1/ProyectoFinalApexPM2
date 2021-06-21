//
//  RegisterViewController.swift
//  ProyectoPM1ApexStats
//
//  Created by MAC on 6/12/21.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblRegister.text = "Registro"
        
        //Añadimos un gesto para poder salir del teclado
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        txtName.resignFirstResponder()
        txtUser.resignFirstResponder()
        txtPassword.resignFirstResponder()
        txtPasswordConfirmation.resignFirstResponder()
    }
    
    //Outlets
    @IBOutlet weak var lblRegister: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPasswordConfirmation: UITextField!
    
    //Accion para validar el registro
    @IBAction func btnRegistrar(_ sender: UIButton) {
        var strName, strUser, strPassword, strPasswordConfirmation : String
        
        //Obtencion de datos
        strName = txtName.text!
        strUser = txtUser.text!
        strPassword = txtPassword.text!
        strPasswordConfirmation = txtPasswordConfirmation.text!
         if(strPassword == "" || strUser == ""){
                   print("Error")
             let alertaInformativa = UIAlertController(title: "Fallo de registro", message: "No deje campos vacíos", preferredStyle: UIAlertController.Style.alert)
                       alertaInformativa.addAction(UIAlertAction(title: "tabien", style: .destructive, handler: { (action: UIAlertAction!) in
                           
                           alertaInformativa.dismiss(animated: true, completion: nil)
                           
                       }))
                       self.present(alertaInformativa, animated: true, completion: nil)
            return
               }
        if strPassword == strPasswordConfirmation {
            //La confirmacion de contraseña es correcta, entonces se verifica que el usuario no exista en la BD
            wsLogin(strName, strUser, strPassword)
            limpiarTodo()
        } else{
            
            //Dialogo informativo
            let alertaInformativa = UIAlertController(title: "Fallo de registro", message: "Las contraseñas no coinciden", preferredStyle: UIAlertController.Style.alert)
            alertaInformativa.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (action: UIAlertAction!) in
                
                alertaInformativa.dismiss(animated: true, completion: nil)
                
            }))
            self.present(alertaInformativa, animated: true, completion: nil)
        }
        
    }
    
    
    func wsRegistrar(_ Name:String, _ Username: String, _ Password:String)
       {
           let liga = "https://dev-rodolfo.azurewebsites.net/api/TEC_Peticiones?code=q4e9jCWB9g0i2AYtBRaS6ne2IrrKyvYxlhvMvzT92AwbtvUbt253WQ=="
       
           let json: [String: Any] = [
               "Method":1,
               "Data": [
                "Name":Name,
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
                print("Usuario registrado correctamente")
                   
               }
           }.resume()
           
          
       }
    
    func wsLogin(_ Name:String ,_ Username: String, _ Password:String)
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
                                   //Si ya existe
                        self.UsuarioExistente()
                                     }
                   }
                   else{
                     //Si no existe lo registramos
                    self.wsRegistrar(Name, Username, Password)
                    self.RegistroExistoso(Name, Username)
                   }
                   print(Existe)
                   
               }
           }.resume()
           
          
       }
    
    
    func RegistroExistoso(_ strName:String, _ strUser:String){
         txtName.text = ""
                       txtUser.text = ""
                       txtPassword.text = ""
                       txtPasswordConfirmation.text = ""
                       
                       let alertaInformativa = UIAlertController(title: "¡Registro exitoso!", message: "Bienvenido \(strName)!\nTus recuerda iniciar sesion mediante tu usuario: \(strUser)", preferredStyle: UIAlertController.Style.alert)
                       alertaInformativa.addAction(UIAlertAction(title: "Tabien", style: .default, handler: { (action: UIAlertAction!) in
                           
                           alertaInformativa.dismiss(animated: true, completion: nil)
                           
                       }))
                       self.present(alertaInformativa, animated: true, completion: nil)
                       
                       //Con esto nos movemos de indice en el TabBar
                       self.tabBarController!.selectedIndex = 0    }
    
    
    func UsuarioExistente(){
            let alertaInformativa = UIAlertController(title: "Fallo de registro", message: "Este usuario ya se ha registrado", preferredStyle: UIAlertController.Style.alert)
                    alertaInformativa.addAction(UIAlertAction(title: "Tabien", style: .default, handler: { (action: UIAlertAction!) in
                        
                        alertaInformativa.dismiss(animated: true, completion: nil)
                        
                    }))
                    self.present(alertaInformativa, animated: true, completion: nil)
        
    }
    
    func limpiarTodo(){
        txtName.text = ""
        txtUser.text = ""
        txtPassword.text = ""
        txtPasswordConfirmation.text = ""
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
