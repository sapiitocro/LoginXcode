//
//  Reporte.swift
//  CounterApp
//
//  Created by Juan Carlos on 3/07/18.
//  Copyright © 2018 Juan Carlos. All rights reserved.
//
import UIKit
class Reportes:Codable {
    let reportes: [Reporte]
    
    init(reportes: [Reporte]) {
        self.reportes=reportes
    }
}       

class Reporte:Codable {
    
   let id: String
   let id_user: Int
   let delito: String
   let tipo_delito: String
   let ubicacion: String
   let latitud: String
   let longitud: String
   let descripcion_delito: String
   let descripcion_delincuente: String
   let estado: String
   let fecha_creacion: String

    
    init(id: String,id_user: Int,delito: String,tipo_delito: String,ubicacion: String,latitud: String,longitud: String,descripcion_delito: String,descripcion_delincuente: String,estado: String,fecha_creacion: String) {
        self.id = id
        self.id_user = id_user
        self.delito = delito
        self.tipo_delito = tipo_delito
        self.ubicacion = ubicacion
        self.latitud = latitud
        self.longitud = longitud
        self.descripcion_delito = descripcion_delito
        self.descripcion_delincuente = descripcion_delincuente
        self.estado = estado
        self.fecha_creacion = fecha_creacion

        
    }
}
