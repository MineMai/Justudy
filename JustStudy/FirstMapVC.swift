//
//  FirstMapVC.swift
//  JustStudy
//
//  Created by YenShao on 2017/4/22.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstMapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager() //定位需要用的
    var isMoveMap = false
    
    @IBAction func mapTypeChange(_ sender: UISegmentedControl)
    {
        let index = sender.selectedSegmentIndex
        switch index {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //定位設定
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() //開始執行
        
    }

    // MARK: - CLLocationManagerDelegate Methods
    // 接收傳回的經緯度位置
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentLocation = locations.last else
        {
            print("CurrentLocation is nil")
            return
        }
        //這就是目前使用者位置
        //print(currentLocation.coordinate.latitude) //這就是目前使用者位置
        
        if isMoveMap {
            
        }
        else
        {
            moveMap(currentLocation: currentLocation)
            isMoveMap = true
        }
        
    }
    
    func moveMap(currentLocation:CLLocation)
    {
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(currentLocation.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    

}
















