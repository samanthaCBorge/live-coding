//
//  DetailViewModel.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 13/9/24.
//

import UIKit
import Combine

protocol DetailViewRepresentable: ObservableObject {
    var character: PokemonInfo? { get set }
    func loadData()
}

final class DetailViewModel<R: AppRouter> {
    var router: R?

    private var cancellables = Set<AnyCancellable>()
    @Published var character: PokemonInfo?
    private let store: PokemonInfoListStore
    private let pokemon: Pokemon
    
    init(pokemon: Pokemon, store: PokemonInfoListStore = APIManager()) {
        self.store = store
        self.pokemon = pokemon
    }
}

extension DetailViewModel: DetailViewRepresentable {
    func loadData() {
        let recieved = { [weak self] (response: PokemonInfo) -> Void in
            self?.character = response
        }
        
        let completion = { (completion: Subscribers.Completion<Failure>) -> Void in
            switch  completion {
            case .finished:
                break
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        store.readDetail(pokemon: pokemon)
            .sink(receiveCompletion: completion, receiveValue: recieved)
            .store(in: &cancellables)
    }
}

