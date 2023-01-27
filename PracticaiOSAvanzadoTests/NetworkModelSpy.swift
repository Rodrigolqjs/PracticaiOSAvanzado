//
//  NetworkModelSpy.swift
//  PracticaiOSAvanzadoTests
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import Foundation
@testable import PracticaiOSAvanzado

class NetWorkModelSpy: NetworkModel {

    override func networkLogin(user: String, password: String, completion: ((String?, Error?) -> Void)? = nil) {
        if(user == "test@test.com") {
            completion?("testToken", nil)
            return
        }
        completion?(nil, nil)
    }
    
    override func networkGetLocalizacionHeroe(token: String, id: String, completion: (([CharacterCoords], Error?) -> Void)? = nil) {
        if(token == "testToken") {
            completion?([
                CharacterCoords(
                    latitud: "1.01",
                    longitud: "2.02",
                    id: "123id"
                )
            ], nil)
            return
        }
        completion?([], nil)
    }
}
