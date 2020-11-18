//
//  APIClient.swift
//  DemoApp
//
//  Created by Admin on 12/11/20.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    
    public func getLeaderboardDetails(completion: @escaping (_ status: Bool, _ error: Error?, _ apiResponse: LeadsModel?) -> Void ) {
        let session = URLSession.shared
        guard let url = URL(string: "https://plobalapps.s3-ap-southeast-1.amazonaws.com/dummy-app-data.json") else {
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            do {
                guard let data = data else { return }
                let json = try JSONDecoder().decode(LeadsModel.self, from: data)
                completion(true, nil, json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
                completion(false, error, nil)
            }
        }
        task.resume()
    }
}
