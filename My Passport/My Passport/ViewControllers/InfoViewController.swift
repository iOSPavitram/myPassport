//
//  InfoViewController.swift
//  My Passport
//
//  Created by Pavi on 06/12/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        readAPI()
    }
    
    func readAPI()
    {
        let url = URL(string: "https://lenczes.edumedia.ca/mad9137/final_api/passport/read/?id=")!
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
                    
                }
            } catch let error {
                self.showAlert(message:error.localizedDescription)
            }
        }
        task.resume()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
