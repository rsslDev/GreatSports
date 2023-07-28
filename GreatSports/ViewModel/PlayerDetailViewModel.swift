//
//  PlayerDetailViewModel.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

import Foundation

class PlayerDetailViewModel {
    
    internal let playersDetailModel: PlayerObserver<PlayerDetailResponse?> = PlayerObserver(nil)  //no data  initially
    private let apiService: APIServiceProtocol
    internal var isToShowLoader: PlayerObserver<Bool> = PlayerObserver(false)  //no data  initially

    init(apiService: APIServiceProtocol = SessionManager()) {
        self.apiService = apiService
    }
    
    internal func fetchPlayerDetails(playerSlug:String, complete: @escaping (PlayerObserver<PlayerDetailResponse?>)->() ) {
        isToShowLoader.value = true

        let finalURL = NetworkHelperConstants.playerDetailURL
        
        apiService.fetchData(urlStr:finalURL,httpMethod: "POST", params: ["slug":playerSlug]) {  result in
            self.isToShowLoader.value = false

            switch result {
            case .success(let dataObject):
                do {
                    let decoderObject = JSONDecoder()
                    self.playersDetailModel.value = try decoderObject.decode(PlayerDetailResponse.self, from: dataObject!)
                }
                catch {
                    //print("error--->", errorObject)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            complete(self.playersDetailModel)
            
        }
    }


}
