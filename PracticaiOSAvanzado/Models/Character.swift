//
//  Character.swift
//  PracticaiOSAvanzado
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import Foundation

struct Character: Decodable {
    let photo: URL
    let id: String
    let favorite: Bool
    let name: String
    let description: String
    var latitud: Double?
    var longitude: Double?
}
