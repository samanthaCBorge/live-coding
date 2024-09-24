//
//  NetworkFailure.swift
//  LiveCoding
//
//  Created by Samantha Cruz on 12/9/24.
//

import Foundation

enum Failure: Error {
    case urlError(URLError)
    case selfIsNil
    case unknown(Error)

    var localizedDescription: String {
        switch self {
        case .urlError(let urlError):
            return urlError.localizedDescription
        case .selfIsNil:
            return "Reference to self was lost"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}


