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
    }
    
    struct CategoriesRequests {
        static func newCategoriesConfigue() -> RequestConfig<CategoriesParser> {
            return RequestConfig<CategoriesParser>(
                    request: CategoriesRequest(),
                    parser: CategoriesParser())
        }
    }
    
}
