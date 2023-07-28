//
//  PlayerListViewModel.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

import Foundation

class PlayerListViewModel {
    
    internal let playersListModel: PlayerObserver<PlayerListResponse?> = PlayerObserver(nil)  //no data  initially
    private let apiService: APIServiceProtocol
    internal var isToShowLoader: PlayerObserver<Bool> = PlayerObserver(false)  //no data  initially

    init(apiService: APIServiceProtocol = SessionManager()) {
        self.apiService = apiService
    }
    
    internal func fetchPlayerList(params:[String:Any], complete: @escaping (PlayerObserver<PlayerListResponse?>)->() ) {
        isToShowLoader.value = true
        
        self.apiService.fetchData(urlStr: NetworkHelperConstants.playerListURL,httpMethod: "GET", params: [:]) { result in
            self.isToShowLoader.value = false
            switch result {
                
            case .success(let dataObject):
                do {
                    let decoderObject = JSONDecoder()
                    self.playersListModel.value = try decoderObject.decode(PlayerListResponse.self, from: dataObject!)
                }
                catch {
                    //print("error--->", errorObject)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            complete(self.playersListModel)
        }
        
    }
}
