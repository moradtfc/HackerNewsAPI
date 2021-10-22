//
//  NetworkManager.swift
//  HackerNewsApp
//
//  Created by Jesus Mora on 20/10/21.
//

import Foundation


class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
        
    func fetchData(){
        
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page"){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { Data, URLResponse, Error in
                if Error == nil {
                    let decoder = JSONDecoder()
                    
                    if let safeData = Data {
                        do {
                           let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch  {
                            print(Error)
                        }
                    }
                    
                }
            }
            task.resume()
        }
        
    }
    
}
