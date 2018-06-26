//
//  ExploreViewController.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2018-06-18.
//  Copyright © 2018 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ExploreViewController: UIViewController {

    let exploreProfileSegueID = "ExploreProfileSegue"
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomLocationManager.shared.delegate = self
        
        loadAnnotations()
        centerMapOnLocation(location: kDefaultInitialLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == exploreProfileSegueID {
            let profile = sender as! Profile
            let vc = segue.destination as! ExploreProfileViewController
            vc.currentExploreProfile = profile
        }
    }
}

//MARK:- Helpers
extension ExploreViewController {
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, kMapRegionRadius, kMapRegionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadAnnotations() {
        guard let profiles = RemoteDataManager.shared.profiles else { return }
        
        let annotations = profiles.map({ CustomAnnotation(profile: $0, coordinate: CLLocationCoordinate2D(latitude: ($0.personalDetails?.coordinate.first) ?? 0.0, longitude: ($0.personalDetails?.coordinate.last) ?? 0.0)) })
        mapView.addAnnotations(annotations)
    }
    
}

//MARK:- MKMapViewDelegate
extension ExploreViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let selectedAnnotation = view.annotation as? CustomAnnotation else { return }
        
        let selectedProfile = selectedAnnotation.profile
        self.performSegue(withIdentifier: exploreProfileSegueID, sender: selectedProfile)
    }
}

//MARK:- CLLocationManagerDelegate
extension ExploreViewController: CustomLocationManagerDelegate {
    
    func didUpdate(locations: [CLLocation]) {
//        let userLocation: CLLocation = locations[0] as CLLocation
        
//        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
//        let region = MKCoordinateRegionMakeWithDistance(center, kMapRegionRadius, kMapRegionRadius)
        
    //    mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
//        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
//        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
//        myAnnotation.title = "Current location"
//        mapView.addAnnotation(myAnnotation)
    }

    func didUpdate(authorization status: CLAuthorizationStatus) {
        
    }
    
    func didFail(withError error: Error) {
        AlertView(title: "Location error", message: error.localizedDescription).show()
    }
}
