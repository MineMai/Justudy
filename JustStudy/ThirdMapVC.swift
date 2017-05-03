//
//  ThirdMapVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/5/3.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ThirdMapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let distance: CLLocationDistance = 800
    let pitch: CGFloat = 65
    let heading = 0.0
    var camera: MKMapCamera?
    
    var location:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mapView.mapType = .hybridFlyover
//        let coordinate = CLLocationCoordinate2D(latitude: 40.7484405,
//                                                longitude: -73.9856644)
//        camera = MKMapCamera(lookingAtCenter: coordinate,
//                             fromDistance: distance,
//                             pitch: pitch,
//                             heading: heading)
//        mapView.camera = camera!
        
//        if let locat = location
//        {
//            print(locat)
//            findLocation(address: locat)
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let locat = location
        {
            print(locat)
            findLocation(address: locat)
        }
    }
    
    
    //MARK: 找出目的地
    func findLocation(address:String)
    {
        mapView.mapType = .hybridFlyover
//        let geoCoder = CLGeocoder() //地址轉座標
//        geoCoder.geocodeAddressString(address) { (placemarks, error) in
//            
//            if error != nil
//            {
//                print("地址轉座標錯誤: \(String(describing: error?.localizedDescription))")
//                return
//            }
//            else
//            {
//                //35.710428, 139.810764
//                //placemarks裡面傳回來的是可能有好幾個位置，所以用陣列表示
//                if let coordinate = placemarks?[0].location?.coordinate
//                {
//                    print(coordinate.latitude)
//                    print(coordinate.longitude)
//                    let coordinate = CLLocationCoordinate2D(latitude: 35.710428,longitude: 139.810764)
//                    self.camera = MKMapCamera(lookingAtCenter: coordinate,
//                                         fromDistance: self.distance,
//                                         pitch: self.pitch,
//                                         heading: self.heading)
//                    self.mapView.camera = self.camera!
//                    
//                }
//            }
//        }
        
        let coordinate = CLLocationCoordinate2D(latitude: 35.710294,longitude: 139.810726)
        camera = MKMapCamera(lookingAtCenter: coordinate,
                                  fromDistance: distance,
                                  pitch: pitch,
                                  heading: heading)
        mapView.camera = camera!
    }

    

}
















