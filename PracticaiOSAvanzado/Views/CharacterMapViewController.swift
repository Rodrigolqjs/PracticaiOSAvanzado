//
//  CharacterMapViewController.swift
//  PracticaiOSAvanzado
//
//  Created by Rodrigo Latorre on 26/01/23.
//

import UIKit
import MapKit

class CharacterMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let viewModel = CharacterMapViewModel()
    
    var selectedCharacter: Character? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.character = selectedCharacter
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMap()
        viewModel.getCharacterAnnotation { annotation in
            mapView.centerToCoords(location: CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude))
            mapView.addAnnotation(annotation)
        }
    }
    
    func setupMap() {
        mapView.showsUserLocation = true
    }

}
