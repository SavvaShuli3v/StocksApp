//
//  NetworkService.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 11.10.2021.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getStock(for ticker: String, completion: @escaping (Result<NetworkStock?, Error>) -> Void)
    func getStockImage(for ticker: String, from urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func getStock(for ticker: String, completion: @escaping (Result<NetworkStock?, Error>) -> Void) {
        let tocken = Tocken.tockenString
        guard let url = URL(string: "https://financialmodelingprep.com/api/v3/profile/\(ticker)?apikey=\(tocken)") else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data,
               (response as? HTTPURLResponse)?.statusCode == 200 {
                
                do {
                    let model = try JSONDecoder().decode([NetworkStock].self, from: data)
                    completion(.success(model[0]))
                } catch {
                    print(data)
                    print("JSON pasrsing error: " + error.localizedDescription)
                }
            } else {
                print("Network Error")
            }
        }
        dataTask.resume()
    }
    
    func getStockImage(for ticker: String, from urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        print("Download image Started")
        guard let url = URL(string: urlString) else {
            return
        }
        
        getData(from: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download image Finished")
            
            completion(.success(UIImage(data: data)))
        }

    }
    
}

private extension NetworkServiceProtocol {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
