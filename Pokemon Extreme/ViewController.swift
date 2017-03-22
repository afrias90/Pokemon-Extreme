//
//  ViewController.swift
//  Pokemon Extreme
//
//  Created by Adolfo Frias on 3/19/17.
//  Copyright © 2017 Adolfo Frias. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    
    var updateCount = 0
    
    var pokemons : [Pokemonster] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemons = getAllPokemon()
        
        manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("Ready to go")
            mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                //spawn a pokemon
                if let coord = self.manager.location?.coordinate {
                let pokemon = MKPointAnnotation()
                pokemon.coordinate = coord
                    
                //half of the values will be less than 100 and give negative values!
                let randoLat = (Double(arc4random_uniform(200)) - 100) / 50000.0
                let randoLon = (Double(arc4random_uniform(200)) - 100) / 50000.0
                pokemon.coordinate.latitude += randoLat
                pokemon.coordinate.longitude += randoLon
                    self.mapView.addAnnotation(pokemon)
                }
                
            })
            
        } else {
            
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if updateCount < 3 {
            
            
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 200, 200)
            mapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
            //helps save battery life - makes sense, ya?
            manager.stopUpdatingLocation()
        }
        
        
        
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coord, 200, 200)
        mapView.setRegion(region, animated: true)
        }
    }
    
}




