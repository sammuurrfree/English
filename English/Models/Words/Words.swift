//
//  Words.swift
//  English
//
//  Created by Преподаватель on 08.11.2021.
//

import Foundation
import UIKit
import CoreData

class Words{
    
    private let userDefualts = UserDefaults()
    
    func getUserWord(idWordType: Int, idWordState: Int, count: Int, clouser: @escaping(_ content: [WordModel]?) -> ()){

        let parameters = "{\n  \"idWordType\": \(idWordType),\n  \"idWordState\": \(idWordState),\n  \"count\": \(count)\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://94.228.124.99/api/user/words/\(userDefualts.integer(forKey: "userId"))")!,timeoutInterval: 10)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                return clouser(nil)
            }
            if let httpResponse = response as? HTTPURLResponse{
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300){
                    
                    let content = try? JSONDecoder().decode([WordModel].self, from: data)
                    clouser(content)
                }else{
                    clouser(nil)
                }
            }else{
                clouser(nil)
            }
            
        }.resume()
    }
    
    func getRandomWords(randomWordCunt: Int, clouser: @escaping(_ content: [WordModel]?) -> ()){

        var request = URLRequest(url: URL(string: "http://94.228.124.99/api/words")!,timeoutInterval: 20)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else{
                return clouser(nil)
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300){
                    
                    var array: [WordModel] = []
                    let content = try? JSONDecoder().decode([WordModel].self, from: data)
                    
                    if content != nil {
                        for _ in 0...randomWordCunt{
                            array.append(content!.randomElement()!)
                        }
                    }
                    
                    clouser(array)
                }else{
                    clouser(nil)
                }
            }else{
                clouser(nil)
            }
        }.resume()
    }
    
    func setWord(idWord: Int, idState: Int) -> Bool {
        let semaphore = DispatchSemaphore (value: 0)
        var isStatus = false
        
        let parameters = "{\n  \"idWord\": \(idWord),\n  \"idState\": \(idState)\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://94.228.124.99/api/user/addwords/\(UserDefaults().integer(forKey: "userId"))")!,timeoutInterval: 20)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard data != nil else{
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                if (httpResponse.statusCode >= 200) && (httpResponse.statusCode < 300){
                    isStatus = true
                }
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return isStatus
    }
}
