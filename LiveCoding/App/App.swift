//
//  App.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 12/9/24.
//

import UIKit

final class App {
    var navigationController = UINavigationController()
}

extension App: Coordinator {
    func start() {
        process(route: .showMainScreen)
    }
}

extension App: AppRouter {

    func exit() {
        process(route: .showMainScreen)
    }

    func process(route: AppTransition) {
        let coordinator = route.coordinatorFor(router: self)

        coordinator.start()

        print(route.identifier)
    }
}
