//
//  ViewController.swift
//  TimeZone
//
//  Created by Facultad de Contaduría y Administración on 13/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    let downloader = DataDownloader()
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var CaliTime: UILabel!
    
    @IBOutlet weak var CaliDifference: UILabel!
    
    @IBOutlet weak var ParisTime: UILabel!
    
    @IBOutlet weak var ParisDiffence: UILabel!
    
    @IBOutlet weak var MunichTime: UILabel!
    
    @IBOutlet weak var MunichDiffence: UILabel!
    
    @objc func updateTimeLabels() {
        
        
        
        downloader.getTimeCali { [weak self] tiempo in
            DispatchQueue.main.async {
                self?.CaliTime?.text = tiempo.datetime ?? "No data available"
            }
        }
        
        downloader.getTimeParis { [weak self] tiempo in
            DispatchQueue.main.async {
                self?.ParisTime?.text = tiempo.datetime ?? "No data available"
            }
        }
        
        downloader.getTimeMunich { [weak self] tiempo in
            DispatchQueue.main.async {
                self?.MunichTime?.text = tiempo.datetime ?? "No data available"
            }
        }
    }

    func convertStringToUTC(_ dateString: String) -> String? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withTimeZone]
        if let date = dateFormatter.date(from: dateString) {
            let utcFormatter = DateFormatter()
            utcFormatter.timeZone = TimeZone(identifier: "UTC")
            utcFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return utcFormatter.string(from: date)
        }
        return nil
    }

    @objc func updateDifferenceLabels() {
        downloader.getTime { [weak self] localTime in
            guard let self = self else { return }
            
            self.downloader.getTimeCali { caliTime in
                let differenceHours = self.calculateHourDifference(localTime.datetime, caliTime.datetime)
                DispatchQueue.main.async {
                    self.CaliDifference?.text = "\(differenceHours) horas" ?? "No data available"
                }
            }
            
            self.downloader.getTimeParis { parisTime in
                let differenceHours = self.calculateHourDifference(localTime.datetime, parisTime.datetime)
                DispatchQueue.main.async {
                    self.ParisDiffence?.text = "\(differenceHours) horas" ?? "No data available"
                }
            }
            
            self.downloader.getTimeMunich { munichTime in
                let differenceHours = self.calculateHourDifference(localTime.datetime, munichTime.datetime)
                DispatchQueue.main.async {
                    self.MunichDiffence?.text = "\(differenceHours) horas" ?? "No data available"
                }
            }
        }
    }

    func calculateHourDifference(_ localTimeString: String, _ destinationTimeString: String) -> Int {
        let localDate = ISO8601DateFormatter().date(from: localTimeString) ?? Date()
        let destinationDate = ISO8601DateFormatter().date(from: destinationTimeString) ?? Date()
        
        let calendar = Calendar.current
        let hourDifference = calendar.dateComponents([.hour], from: localDate, to: destinationDate).hour ?? 0
        
        return hourDifference
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateDifferenceLabels()
            updateTimeLabels()
            
            Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateDifferenceLabels), userInfo: nil, repeats: true)
            Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTimeLabels), userInfo: nil, repeats: true)
    }
    

    @IBAction func Boton(_ sender: UIButton) {
        downloader.getTime { [weak self] tiempo in
            DispatchQueue.main.async {
                if let date = self?.convertStringToDate(tiempo.datetime) {
                    let unixTime = Int(date.timeIntervalSince1970)
                    self?.Label.text = "\(unixTime)"
                    
                    let currentTime = Date()
                    let currentUnixTime = Int(currentTime.timeIntervalSince1970)
                    
                    let currentUnixTimeMinuteLess = currentUnixTime - 60
                    
                    let roundedUnixTime = unixTime / 100 // Redondea al minuto más cercano
                    let roundedCurrentUnixTime = currentUnixTime / 100 // Redondea al minuto más cercano
                    let roundedCurrentMinuteLess = currentUnixTimeMinuteLess / 100
                    
                    if roundedUnixTime != roundedCurrentUnixTime && roundedUnixTime != roundedCurrentMinuteLess {
                        let alert = UIAlertController(title: "Error", message: "La fecha del sistema no corresponde con la fecha actual", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self?.present(alert, animated: true, completion: nil)
                    }
                } else {
                    self?.Label.text = "Error al convertir la fecha"
                }
            }
        }
    }
    
    func roundTime(_ time: Int) -> Int {
        return Int(Double(time) / 60.0) * 60 // Redondea al minuto más cercano
    }

    func convertStringToDate(_ dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withTimeZone]
        return dateFormatter.date(from: dateString)
    }


}



