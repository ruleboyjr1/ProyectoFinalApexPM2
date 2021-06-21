//
//  LegendsTableViewController.swift
//  ProyectoPM1ApexStats
//
//  Created by MAC on 6/12/21.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class LegendsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
   
    @IBAction func refrescar(_ sender: UIRefreshControl) {
        wsObtenerLeyendas()
        self.tableView.refreshControl?.endRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
                  super.viewWillAppear(animated)
                  let btnCerrarSesion = UIBarButtonItem()
                  btnCerrarSesion.title = "Cerrar sesión"
                  navigationController?.navigationBar.topItem?.backBarButtonItem = btnCerrarSesion

        self.navigationController?.navigationBar.barTintColor = UserDefaults.standard.color(forKey: StaticUserData.globalUsername)
        self.tabBarController?.tabBar.backgroundColor = UserDefaults.standard.color(forKey:StaticUserData.globalUsername)
        
        
        
        wsObtenerLeyendas()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LegendsArray.LegendsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LegendCell", for: indexPath) as! LegendsTableViewCell

        // Configure the cell...
        cell.lblLegendsName.text = "Name"
        cell.lblLegendsKills.text = "Kills"
        cell.lblLegendWins.text = "Wins"
        cell.lblLegendNameValue.text = LegendsArray.LegendsList[indexPath.row].Nombre
        cell.lblLegendWinsValue.text = String(LegendsArray.LegendsList[indexPath.row].Wins)
        cell.lblLegendKillsValue.text = String(LegendsArray.LegendsList[indexPath.row].Kills)
        cell.imageLegend.image = GetImageByLegend(LegendsArray.LegendsList[indexPath.row].Nombre)
        //IMAGEN AQUÍ
        return cell
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
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 157
    }
    
    
      func wsObtenerLeyendas()
       {
           var Existe: Bool = false
           let liga = "https://dev-rodolfo.azurewebsites.net/api/TEC_Peticiones?code=q4e9jCWB9g0i2AYtBRaS6ne2IrrKyvYxlhvMvzT92AwbtvUbt253WQ=="
       
           let json: [String: Any] = [
               "Method":5,
               "Data": [
                "UserID": StaticUserData.globalID
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
                LegendsArray.LegendsList.removeAll()
                let usuario = try! JSONSerialization.jsonObject(with: data!, options: [])
                   let res = usuario as! Dictionary<String,Any>
                   let diccionario: Array = res["Content"] as! Array<Any>
                   if (diccionario.count>0){
                    for leyenda in diccionario {
                        var unaLeyenda = leyenda as! [String:Any]
                        var Legend = Legends()
                        Legend.ID = unaLeyenda["ID"] as! Int
                        Legend.Nombre = unaLeyenda["Name"] as! String
                        Legend.Kills = unaLeyenda["Kills"] as! Int
                        Legend.Wins = unaLeyenda["Wins"] as! Int
                        LegendsArray.LegendsList.append(Legend)
                    }
                    self.tableView.reloadData()
                   }
                   else{
                      print("Error en la petición")
                   }
                   print(Existe)
                   
               }
           }.resume()
           
          
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let vista = storyboard?.instantiateViewController(withIdentifier: "vDetalles") as? LegendDetailViewController
        vista?.indice = indexPath.row
        vista?.tableview = tableView
        self.navigationController?.modalPresentationStyle = .fullScreen
        self.present(vista!, animated: true, completion: nil)
    }
  
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
