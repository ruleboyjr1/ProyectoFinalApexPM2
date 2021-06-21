//
//  User.swift
//  ProyectoPM1ApexStats
//
//  Created by MAC on 6/14/21.
//  Copyright © 2021 MAC. All rights reserved.
//

import Foundation

class User {

    private var _Username: String = ""
    var Username: String
    {
        get{return _Username}
        set{_Username = newValue}
    }
    
    private var _Color: String = ""
       var Color: String
       {
           get{return _Color}
           set{_Color = newValue}
       }
}
