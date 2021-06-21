//
//  LegendsTableViewCell.swift
//  ProyectoPM1ApexStats
//
//  Created by MAC on 6/13/21.
//  Copyright © 2021 MAC. All rights reserved.
//

import UIKit

class LegendsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet weak var lblLegendsName: UILabel!
    @IBOutlet weak var lblLegendNameValue: UILabel!
    @IBOutlet weak var lblLegendsKills: UILabel!
    @IBOutlet weak var lblLegendKillsValue: UILabel!
    @IBOutlet weak var lblLegendWins: UILabel!
    @IBOutlet weak var lblLegendWinsValue: UILabel!
    @IBOutlet weak var imageLegend: UIImageView!
    
}
