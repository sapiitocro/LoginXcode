//
//  ViewControllerTableViewCell.swift
//  CounterApp
//
//  Created by Juan Carlos on 3/07/18.
//  Copyright © 2018 Juan Carlos. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var delitoLbl: UILabel!
    @IBOutlet weak var estadoLbl: UILabel!
    var id = ""
    var id_user = ""
    var delito = ""
    var tipo_delito = ""
    var ubicacion = ""
    var latitud = ""
    var longitud = ""
    var descripcion_delito = ""
    var descripcion_delincuente = ""
    var estado = ""
    var fecha_creacion = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData() {
        delitoLbl.text = delito
        estadoLbl.text = estado
    }
    
}

