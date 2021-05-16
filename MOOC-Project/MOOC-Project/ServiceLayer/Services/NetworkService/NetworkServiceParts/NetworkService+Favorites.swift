//
//  NetworkService+Favourites.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 05.05.2021.
//

import Foundation

extension NetworkService {
    
    func deleteFromFavorites(id: String, resultHandler: @escaping(NetworkError?) -> Void) {
        let deleteConfigue = RequestFactory.FavouritesRequests.newDeleteFromFavouritesConfigue()
        let headers = ["content-type": "application/json",
                       "Authorization": "Bearer \(RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .accessToken) ?? "NONE")"]
        RootAssembly.coreAssembly.favoritesInteractionRequestSender.send(
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
                            self.deleteFromFavorites(id: id, resultHandler: resultHandler)
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
    
    func getFavoritesCourses(resultHandler: @escaping ([CourseParsedShortDataModel]?, NetworkError?) -> Void) {
        let getConfigue = RequestFactory.FavouritesRequests.getFavoritesConfigue()
        RootAssembly.coreAssembly.favoritesRequestSender.send(
            with: ["content-type": "application/json",
                   "Authorization": "Bearer \(RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .accessToken) ?? "NONE")"],
            with: nil,
            config: getConfigue) { result in
            switch result {
            case .success(let response):
                resultHandler(self.parseCoursesArray(from: response.favouriteCourses), nil)
            case .failure(let error):
                switch error {
                case .badCode(let code):
                    if code == 401 {
                        self.refreshToken(resultHandler: {
                            self.getFavoritesCourses(resultHandler: resultHandler)
                        })
                    } else {
                        resultHandler(nil, error)
                    }
                default:
                    resultHandler(nil, error)
                }
            }
        }
    }
    
    func addToFavorites(id: String, resultHandler: @escaping(NetworkError?) -> Void) {
        let addConfigue = RequestFactory.FavouritesRequests.newAddToFavouritesConfigue()
        let headers = ["content-type": "application/json",
                       "Authorization": "Bearer \(RootAssembly.serviceAssembly.jwtTokenHandler.getToken(tokenType: .accessToken) ?? "NONE")"]
        RootAssembly.coreAssembly.favoritesInteractionRequestSender.send(
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
                            self.addToFavorites(id: id, resultHandler: resultHandler)
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
