//
//  PlayerDetailsMockAPIService.swift
//  GreatSportsTests
//
//  Created by Russel Dev on 28/07/23.
//

import XCTest
@testable import GreatSports

final class PlayerDetailsMockAPIService: APIServiceProtocol {

    let playerDetailModel: PlayerObserver<PlayerDetailResponse?> = PlayerObserver(nil)  //no data  initially
    
    func fetchData(urlStr: String, httpMethod: String, params: [String : Any], resultHandler: @escaping (Result<Data?, Error>) -> Void) {
        
        let jsonData = SwiftUtility.loadJson(filename: "PlayerDetails")
        let decoderObject = JSONDecoder()
        do {
            self.playerDetailModel.value = try decoderObject.decode(PlayerDetailResponse.self, from: jsonData)
            resultHandler(.success(jsonData))
        } catch {}
    }
}
