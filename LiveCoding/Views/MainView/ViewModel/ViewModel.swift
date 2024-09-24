//
//  ViewModel.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 12/9/24.
//

import Foundation
import Combine

protocol ViewModelRepresentable: ObservableObject {
    var pokemonList: [Pokemon] { get set }
    func goToCharacter(character: Pokemon)
    func getPokemonList()
}

final class ViewModel<R: AppRouter> {
    var router: R?
    private let store: PokemonInfoStore
    private var cancelables = Set<AnyCancellable>()
    
    @Published var pokemonList = [Pokemon]()
    
    init(APIManager: PokemonInfoStore = APIManager()) {
        store = APIManager
    }
}

extension ViewModel: ViewModelRepresentable {
    func getPokemonList() {
        
        let recieved = { (response: Response) -> Void in
            DispatchQueue.main.async { [unowned self] in
                pokemonList = response.results
            }
        }
        
        let completion = { (completion: Subscribers.Completion<Failure>) -> Void in
            
            switch  completion {
            case .finished:
                break
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        store.readPokemonInfo()
            .sink(receiveCompletion: completion, receiveValue: recieved)
            .store(in: &cancelables)
    }
    
    func goToCharacter(character: Pokemon) {
        router?.process(route: .showDetailView(character: character))
    }
}
