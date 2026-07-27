//
//  NetworkingManager.swift
//  newP
//
//  Created by Liwei on 2025/12/31.
//

import Foundation
import Combine

class NetworkingManager {
    enum NetWorkingError:LocalizedError {
        case badServerResponse(url:URL)
        case unknow
        var errorDescription : String {
            switch self {
                case .badServerResponse(url: let url): return "badUrl \(url)"
                case .unknow : return "unknow"
            }
        }
    }
    
    static func download(url:URL)->AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleUrlResponse(output: $0, url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,response.statusCode>=200 && response.statusCode < 300 else {
            throw NetWorkingError.badServerResponse(url: url)
        }
        return output.data
    }
}
