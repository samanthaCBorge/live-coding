//
//  APIManager.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 12/9/24.
//

import UIKit
import Combine

protocol PokemonInfoStore {
    func readPokemonInfo() -> AnyPublisher<Response, Failure>
}

protocol PokemonInfoListStore {
    func readDetail(pokemon: Pokemon) -> AnyPublisher<PokemonInfo, Failure>
}

final class APIManager {
    
    private func request<T>(for stringURL: String) -> AnyPublisher<T, Failure> where T: Codable  {
        return Deferred {
            Future { promise in
                guard let url = URL(string: stringURL) else {
                    promise(.failure(.urlError(URLError(.badURL))))
                    return
                }

                let task = URLSession.shared.dataTask(with: url) { data, _, error in
                    if let error = error {
                        promise(.failure(.unknown(error)))
                        return
                    }

                    guard let data = data else {
                        promise(.failure(.urlError(URLError(.zeroByteResource))))
                        return
                    }

                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        promise(.success(decodedData))
                    } catch {
                        promise(.failure(.urlError(URLError(.cannotDecodeContentData))))
                    }
                }
                task.resume()
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

extension APIManager: PokemonInfoStore {
    
    func readPokemonInfo() -> AnyPublisher<Response, Failure> {
        let stringURL = "https://pokeapi.co/api/v2/pokemon/"
        return request(for: stringURL)
    }
    
}

extension APIManager: PokemonInfoListStore {
    func readDetail(pokemon: Pokemon) -> AnyPublisher<PokemonInfo, Failure> {
        let url = "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)"
        return request(for: url)
    }
}
