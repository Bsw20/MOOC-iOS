//
//  RequestFactory.swift
//  MOOC-Project
//
//  Created by Андрей Самаренко on 24.04.2021.
//

import Foundation

struct RequestFactory {
    struct AuthRequests {
        static func newSignUpConfigue() -> RequestConfig<SignUpParser> {
            return RequestConfig<SignUpParser>(
                request: AuthRequest(type: .signUp),
                parser: SignUpParser())
        }
        
        static func newSignInCofigure() -> RequestConfig<SignInParser> {
            return RequestConfig<SignInParser>(
                request: AuthRequest(type: .signIn),
                parser: SignInParser())
        }
        
        static func newTokenRefreshConfigure() -> RequestConfig<RefreshTokenParser> {
            return RequestConfig<RefreshTokenParser>(
                request: AuthRequest(type: .refreshToken),
                parser: RefreshTokenParser())
        }
        
        static func newLogOutConfigure() -> RequestConfig<LogoutParser> {
            return RequestConfig<LogoutParser>(
                request: AuthRequest(type: .logout),
                parser: LogoutParser())
        }
    }
    
    struct CoursesRequests {
        static func newCoursesConfigue() -> RequestConfig<CoursesParser> {
            return RequestConfig<CoursesParser>(
                request: CoursesRequest(),
                parser: CoursesParser())
        }
        static func newCourseConfigue() -> RequestConfig<CourseParser> {
            return RequestConfig<CourseParser>(
                request: CourseRequest(),
                parser: CourseParser())
        }
        static func mainInfoConfigue() -> RequestConfig<MainInfoResponseParser> {
            return RequestConfig<MainInfoResponseParser>(
                    request: MainInfoRequest(),
                parser: MainInfoResponseParser())
        }
    }
    
    struct CategoriesRequests {
        static func newCategoriesConfigue() -> RequestConfig<CategoriesParser> {
            return RequestConfig<CategoriesParser>(
                request: CategoriesRequest(),
                parser: CategoriesParser())
        }
    }
    
    struct FavouritesRequests {
        
        static func getFavoritesConfigue() -> RequestConfig<FavoriteResponseComplicatedParser> {
            return RequestConfig<FavoriteResponseComplicatedParser>(
                request: FavoriteRequest(type: .get),
                parser: FavoriteResponseComplicatedParser())
        }
        static func newDeleteFromFavouritesConfigue() -> RequestConfig<FavoriteResponseInteractionParser> {
            return RequestConfig<FavoriteResponseInteractionParser>(
                request: FavoriteRequest(type: .delete),
                parser: FavoriteResponseInteractionParser())
        }
        static func newAddToFavouritesConfigue() -> RequestConfig<FavoriteResponseInteractionParser> {
            return RequestConfig<FavoriteResponseInteractionParser>(
                request: FavoriteRequest(type: .post),
                parser: FavoriteResponseInteractionParser())
        }
    }
    
    struct ViewsRequests {
        static func getViewedConfigue() -> RequestConfig<ViewedResponseComplicatedParser> {
            return RequestConfig<ViewedResponseComplicatedParser>(
                request: ViewedRequest(type: .get),
                parser: ViewedResponseComplicatedParser())
        }
        static func newDeleteFromViewedConfigue() -> RequestConfig<ViewedResponseInteractionParser> {
            return RequestConfig<ViewedResponseInteractionParser>(
                request: ViewedRequest(type: .delete),
                parser: ViewedResponseInteractionParser())
        }
        static func newAddToViewedConfigue() -> RequestConfig<ViewedResponseInteractionParser> {
            return RequestConfig<ViewedResponseInteractionParser>(
                request: ViewedRequest(type: .post),
                parser: ViewedResponseInteractionParser())
        }
    }
    
    struct ReviewsRequests {
        static func newGetReviewsForCourseConfigue() -> RequestConfig<ReviewsResponseParser> {
            return RequestConfig<ReviewsResponseParser>(
                request: ReviewsRequest(type: .get),
                parser: ReviewsResponseParser())
        }
        
        static func newDeleteReview() -> RequestConfig<ReviewsIntercationResponseParser> {
            return RequestConfig<ReviewsIntercationResponseParser>(
                request: ReviewsRequest(type: .delete),
                parser: ReviewsIntercationResponseParser())
        }
        
        static func newAddReview() -> RequestConfig<ReviewsIntercationResponseParser> {
            return RequestConfig<ReviewsIntercationResponseParser>(
                request: ReviewsRequest(type: .post),
                parser: ReviewsIntercationResponseParser())
        }
    }
}
