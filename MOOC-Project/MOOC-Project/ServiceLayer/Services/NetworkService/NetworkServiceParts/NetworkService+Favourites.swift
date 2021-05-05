//
//  NetworkService+Favourites.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

extension NetworkService {
    
    func deleteFromFavourites(id: String, resultHandler: @escaping(NetworkError?) -> Void) {
        let deleteConfigue = RequestFactory.FavouritesRequests.newDeleteFromFavouritesConfigue()
        let headers = ["content-type": "application/json",
                       "Authorization": "Bearer \(RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .accessToken) ?? "NONE")"]
        RootAssembly.coreAssembly.favouritesInteractionRequestSender.send(
            with: headers,
            with: ["id": id],
            config: deleteConfigue) { result in
            switch result {
            
            case .success:
                resultHandler(nil)
                
            case .failure(let error):
                switch error {
                case .badCode(let code):
                    if code == 401 {
                        self.refreshToken(resultHandler: {
                            self.deleteFromFavourites(id: id, resultHandler: resultHandler)
                        })
                    } else {
                        resultHandler(error)
                    }
                default:
                    resultHandler(error)
                }
            }
        }
    }
    
    func addToFavourites(id: String, resultHandler: @escaping(NetworkError?) -> Void) {
        let addConfigue = RequestFactory.FavouritesRequests.newAddToFavouritesConfigue()
        let headers = ["content-type": "application/json",
                       "Authorization": "Bearer \(RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .accessToken) ?? "NONE")"]
        RootAssembly.coreAssembly.favouritesInteractionRequestSender.send(
            with: headers,
            with: ["id": id],
            config: addConfigue) { result in
            switch result {
            
            case .success:
                resultHandler(nil)
                
            case .failure(let error):
                switch error {
                case .badCode(let code):
                    if code == 401 {
                        self.refreshToken(resultHandler: {
                            self.addToFavourites(id: id, resultHandler: resultHandler)
                        })
                    } else {
                        resultHandler(error)
                    }
                default:
                    resultHandler(error)
                }
            }
        }
    }
}
