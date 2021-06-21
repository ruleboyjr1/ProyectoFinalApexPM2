//
//  LegendDetailViewController.swift
//  ProyectoPM1ApexStats
//
//  Created by MAC on 6/13/21.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class LegendDetailViewController: UIViewController {

    var indice: Int = 0
    
    var tableview: UITableView = UITableView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblLegendName.text = LegendsArray.LegendsList[indice].Nombre
        txtLegendWinsValue.text = String(LegendsArray.LegendsList[indice].Wins)
        txtLegendKillsValue.text = String(LegendsArray.LegendsList[indice].Kills)
        imageLegend.image = GetImageByLegend(LegendsArray.LegendsList[indice].Nombre)
        
        //Añadimos un gesto para poder salir del teclado
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        print(indice)
    }
    
    //Definicion del gesto para desaparecer el teclado
    @objc func handleTap() {
        txtLegendKillsValue.resignFirstResponder()
        txtLegendWinsValue.resignFirstResponder()
    }
    
    @IBOutlet weak var imageLegend: UIImageView!
    
    @IBOutlet weak var lblLegendName: UILabel!
    @IBOutlet weak var lblLegendKills: UILabel!
    
    @IBAction func txtLegendKills(_ sender: Any) {
    }
    @IBOutlet weak var txtLegendKillsValue: UITextField!
    
    @IBOutlet weak var lblLegendWins: UILabel!
    
   
    @IBOutlet weak var txtLegendWinsValue: UITextField!
    @IBAction func txtLegendWins(_ sender: Any) {
    }
    
      func GetImageByLegend(_ LegendName:String) -> UIImage{
          switch LegendName {
          case "Wraith":
              return UIImage(named: "wraith")!
          case "Pathfinder":
              return UIImage(named: "pathfinder")!
           case "Wattson":
                     return UIImage(named: "wattson")!
               case "Bangalore":
                         return UIImage(named: "bangalore")!
               case "Lifeline":
                         return UIImage(named: "lifeline")!
               case "Mirage":
                         return UIImage(named: "mirage")!
              case "Caustic":
                         return UIImage(named: "caustic")!
              case "Gibraltar":
                         return UIImage(named: "gibby")!
              case "Horizon":
                         return UIImage(named: "horizon")!
              case "Valkrye":
                         return UIImage(named: "valkrye")!
           case "Rampart":
                     return UIImage(named: "rampart")!
              case "Fuse":
                         return UIImage(named: "fuse")!
              case "Crypto":
                         return UIImage(named: "crypto")!
              case "Octane":
                         return UIImage(named: "octane")!
              case "Loba":
                         return UIImage(named: "loba")!
              case "Bloodhound":
                         return UIImage(named: "Bloodhound")!
              case "Revenant":
                         return UIImage(named: "revenant")!
          default:
              return UIImage(named: "wraith")!
              
          }
      }
    @IBAction func UpdateLegend(_ sender: Any) {
          var Existe: Bool = false
        var Kills = Int(txtLegendKillsValue.text!)
         var Wins = Int(txtLegendWinsValue.text!)
        
        /*if (Kills == LegendsArray.LegendsList[indice].Kills){
            Kills = nil
        }
        if (Wins == LegendsArray.LegendsList[indice].Wins){
            Wins = nil
        }*/
        let liga = "https://dev-rodolfo.azurewebsites.net/api/TEC_Peticiones?code=q4e9jCWB9g0i2AYtBRaS6ne2IrrKyvYxlhvMvzT92AwbtvUbt253WQ=="
             
                 let json: [String: Any] = [
                     "Method":4,
                     "Data": [
                      "UserID": StaticUserData.globalID,
                      "LegendID": LegendsArray.LegendsList[indice].ID,
                      "Kills": Kills,
                      "Wins": Wins
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
                         let alertaInformativa = UIAlertController(title: "Stats actualizados", message: "Se han actualizado los stats correctamente.", preferredStyle: UIAlertController.Style.alert)
                                     alertaInformativa.addAction(UIAlertAction(title: "tabien", style: .default, handler: { (action: UIAlertAction!) in
                                         alertaInformativa.dismiss(animated: true, completion: nil)
                                     }))
                        self.present(alertaInformativa, animated: true, completion: nil)
                        self.tableview.reloadData()
                        
                     }
                 }.resume()
                 
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
