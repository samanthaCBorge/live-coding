//
//  ViewController.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 12/9/24.
//

import SwiftUI

struct MainView<T>: View where T: ViewModelRepresentable {
    @ObservedObject var viewModel: T
    
    var body: some View {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(viewModel.pokemonList, id: \.self) { item in
                        VStack {
                            Text(item.name)
                                .font(.system(size: 18, weight: .medium, design: .monospaced))
                                .padding(.all)
                        }
                        .frame(width: 200, height: 100, alignment: .center)
                        .background(.thinMaterial)
                        .shadow(radius: 5, x: 0, y: 2)
                        .cornerRadius(10)
                        .padding(.all)
                        .onTapGesture {
                            viewModel.goToCharacter(character: item)
                        }
                    }
                }
                .onAppear {
                    viewModel.getPokemonList()
                }
            }
            .padding([.top, .bottom], 0.5)
    }
}
