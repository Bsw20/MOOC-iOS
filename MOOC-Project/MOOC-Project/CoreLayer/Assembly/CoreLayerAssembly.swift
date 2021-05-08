//
//  ICoreLayerAssembly.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 23.04.2021.
//

import Foundation

class CoreLayerAssembly: CoreLayerAssemblyProtocol {
    
    var signUpRequestSender: IRequestSender = SignUpReqestSender(with: .shared)
    var signInRequestSender: IRequestSender = SignInRequestSender(with: .shared)
    var tokenRequestSender: IRequestSender = TokenRequestSender(with: .shared)
    var logOutRequestSender: IRequestSender = LogOutRequestSender(with: .shared)
    var coursesRequestSender: IRequestSender = CoursesRequestSender(with: .shared)
    var categoriesRequestSender: IRequestSender = CategoriesRequestSender(with: .shared)
    var courseRequestSender: IRequestSender  = CourseRequestSender(with: .shared)
    var favoritesInteractionRequestSender: IRequestSender = FavoritesIntercationRequestSender(with: .shared)
    var viewedInteractionRequestSender: IRequestSender = ViewedIntercationRequestSender(with: .shared)
    var reviewsRequestSender: IRequestSender = ReviewsRequestSender(with: .shared)
    var reviewsInteractionRequestSender: IRequestSender = ReviewsInteractionRequestSender(with: .shared)
    var favoritesRequestSender: IRequestSender = FavoritesRequestSender(with: .shared)
    var viewedRequestSender: IRequestSender = ViewedRequestSender(with: .shared)

    var sessionSaveHandler: SessionSaveHandlerProtocol = SessionSaveHandler()
    var informationSaveHandler: InformationSavingHandlerProtocol = InformationSavingHandler()
}
