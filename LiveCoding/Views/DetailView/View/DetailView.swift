//
//  DetailView.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 13/9/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct DetailView<T>: View where T: DetailViewRepresentable {
    @ObservedObject var viewModel: T
    
    var body: some View {
        VStack(spacing: 18) {
            ZStack {
                WebImage(url: URL(string: viewModel.character?.sprites.frontDefault ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.black).shadow(radius: 10))
                    .shadow(radius: 10)
            }
            .padding(.top, 20)
            .background(Color.clear)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.character?.name ?? "")
                    .fontWeight(.semibold)
                    .padding(.all)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .padding(.all)
            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
}
