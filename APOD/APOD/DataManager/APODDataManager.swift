//
//  APODDataManager.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 05/02/22.
//

import Foundation

enum NetworkError : Error {
    case invalidURL
    case invalidResponse(URLResponse?)
}

protocol APODDataManagerInputDataSource {
    var date: String? { get }
    var apiKey: String? { get}
    var apodRequestURL: String { get }
}

protocol APODDataManaging {
    func fetchAPODData(_ dataSource: APODDataManagerInputDataSource, callback: @escaping (Result<APODResponseModel, Error>) -> Void)
}

class APODDataManager: APODDataManaging {
    
    func fetchAPODData(_ dataSource: APODDataManagerInputDataSource, callback: @escaping (Result<APODResponseModel, Error>) -> Void) {
        
        var components = URLComponents(string: dataSource.apodRequestURL)
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: dataSource.apiKey),
            URLQueryItem(name: "date", value: dataSource.date)
          ]
        let request = URLRequest(url: (components?.url)!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                if let error = error {
                    callback(.failure(error))
                    return
                }
                return
            }
            
            guard let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    callback(.failure(NetworkError.invalidResponse(response)))
                    return
            }
    
            do {
                let  data = try JSONDecoder().decode(APODResponseModel.self, from: responseData)
                print(responseData.description)
                callback(.success(data))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}
