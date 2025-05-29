//
//  Coordinator.swift
//  TestApplication
//
//  Created by Владимир on 25.05.2025.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
