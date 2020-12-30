//
//  Networking.swift
//  OfferWall
//
//  Created by Ваге Базикян on 29.12.2020.
//

import Foundation

enum RequestBuilder {
    
    case products
    case object(id: Int)
    
    private var base: URL {
        return URL(string: "https://demo0040494.mockable.io/api/v1")!
    }
    
    private var url: URL {
        switch self {
        case .products:
            return base.appendingPathComponent("/trending")
        case .object(id: let id):
            return base.appendingPathComponent("/object/\(id)")
        }
    }
}

extension RequestBuilder {
    func request<T: Decodable> (completion: @escaping(T) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let answer = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(answer)
                    }
                } catch let parseError {
                    print(parseError.localizedDescription)
                }
            }
        }.resume()
    }
}

protocol NetworkngProtocol {
    func getProducts(completion: @escaping([Product]) -> ())
    func getArticle(id: Int, completion: @escaping(Article) -> ())
}

class Networking: NetworkngProtocol {
    
    func getProducts(completion: @escaping ([Product]) -> ()) {
        RequestBuilder.products.request(completion: completion)
    }
    
    func getArticle(id: Int, completion: @escaping (Article) -> ()) {
        RequestBuilder.object(id: id).request(completion: completion)
    }
    
}

