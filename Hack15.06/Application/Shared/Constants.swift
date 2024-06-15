//
//  Constants.swift
//  Hack15.06
//
//  Created by Сергей Майбродский on 15.06.2024.
//

import Foundation
import KeychainAccess

struct Constants {
    static let baseURL: URL = URL(string: "http://10.2.0.168:8000")! // test
    static let urlString: String = "http://10.2.0.168:8000" // test
    static let imageUrl: URL = URL(string: "http://10.2.0.168/frames/")! // test

    static let keychain = Keychain(service: "ru.axas.Hack15")
}
