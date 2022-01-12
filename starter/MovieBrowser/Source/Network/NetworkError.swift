//
//  NetworkError.swift
//  MovieBrowser
//
//  Created by Conner Maddalozzo on 01/12/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation


enum NetworkError: Error, Equatable {
    case urlFailure
    case dataFailure
    case statusFailure(Int)
}
