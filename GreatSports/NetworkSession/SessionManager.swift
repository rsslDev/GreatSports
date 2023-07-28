//
//  SessionManager.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

import Foundation

struct NetworkHelperConstants {
   // static let apiKey = ""
    static let baseURL = "https://ios.app99877.com/api/sc/"
    
    static let playerListURL = baseURL + "players"
    static let playerDetailURL = baseURL + "player/details"
    
}

protocol APIServiceProtocol {
    func fetchData(urlStr:String,httpMethod:String, params:[String:Any], resultHandler: @escaping (Result<Data?, Error>) -> Void)
}

class SessionManager:APIServiceProtocol {
    static let shared = SessionManager()
    
    func fetchData(urlStr:String,httpMethod:String, params:[String:Any], resultHandler: @escaping (Result<Data?, Error>) -> Void)  {
        
        guard let urlObject = URL(string:urlStr) else {
            let errorTemp = GSCustomError(title: "url error", description: "", code: 500)
            
            print("issue in url object")
            resultHandler(.failure(errorTemp))
            return
        }
        let request = prepareRequestWithURL(urlObject,httpMethod: httpMethod, parameters: params)
        
        URLSession.shared.dataTask(with: request) { dataObject, responseObj, errorObject in
            
            if let error = errorObject {
                resultHandler(.failure(error))
            } else {
                resultHandler(.success(dataObject))
            }
            
        }.resume()
    }
    
    func prepareRequestWithURL(_ url: URL,httpMethod: String, parameters: Dictionary<String, Any>?) -> URLRequest {
        let request = NSMutableURLRequest()
        request.url = url
        request.httpMethod = httpMethod
        if parameters?.count != 0 {
           // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           // request.addValue("application/json", forHTTPHeaderField: "Accept")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
                
            } catch {
                
            }
            
//            request.HTTPBody = parameters
        }
        return request as URLRequest
    }
}

protocol GSErrorProtocol: LocalizedError {
    var title: String? { get }
    var code: Int { get }
}

struct GSCustomError: GSErrorProtocol {
    
    var title: String?
    var code: Int
    var errorDescription: String? { return _description }
    var failureReason: String? { return _description }
    
    private var _description: String
    
    init(title: String?, description: String, code: Int) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
    }
}

