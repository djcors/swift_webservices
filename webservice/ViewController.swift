//
//  ViewController.swift
//  webservice
//
//  Created by Jonathan on 19/05/15.
//  Copyright (c) 2015 Jonathan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var clima: UILabel!
    var InfoClima:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func accion(sender: AnyObject) {
        LlamaWebService()
        
    }
    
    
    func LlamaWebService(){
        let UrlPath = "http://api.openweathermap.org/data/2.5/weather?q=\(city.text)"+",es&lang=sp"
        let Url = NSURL(string:UrlPath)

        let session =  NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(Url!, completionHandler: {data, response, error -> Void in
            
            if (error != nil){
                println(error.localizedDescription)
            }
            var nsdata:NSData =  NSData(data:data)
            self.recuperarJson(nsdata)
            dispatch_async(dispatch_get_main_queue(), {println(self.InfoClima!); self.clima.text =  self.InfoClima!})


        })
        
        
        
        task.resume()
    
    }
    
    func recuperarJson(nsdata:NSData){
        let jsonCompleto: AnyObject! = NSJSONSerialization.JSONObjectWithData(nsdata, options: NSJSONReadingOptions.MutableContainers, error: nil)
        let Arreglojson = jsonCompleto["weather"]
        
        if let jsonArray =  Arreglojson as? NSArray{
            jsonArray.enumerateObjectsUsingBlock({model, index, stop in
                self.InfoClima = model["description"] as! String
            });
        }
        

    }

    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

