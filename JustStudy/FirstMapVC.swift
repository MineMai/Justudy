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
    var myLocation:CLLocationCoordinate2D?    //把位置給導航用的變數
    var forNavigationLocation:CLLocationCoordinate2D? //把位置給導航用的變數
    var isMoveMap = false
    
    var targetLocation:String? //前一頁傳來的地址
    
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
        
        
        if let location = targetLocation
        {
            print("\(location)")
            findLocation(address: location)
        }
        
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
        myLocation = currentLocation.coordinate
        if isMoveMap {
            
        }
        else
        {
            //moveMap(currentLocation: currentLocation)
            isMoveMap = true
        }
        
    }
    
    func moveMap(currentLocation:CLLocation)
    {
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(currentLocation.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    //MARK: 找出目的地
    func findLocation(address:String)
    {
        let geoCoder = CLGeocoder() //地址轉座標
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            
            if error != nil
            {
                print("xx地址轉座標錯誤: \(String(describing: error?.localizedDescription))")
                return
            }
            else
            {
                //placemarks裡面傳回來的是可能有好幾個位置，所以用陣列表示
                if let coordinate = placemarks?[0].location?.coordinate
                {
                    self.forNavigationLocation = coordinate // 把位置傳給導航用
                    let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake((coordinate.latitude), (coordinate.longitude))
                    let xScale:CLLocationDegrees = 0.01
                    let yScale:CLLocationDegrees = 0.01
                    let span:MKCoordinateSpan = MKCoordinateSpanMake(yScale, xScale)
                    let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                    self.mapView.setRegion(region, animated: true)
                    
                    //加入大頭針
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "活動地點"
                    self.mapView.selectAnnotation(annotation, animated: true) //自動顯示泡泡
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    // MARK: - MKMapViewDelegate Methods  自訂泡泡裡面加東西
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        //檢查是否為使用者位置，是的話就不標
        if annotation is MKUserLocation
        {
            return nil
        }
        let identifier = "Pin" //大頭針識別號
        
        //大頭針回收機制
        var result = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if result == nil
        {
            result = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        
        result?.canShowCallout = true
        result?.image = UIImage(named: "pin_red.png")
        
        
        //right callout accessoryview 泡泡右邊助理按鈕
        let button = UIButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        result?.rightCalloutAccessoryView = button
        
        return result
        
    }
    
    
    //泡泡裡的按鈕，按下會執行的方法
    func buttonTapped(sender:UIButton)
    {
        let alert = UIAlertController(title: "導航", message: "是否進入導航頁面", preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let pA = MKPlacemark(coordinate: self.myLocation!, addressDictionary: nil)
            let pB = MKPlacemark(coordinate: self.forNavigationLocation!, addressDictionary: nil)
            
            let miA = MKMapItem(placemark: pA)
            let miB = MKMapItem(placemark: pB)
            miA.name = "現在位置"
            miB.name = "目的地"
            let routes = [miA, miB]
            let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            MKMapItem.openMaps(with: routes, launchOptions: options)
            
        }
        let cancle = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancle)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    

}
















