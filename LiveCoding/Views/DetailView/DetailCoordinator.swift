//
//  DetailCoordinator.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 13/9/24.
//

import UIKit
import SwiftUI

final class DetailCoordinator<R: AppRouter> {
    let router: R
    var character: Pokemon
    
    private lazy var primaryViewController: UIViewController = {
        let viewModel = DetailViewModel<R>(pokemon: character)
        viewModel.router = router
        let viewController = UIHostingController(rootView: DetailView(viewModel: viewModel))
        return viewController
    }()
    
    init(character: Pokemon, router: R) {
        self.router = router
        self.character = character
    }
}

extension DetailCoordinator: Coordinator {
    func start() {
        router.navigationController.pushViewController(primaryViewController, animated: true)
    }
}
