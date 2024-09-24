//
//  Router.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 12/9/24.
//

import UIKit

protocol Router: AnyObject {
    associatedtype Route
    var navigationController: UINavigationController { get set }
    func exit()
    func process(route: Route)
}

protocol AppRouter: Router where Route == AppTransition { }

