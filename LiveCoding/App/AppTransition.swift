//
//  AppTransition.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 12/9/24.
//

import Foundation

enum AppTransition {
    case showMainScreen
    case showDetailView(character: Pokemon)

    var identifier: String { "\(self)" }

    func coordinatorFor<R: AppRouter>(router: R) -> Coordinator {
        switch self {
        case .showMainScreen:
            return PrincipalCoordinator(router: router)
        case .showDetailView(let character): return DetailCoordinator(character: character, router: router)
        }
    }
}
