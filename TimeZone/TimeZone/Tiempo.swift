//
//  Tiempo.swift
//  UnixTime
//
//  Created by Facultad de Contaduría y Administración on 29/05/24.
//

import Foundation
    
struct Tiempo: Codable{
    
    var abbreviation: String
    var client_ip: String 
    var datetime: String
    var day_of_week: Int
    var day_of_year: Int
    var dst: Bool
    var dst_from: String?
    var dst_offset: Double
    var dst_until: String?
    var raw_offset: Double
    var timezone: String
    var unixtime: Double
    var utc_datetime: String
    var utc_offset: String
    var week_number: Int
}
