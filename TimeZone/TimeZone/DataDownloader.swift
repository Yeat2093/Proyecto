//
//  DataDownloader.swift
//  UnixTime
//
//  Created by Facultad de Contaduría y Administración on 29/05/24.
//

import Foundation

struct DataDownloader{
    
    func getTime (completion: @escaping (Tiempo) -> Void){
        
        guard let url = URL(string: "https://worldtimeapi.org/api/timezone/America/Mexico_City") else {
            return
        }
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data,_,_ in
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let tiempo = try decoder.decode(Tiempo.self, from: data)
                completion(tiempo)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
        return
    }
    
    func getTimeCali (completion: @escaping (Tiempo) -> Void){
        
        guard let url = URL(string: "https://worldtimeapi.org/api/timezone/America/Los_Angeles") else {
            return
        }
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data,_,_ in
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let tiempo = try decoder.decode(Tiempo.self, from: data)
                completion(tiempo)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
        return
    }
    
    func getTimeParis (completion: @escaping (Tiempo) -> Void){
        
        guard let url = URL(string: "https://worldtimeapi.org/api/timezone/Europe/Paris") else {
            return
        }
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data,_,_ in
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let tiempo = try decoder.decode(Tiempo.self, from: data)
                completion(tiempo)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
        return
    }
    
    func getTimeMunich (completion: @escaping (Tiempo) -> Void){
        
        guard let url = URL(string: "https://worldtimeapi.org/api/timezone/Europe/Berlin") else {
            return
        }
        
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data,_,_ in
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            
            do {
                let tiempo = try decoder.decode(Tiempo.self, from: data)
                completion(tiempo)
            } catch {
                print(error)
            }
        }
        dataTask.resume()
        return
    }
    
}
