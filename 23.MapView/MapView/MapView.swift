//
//  MapView.swift
//  MapView
//
//  Created by Cain Luo on 2024/1/15.
//

import MapKit
import UIKit
import SwiftUI

struct MapView: UIViewRepresentable {
    typealias UIViewType = UIView
    
    var coordinate2D: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let map = MKMapView(frame: .zero)
        
        map.setRegion(MKCoordinateRegion(center: coordinate2D,
                                         span: MKCoordinateSpan(latitudeDelta: 0.7,
                                                                longitudeDelta: 0.7)),
                      animated: true)
        
        view.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            map.widthAnchor.constraint(equalTo: view.widthAnchor),
            map.heightAnchor.constraint(equalTo: view.heightAnchor),
            map.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            map.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate2D
        map.addAnnotation(pin)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
