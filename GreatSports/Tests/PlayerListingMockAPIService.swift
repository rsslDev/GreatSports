//
//  PlayerListingMockAPIService.swift
//  GreatSportsTests
//
//  Created by Russel Dev on 28/07/23.
//

import XCTest
@testable import GreatSports

final class PlayerListingMockAPIService: APIServiceProtocol {
  
    let playersListModel: PlayerObserver<PlayerListResponse?> = PlayerObserver(nil)  //no data  initially
    
func fetchData(urlStr: String, httpMethod: String, params: [String : Any], resultHandler: @escaping (Result<Data?, Error>) -> Void) {
        
        let jsonData = SwiftUtility.loadJson(filename: "PlayersList")
        let decoderObject = JSONDecoder()
        do {
            self.playersListModel.value = try decoderObject.decode(PlayerListResponse.self, from: jsonData)
            resultHandler(.success(jsonData))
        } catch {}
    }

}
