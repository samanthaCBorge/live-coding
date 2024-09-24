//
//  MainCoordinator.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 12/9/24.
//

import UIKit
import SwiftUI

final class PrincipalCoordinator<R: AppRouter> {
    private let router: R

    private lazy var primaryViewController: UIViewController = {
        let viewModel = ViewModel<R>()
        viewModel.router = router
        let viewController = UIHostingController(rootView: MainView(viewModel: viewModel))
        return viewController
    }()

    init(router: R) {
        self.router = router
    }
}

extension PrincipalCoordinator: Coordinator {
    func start() {
        router.navigationController.pushViewController(primaryViewController, animated: false)
    }
}
