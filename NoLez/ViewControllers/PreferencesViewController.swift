//
//  PreferencesViewController.swift
//  NoLez
//
//  Created by SATVEER SINGH on 07/08/21.
//

import UIKit
import CoreLocation

protocol DisplayViewControllerDelegate : NSObjectProtocol{
    func doSizeChange(data: CGFloat)
    func doLocationChange(cityloc: String, temperature: String, description: String)
    func changetheme(background: UIColor, textcolor: UIColor)
}


struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}
struct Main: Codable{
    let temp: Double
    
}

struct Weather: Codable {
    let description: String
}
struct theme {
    let textColor  : UIColor
    let backgroundColor :UIColor
    
    static let light = theme(textColor: .black, backgroundColor: .white)
    static let dark = theme(textColor: .white, backgroundColor: .black)
}
class PreferencesViewController: UIViewController, CLLocationManagerDelegate {
    weak var delegate : DisplayViewControllerDelegate?
    
    @IBOutlet weak var darkmode: UILabel!
    @IBOutlet weak var textsizeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
   
    @IBOutlet weak var textsize: UISlider!
    @IBOutlet weak var locationswitch: UISwitch!
    @IBOutlet weak var darkSwitch: UISwitch!
    var manager: CLLocationManager?
    var urlString = ""
    var name: String = ""
    var cityDescription: String = ""
    var cityTemperature: Double = 0.0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func DarkModeFun(_ sender: UISwitch) {
        let currentTheme = darkSwitch.isOn ? theme.dark : theme.light
        
        view.backgroundColor =  currentTheme.backgroundColor
        darkmode.textColor = currentTheme.textColor
        darkmode.backgroundColor = currentTheme.backgroundColor
        textsizeLabel.textColor = currentTheme.textColor
        textsizeLabel.backgroundColor = currentTheme.backgroundColor
        locationLabel.backgroundColor = currentTheme.backgroundColor
        locationLabel.textColor = currentTheme.textColor
        if let delegate = delegate{
            delegate.changetheme(background: currentTheme.backgroundColor, textcolor: currentTheme.textColor)
        }
        
    }
    @IBAction func textslider(_ sender: UISlider) {
        let value = CGFloat(textsize.value)
        darkmode.font = UIFont(name: darkmode.font.fontName, size: value)
        darkmode.sizeToFit()
        textsizeLabel.font = UIFont(name: textsizeLabel.font.fontName, size: value)
        textsizeLabel.sizeToFit()
        locationLabel.font = UIFont(name: locationLabel.font.fontName, size: value)
        locationLabel.sizeToFit()
        if let delegate = delegate{
            delegate.doSizeChange(data: value)
        }
        
    }
    
    
    
    @IBAction func locationSwitch(_ sender: Any) {
        if locationswitch.isOn{
            manager = CLLocationManager()
            manager?.delegate = self
            manager?.desiredAccuracy = kCLLocationAccuracyBest
            manager?.requestWhenInUseAuthorization()
            manager?.startUpdatingLocation()
        }
        else{
            manager?.stopUpdatingLocation()
           
            if let delegate = self.delegate{
                delegate.doLocationChange(cityloc: "", temperature: "", description: "")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        // please select the location from locations option
        urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=3f800a4a6e26e881010fcf0f271e4187&units=metric"
        let urlSession = URLSession(configuration: .default)
        let url = URL(string: urlString)
        if let url = url {
            let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let readableData =   try jsonDecoder.decode(WeatherData.self, from: data)
                        self.name = readableData.name
                        for i in readableData.weather {
                            self.cityDescription = i.description
                        }
                        self.cityTemperature = readableData.main.temp
                        
                        DispatchQueue.main.async {
                      
                            if let delegate = self.delegate{
                                delegate.doLocationChange(cityloc: self.name, temperature: "\(self.cityTemperature) °C", description: self.cityDescription)
                            }
                            
                        }
                    }
                    catch {
                        print(error)
                    }
                }
            }
            dataTask.resume()
        }
    }
}

