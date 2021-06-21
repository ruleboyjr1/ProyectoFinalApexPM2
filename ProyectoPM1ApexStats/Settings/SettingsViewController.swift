//
//  StatsViewController.swift
//  ProyectoPM1ApexStats
//
//  Created by MAC on 6/12/21.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit
import SwiftUI

class SettingsViewController: UIViewController {
    
    //Conexion de Outlets
    @IBOutlet weak var lblColorActual: UILabel!
    @IBOutlet weak var txtContraseña: UITextField!
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnHabilitarContraseña: UIButton!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var arrPreferencias : [User] = []
        
        //Añadimos un gesto para poder salir del teclado
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func ChangePassword(_ sender: UIButton) {
        
        let alertaConfirmatoria = UIAlertController(title: "Mas despacio velocista", message: "¿Estas seguro que deseas cambiar la contraseña?", preferredStyle: .actionSheet)
        alertaConfirmatoria.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: {(action: UIAlertAction!) in
            alertaConfirmatoria.dismiss(animated: true, completion: nil)
            
            var Existe: Bool = false
            var Pass = self.txtPassword.text
            if(Pass == StaticUserData.globalPassword){
                Pass = nil
            }
                   let liga = "https://dev-rodolfo.azurewebsites.net/api/TEC_Peticiones?code=q4e9jCWB9g0i2AYtBRaS6ne2IrrKyvYxlhvMvzT92AwbtvUbt253WQ=="
               
                   let json: [String: Any] = [
                       "Method":3,
                       "Data": [
                        "Username":self.lblUsername.text!,
                        "Password":Pass
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
                            print("Contra cambiada")
                    }
                   }.resume()
            self.MostrarMensaje()
            self.btnHabilitarContraseña.isEnabled = false
            
        }))
        alertaConfirmatoria.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: {(action: UIAlertAction!) in
            alertaConfirmatoria.dismiss(animated: true, completion: nil)
        }))
        self.present(alertaConfirmatoria, animated: true, completion: nil)
        
    }
    
      func MostrarMensaje(){
        let alertaInformativa = UIAlertController(title: "Contraseña actualizada", message: "Se ha cambiado la contraseña.", preferredStyle: UIAlertController.Style.alert)
        alertaInformativa.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { (action: UIAlertAction!) in
            alertaInformativa.dismiss(animated: true, completion: nil)
        }))
        self.present(alertaInformativa, animated: true, completion: nil)
        
    }
    
    
    //Definicion del gesto para desaparecer el teclado
    @objc func handleTap() {
        txtContraseña.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let btnCerrarSesion = UIBarButtonItem()
        btnCerrarSesion.title = "Cerrar sesión"
        navigationController?.navigationBar.topItem?.backBarButtonItem = btnCerrarSesion
        
        lblNombre.text = StaticUserData.globalName
        lblUsername.text = StaticUserData.globalUsername
        txtContraseña.text = StaticUserData.globalPassword
    }
    
    @IBAction func stpColorActual(_ sender: UIStepper) {
        switch sender.value {
        case 0:
            //Color default
            self.tabBarController?.tabBar.backgroundColor = .systemBackground
            self.navigationController?.navigationBar.barTintColor = .systemBackground
            lblColorActual.text = "Predeterminado del sistema"
            break;
        case 1:
            //Color rojo
            self.tabBarController?.tabBar.backgroundColor = .systemRed
            self.navigationController?.navigationBar.barTintColor = .systemRed
            lblColorActual.text = "Temporada 1"
            break;
        case 2:
            //Color azul
            self.tabBarController?.tabBar.backgroundColor = .systemBlue
            self.navigationController?.navigationBar.barTintColor = .systemBlue
            lblColorActual.text = "Temporada 2"
            break;
        case 3:
            //Color morado
            self.tabBarController?.tabBar.backgroundColor = .systemPurple
            self.navigationController?.navigationBar.barTintColor = .systemPurple
            lblColorActual.text = "Temporada 7"
            break;
        case 4:
            //Color naranja
            self.tabBarController?.tabBar.backgroundColor = .systemOrange
            self.navigationController?.navigationBar.barTintColor = .systemOrange
            lblColorActual.text = "Temporada 8"
            break;
        default:
            break;
        }
    }
    
    @IBAction func btnCambiarColor(_ sender: UIButton) { //Guardamos el color de preferencia por usuario
        var colorData: Data?
        var color: UIColor
        let ColorElegido: String = lblColorActual.text!
           switch ColorElegido {
             case "Temporada 1":
                color = .systemRed
             break
             case "Temporada 2":
                color = .systemBlue
             break
             case "Temporada 7":
                color = .systemPurple
             break
             case "Temporada 8":
                color = .systemOrange
             break
             default:
                color = .systemBackground
            
        }
        
      
        UserDefaults.standard.set(color, forKey: lblUsername.text!)
        
      let alertaInformativa = UIAlertController(title: "Color guardado", message: "Se ha guardado su color correctamente.", preferredStyle: UIAlertController.Style.alert)
              alertaInformativa.addAction(UIAlertAction(title: "tabien", style: .default, handler: { (action: UIAlertAction!) in
                  
                  alertaInformativa.dismiss(animated: true, completion: nil)
                  
              }))
         self.present(alertaInformativa, animated: true, completion: nil)
        
    }
    @IBAction func txtHabilitarContraseña(_ sender: UITextField) {
        btnHabilitarContraseña.isEnabled = true
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
