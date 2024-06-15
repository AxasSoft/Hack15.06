//
//  MainModel.swift
//  Hack15.06
//
//  Created by Сергей Майбродский on 15.06.2024.
//

import Foundation
import PromiseKit

struct MainModel {
    //MARK: get data
    static func getData() -> Promise<[VideoData]> {
        var url: URL = Constants.baseURL
            .appendingPathComponent("/data/")
        url = url.appending("q", value: "1")
        return CoreNetwork.request(method: .GET(url: url))
    }
}


struct VideoData: Codable {
    let heap: Int?
    let frameURL: String?
    let frameNumber, id, personCount: Int?
}
