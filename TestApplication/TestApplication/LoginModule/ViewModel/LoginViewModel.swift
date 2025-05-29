//
//  LoginViewModel.swift
//  TestApplication
//
//  Created by Владимир on 26.05.2025.
//

import Foundation

final class LoginViewModel {
    var output: LoginFlow?
    
    func login() {
        output?.login()
    }
}
