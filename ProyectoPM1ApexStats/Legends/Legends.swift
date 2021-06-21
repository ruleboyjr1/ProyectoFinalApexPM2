import Foundation
class Legends {
    
    
    private var _ID: Int = 0
    var ID: Int
    {
        get{return _ID}
        set{_ID = newValue}
    }
    
    private var _Nombre: String = ""
       var Nombre: String
       {
           get{return _Nombre}
           set{_Nombre = newValue}
       }
    
       private var _Kills: Int = 0
        var Kills: Int
        {
            get{return _Kills}
            set{_Kills = newValue}
        }
       private var _Wins: Int = 0
        var Wins: Int
        {
            get{return _Wins}
            set{_Wins = newValue}
        }
}
