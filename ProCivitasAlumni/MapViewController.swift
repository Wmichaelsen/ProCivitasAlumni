//
//  MapViewController.swift
//  ProCivitasAlumni
//
//  Created by Wilhelm Michaelsen on 2017-09-01.
//  Copyright © 2017 Wilhelm Michaelsen. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    var alumnis = [Alumni]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadData()
        mapView.addAnnotations(alumnis)
    }
    
    //MARK: - Helper Methods
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func loadData() {
        let fileName = Bundle.main.path(forResource: "alumni", ofType: "json");
        let data: Data = NSData(contentsOfFile: fileName!)! as Data
        
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let jsonArray = (jsonObject! as! [String:Any])["data"] {
            if let alumniArray = jsonArray as? [Any] {
                for alumnJson in alumniArray {
                    alumnis.append(Alumni.fromJSON(json: alumnJson as! [String:Any]))
                }
            }
        }
    }
    
    //MARK: - MapView Delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Alumni {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let alumn: Alumni = view.annotation as? Alumni else { return }
        
        self.performSegue(withIdentifier: "toAlumniProfile", sender: alumn)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlumniProfile" {
            let alumniVC: AlumniViewController = segue.destination as! AlumniViewController
            alumniVC.currentAlumni = sender as? Alumni
        }
    }

}
