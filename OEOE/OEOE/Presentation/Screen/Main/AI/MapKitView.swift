//
//  MapKitView.swift
//  OEOE
//
//  Created by 송우진 on 4/19/25.
//

import SwiftUI
import MapKit

struct MapKitView: UIViewRepresentable {
    @Binding var selectedCoordinate: CLLocationCoordinate2D?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let gesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(gesture)
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)

        if let coord = selectedCoordinate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            uiView.addAnnotation(annotation)
            uiView.setCenter(coord, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapKitView

        init(_ parent: MapKitView) {
            self.parent = parent
        }

        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            let mapView = gesture.view as! MKMapView
            let point = gesture.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            parent.selectedCoordinate = coordinate
        }
    }
}
