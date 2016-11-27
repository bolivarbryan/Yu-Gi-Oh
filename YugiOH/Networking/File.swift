//
//  File.swift
//  YugiOH
//
//  Created by Bryan A Bolivar M on 11/26/16.
//  Copyright © 2016 Bolivar. All rights reserved.
//

import Foundation

class Networking: NSObject {
    
    class func listarCartas(completion: ((_ result : [Carta] ) -> Void)?) {
        
        let headers = [
            "x-parse-application-id": "2yhQ99oLz7EmbERqEBf8DYinUVrMhNeazFy7BMEV",
            "x-parse-rest-api-key": "n2SfddjvVflrL7G14SGVcCHyxQt7ihR3qcjSwnCn",
            "cache-control": "no-cache",
            "postman-token": "dd64326e-2788-f551-39c7-62e5a263de39"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.parse.com/1/classes/Carta")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                let datastring = NSString(data: data as? NSData as! Data, encoding: String.Encoding.utf8.rawValue)

                print(mapearTexto(jsonText: datastring as! String))
                
                //transformando diccionario a modelo Carta
                
                let results = mapearTexto(jsonText: datastring as! String).object(forKey: "results")
                
                var cartas = [Carta]()
                
                for cartaDiccionary in (results as! Array<Any>){
                    var canAddCard:Bool = true
                    
    
                    let attack = (cartaDiccionary as! NSDictionary).object(forKey: "Ataque") as? Int
                    let defense = (cartaDiccionary as! NSDictionary).object(forKey: "Defensa") as? Int
                    let details = (cartaDiccionary as! NSDictionary).object(forKey: "Descripcion") as? String
                    let level = (cartaDiccionary as! NSDictionary).object(forKey: "Nivel") as? Int
                    let name = (cartaDiccionary as! NSDictionary).object(forKey: "Nombre") as? String
                    let breed = (cartaDiccionary as! NSDictionary).object(forKey: "Raza") as? String
                    let type = (cartaDiccionary as! NSDictionary).object(forKey: "Tipo") as? String
                    let image = (cartaDiccionary as! NSDictionary).object(forKey: "Imagen") as? String

                    if (validValue(object: attack as AnyObject) == true && validValue(object: defense as AnyObject) == true && validValue(object: details as AnyObject) == true && validValue(object: level as AnyObject) == true && validValue(object: name as AnyObject) == true && validValue(object: breed as AnyObject) == true && validValue(object: type as AnyObject) == true && validValue(object: image as AnyObject) == true ){
                        
                        if breed != nil {
                            if type != nil {
                                if image != nil{
                                    let carta = Carta(nombre: name!, nivel: level!, tipo: type!, imagen: image!, raza: breed!, descripcion: details!, ataque: attack!, defensa: defense!)
                                    cartas.append(carta)
                                }
                            }
                        }
                        
                       
                    }
                    
                    
                }
                completion!(cartas)
            }
        })
        
        dataTask.resume()
    }
    
    class func validValue(object: AnyObject) -> Bool
    {
        if object == nil {
            return false
        }else{
            return true
        }
    }
    
    class func mapearTexto(jsonText: String) -> NSDictionary {
        
        var dictonary:NSDictionary?
        
        if let data = jsonText.data(using: String.Encoding.utf8) {
            
            do {
                dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                
                if let myDictionary = dictonary
                {
                    return myDictionary
                }
            } catch let error as NSError {
                print(error)
                return [:]
            }
        }else{
            return [:]
        }
        return [:]
    }

}



