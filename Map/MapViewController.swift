//
//  MapViewController.swift
//  appUIKit
//
//  Created by sysadmin on 25/06/21.
//

import UIKit
import MapKit
import CoreLocation
//The ---MKMapViewDelegate--- protocol defines a set of optional methods that you can use to receive map-related update messages. Because many map operations require the MKMapView class to load data asynchronously, the map view calls these methods to notify your application when specific operations complete. The map view also uses these methods to request annotation and overlay views and to manage interactions with those views.Before releasing an MKMapView object for which you have set a delegate, remember to set that object’s delegate property to nil.
//The ---CLLocationManagerDelegate--- protocol defines the methods used to receive location and heading updates from a CLLocationManager object. Upon receiving a successful location or heading update, you can use the result to update your user interface or perform other actions. If the location or heading could not be determined, you might want to stop updates for a short period of time and try again later. You can use the stopUpdatingLocation, stopMonitoringSignificantLocationChanges, stopUpdatingHeading, stopMonitoringForRegion:, or stopMonitoringVisits methods of CLLocationManager to stop the various location services.The methods of your delegate object are called from the thread in which you started the corresponding location services. That thread must itself have an active run loop, like the one found in your application’s main thread.
//need ViewController to conform to these two delegates (the protocol)
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
        //An MKMapView object provides an embeddable map interface, similar to the one provided by the Maps application. You use this class as-is to display map information and to manipulate the map contents from your application. You can center the map on a given coordinate, specify the size of the area you want to display, and annotate the map with custom information.
     var mapView: MKMapView!
   

    //The CLLocationManager class is the central point for configuring the delivery of location- and heading-related events to your app. You use an instance of this class to establish the parameters that determine when location and heading events should be delivered and to start and stop the actual delivery of those events. You can also use a location manager object to retrieve the most recent location and heading data.
    //create a locationManager property
    var locationManager : CLLocationManager!
    //create another locationManager property
  //  let locationManagerNew = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        createMapView()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        print(CLLocationManager.locationServicesEnabled())
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
           currentLoc = locationManager.location
         //   print(currentLoc)
          // print(currentLoc.coordinate.latitude)
           //print(currentLoc.coordinate.longitude)
        }
        
        //set up locationManager so it can find current location as soon as it's loaded.
        // delegate is the delegate object to receive update events. Self returns the receiver
        self.locationManager.delegate = self
        // Use the second highest level of accuracy
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Requests permission to use location services while the app is in the foreground, we don't want to use location services when the app is in the background
        self.locationManager.requestWhenInUseAuthorization()
        // Starts the generation of updates that report the user's current location
        self.locationManager.startUpdatingLocation()
        // A boolean value indicating whether the map should try to display the user's location
        self.mapView.showsUserLocation = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        // MARK - Location Delegate Methods
    func createMapView()
       {
           mapView = MKMapView()
           
           let leftMargin:CGFloat = 10
           let topMargin:CGFloat = 60
           let mapWidth:CGFloat = view.frame.size.width-20
           let mapHeight:CGFloat = 300
           
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
           
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
           
           // Or, if needed, we can position map in the center of the view
           mapView.center = view.center
           
           view.addSubview(mapView)
       }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get last location of locations that have been passed in (most current)
       // let location = locations.last
       // let location =
     //   print(location)
        print("Hii")
       
        var location = locations.last! as CLLocation
        // For future use
       // print(location!.coordinate.latitude)
//        print(location!.coordinate.longitude)
        var geocoder = CLGeocoder()
        var myLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        geocoder.geocodeAddressString("182, Soundararajan Street Vishal Nagar, Keelkattalai Chennai Tamil Nadu India") {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            print("Lat: \(lat), Lon: \(lon)")
            location = (placemark?.location)!
            
            myLocation = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
            print(location)
            print("MY\(myLocation)")
        
        print("MY loc\(myLocation)")
       
        // Get center of that location, i.e. latitude and longitude from that location variable
        let center =  myLocation
        //  Area for map to zoom to. A smaller number zooms further in. Zooming into user's current location. MKCoordinateRegion is a structure which defines which portion of the map to display; center is the centerpoint of the region displayed. The span defines the horizontal and vertical span representing the amount of map to display. The span also defines the current zoom level used by the map view object. 1 and 1 is the zoom.
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta:0.01, longitudeDelta: 0.01))
        // change currently visible region to that region and animate this change
        self.mapView.setRegion(region, animated: true)
            let newPin = MKPointAnnotation()
            newPin.title = "your location"
            newPin.coordinate = location.coordinate
            //
            self.mapView.addAnnotation(newPin)
          //  self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        //Stop the generation of location updates.
        self.locationManager.stopUpdatingLocation()
    }
    }
    
    
    //Tells the delegate that the location manager was unable to retrieve a location value. Implementation of this method is optional but recommended.The location manager calls this method when it encounters an error trying to get the location or heading data. If the location service is unable to retrieve a location right away, it reports a kCLErrorLocationUnknown error and keeps trying. In such a situation, you can simply ignore the error and wait for a new event. If a heading could not be determined because of strong interference from nearby magnetic fields, this method returns kCLErrorHeadingFailure.If the user denies your application’s use of the location service, this method reports a kCLErrorDenied error. Upon receiving such an error, you should stop the location service.
    
    //manager is the location manager object that was unable to retrieve the location; error is the error object containing the reason the location or heading could not be retrieved.
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print ("Errors: "  + error.localizedDescription)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("Hiii")
            if annotation is MKPointAnnotation {
                let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")

                pinAnnotationView.pinColor = .purple
                pinAnnotationView.isDraggable = true
                pinAnnotationView.canShowCallout = true
                pinAnnotationView.animatesDrop = true

                return pinAnnotationView
            }

            return nil
        }
}
