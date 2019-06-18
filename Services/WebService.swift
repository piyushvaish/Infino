//
//  WebService.swift
//  Infino
//
//  Created by Piyush Vaish on 18/06/19.
//  Copyright © 2019 Piyush Vaish. All rights reserved.
//

import Foundation

class WebService{
    
    func postLoginCredentials(url:URL,parameters:[String:String],completion:@escaping ((LoginResponse)->())){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) else{
            return
        }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response{
                print(response)
            }
            if let data = data{
                do {
                    //let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let login = try JSONDecoder().decode(LoginResponse.self, from: data)
                    completion(login)
                } catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
