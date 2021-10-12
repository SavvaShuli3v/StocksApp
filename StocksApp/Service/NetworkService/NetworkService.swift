//
//  NetworkService.swift
//  StocksApp
//
//  Created by Савва Шулятьев on 11.10.2021.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
    func getStock(for ticker: String, completion: @escaping (Result<StockModel?, Error>) -> Void)
    func getStockImage(for ticker: String, from urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func getStock(for ticker: String, completion: @escaping (Result<StockModel?, Error>) -> Void) {
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
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    guard
                        let json = jsonObject as? [[String: Any]],
                        json.count > 0,
                        let symbol = json[0]["symbol"] as? String,
                        let price = json[0]["price"] as? Double,
                        let mktCap = json[0]["mktCap"] as? Int,
                        let lastDiv = json[0]["lastDiv"] as? Double,
                        let range = json[0]["range"] as? String,
                        let changes = json[0]["changes"] as? Double,
                        let companyName = json[0]["companyName"] as? String,
                        let currency = json[0]["currency"] as? String,
                        let exchange = json[0]["exchange"] as? String,
                        let exchangeShortName = json[0]["exchangeShortName"] as? String,
                        let industry = json[0]["industry"] as? String,
                        let website = json[0]["website"] as? String,
                        let description = json[0]["description"] as? String,
                        let sector = json[0]["sector"] as? String,
                        let country = json[0]["country"] as? String,
                        let address = json[0]["address"] as? String,
                        let city = json[0]["city"] as? String,
                        let state = json[0]["state"] as? String,
                        let image = json[0]["image"] as? String,
                        let ipoDate = json[0]["ipoDate"] as? String,
                        let isActivelyTrading = json[0]["isActivelyTrading"] as? Bool
                    else {
                        print("Invalid JSON format")
                        return
                    }
                    
                    let stock = StockModel(symbol: symbol,
                                           price: price,
                                           mktCap: mktCap,
                                           lastDiv: lastDiv,
                                           range: range,
                                           changes: changes,
                                           companyName: companyName,
                                           currency: currency,
                                           exchange: exchange,
                                           exchangeShortName: exchangeShortName,
                                           industry: industry,
                                           website: website,
                                           description: description,
                                           sector: sector,
                                           country: country,
                                           address: address,
                                           city: city,
                                           state: state,
                                           image: image,
                                           ipoDate: ipoDate,
                                           isActivelyTrading: isActivelyTrading)
                    completion(.success(stock))
                    
                } catch {
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
            
            
            //DispatchQueue.main.async() { [weak self] in
//                guard (self?.mainTableView.stocks.count)! - 1 >= check else { return }
//                self?.mainTableView.stocks[check].image = UIImage(data: data)
//                check += 1
//                self?.mainTableView.reloadData()
            //}
        }

    }
    
}

private extension NetworkServiceProtocol {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
