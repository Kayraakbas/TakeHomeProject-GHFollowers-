//
//  NetworkManager.swift
//  TakeHomeProject
//
//  Created by Kayra Akbaş on 27.08.2024.
//

import UIKit


class NetworkManager {
    
    
    static let shared = NetworkManager()
    let baseUrl : String = "https://api.github.com"
    let chace = NSCache<NSString, UIImage>()
    
    private init(){}
    
    func getFollowers (username : String, page : Int, completed : @escaping(Result<[Follower], CFError>) -> Void){

        let endpoint = baseUrl + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(CFError.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed (.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    
    func getUserInfo (for username: String, completed : @escaping(Result<User, CFError>) -> Void){

        let endpoint = baseUrl + "/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(CFError.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed (.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage (from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let chaceKey = urlString
        
        if let image = chace.object(forKey: chaceKey as NSString){
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed (nil)
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                    let image = UIImage(data: data) else {
                        completed(nil)
                        return
                    }
            
            self.chace.setObject(image, forKey: chaceKey as NSString)
            
            completed(image)
        }
        
        task.resume()
        
    }
    
}
