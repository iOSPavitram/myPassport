//
//  AddViewController.swift
//  My Passport
//
//  Created by Pavi on 06/12/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreLocation

class AddViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationTitle: UITextField!
    @IBOutlet weak var locationDescription: UITextView!
    @IBOutlet weak var arrivalDatePicker: UIDatePicker!
    @IBOutlet weak var departureDatePicker: UIDatePicker!
    
    var locationManager:CLLocationManager! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        // 2. authorization were denied
        else if CLLocationManager.authorizationStatus() == .denied {
            showAlert(message:"Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // 3. we do have authorization
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    

    @IBAction func save(_ sender: Any) {
        if (locationTitle.text?.count)! < 0
        {
            showAlert(message:"Please enter the title.")
        }
        else if locationDescription.text.count < 0
        {
            showAlert(message:"Please enter description.")
        }
        else
        {

            let jsonObject:Dictionary = ["uid":39,"title":locationTitle.text ?? "default title","description":locationDescription.text,"latitude":            locationManager.location?.coordinate.latitude ?? 0.0,"longitude":locationManager.location?.coordinate.longitude ?? 0.0,"arrival":Utilities.convertDate(arrivalDatePicker.date),"departure":Utilities.convertDate(departureDatePicker.date)] as [String : Any]
            let jsonString = Utilities.JSONStringify(value:jsonObject as AnyObject, prettyPrinted: false)
            print(jsonString)
            readAPI(data:jsonString)
        }
    }
    
    func showAlert(message:String)
    {
        let alert = UIAlertController.init(title:"My Passport", message:message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title:"OK", style: .default) { (action) in
            alert.dismiss(animated:true, completion:nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated:true, completion:nil)
    }
    

    func readAPI(data:String)
    {
        let url = URL(string: "http://lenczes.edumedia.ca/mad9137/final_api/passport/create/?data=\(data.stringByAddingPercentEncodingForRFC3986())")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with:request) { (data, response, error) in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error!.localizedDescription))")
                self.showAlert(message:error!.localizedDescription)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print(response!)
            }
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                {
                    print(json)
                   
                    DispatchQueue.main.async {
                        
                    }
                    
                }
            } catch let error {
                self.showAlert(message:error.localizedDescription)
            }
        }
        task.resume()
    }
}
