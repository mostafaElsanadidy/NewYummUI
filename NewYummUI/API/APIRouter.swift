//
//  APIRouter.swift
//  MadeInKuwait
//
//  Created by mostafa elsanadidy on 1/29/22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//


import Alamofire

enum APIRouter: URLRequestConvertible {
    
//    case top_ratedMovies
//    case popularMovies
//    case upcomingMovies
//    case now_playingMovies
    case getWorkouts
    case getMovieDetails(movieID:Int)
    case getMovieRecommendations(movieID:Int)
    case getMovieCasts(movieID:Int)
    case getMovieReviews(movieID:Int)
    case getMovieVideos(movieID:Int)
    case searchMovies(query:String)
    case getMoviesGenres
//    /movie?api_key=18f1dd9d9a6779af535c45513bd22779&query=The%20Avengers
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
//            el vend details fel post man get request w hena maktop .post ?
        case .getMovies , .getMovieDetails, .getMovieRecommendations , .getMovieCasts , .getMovieVideos , .getMovieReviews , .searchMovies, .getMoviesGenres:
            return .get
            
        }
    }
    
    private var api_key:String{
        return Constants.ProductionServer.api_key
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
//        case .top_ratedMovies: return "/movie/top_rated?api_key=\(api_key)"
//        case .popularMovies: return "/movie/popular?api_key=\(api_key)"
//        case .upcomingMovies: return "/movie/upcoming?api_key=\(api_key)"
//        case .now_playingMovies: return "/movie/now_playing?api_key=\(api_key)"
        case .getWorkouts: return "/workouts"
        case .getMovieDetails(let movieID): return
            "/movie/\(movieID)?api_key=\(api_key)"
        case .getMovieRecommendations(let movieID): return
            "/movie/\(movieID)/recommendations?api_key=\(api_key)"
        case .getMovieCasts(let movieID) : return
        "/movie/\(movieID)/casts?api_key=\(api_key)"
        case .getMovieReviews(let movieID): return
        "/movie/\(movieID)/reviews?api_key=\(api_key)"
        case .getMovieVideos(let movieID): return
        "/movie/\(movieID)/videos?api_key=\(api_key)"
        case .searchMovies(let query):
            return "/search/movie?api_key=\(api_key)&query=\(query)"
        case .getMoviesGenres:
            return "/genre/movie/list?api_key=\(api_key)"
        }
    }
    
    // MARK: - Parameters
//    why get api calls has no parameters and directly inserted within the url or if path == ta7t
    private var parameters: Parameters? {
        switch self {
            
//        case.login(let username,let password):
//            let parameters: [String:Any] = [
//            "password" : password ,
//            "username" : username
//            ]
//            return parameters
            
        case   .getMovies ,.getMovieDetails ,.getMovieRecommendations ,.getMovieReviews ,.getMovieCasts ,.getMovieVideos ,.searchMovies ,.getMoviesGenres :
            return nil
       
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var main_api_url = ""
        main_api_url = Constants.ProductionServer.baseURL + path
        let urlComponents = URLComponents(string: main_api_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? main_api_url)!
        let url = urlComponents.url!
        var urlRequest = URLRequest(url: url)
        
        print("URLS REQUEST :\(urlRequest)")
        
        // HTTP Method
//        urlRequest.httpMethod = method.rawValue
//        let credentialData = "ck_37baea2e07c8960059930bf348d286c7e48eb325:cs_0d74440eb12ac4726080563a4ceb0363ad5a0112".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
//        let base64Credentials = credentialData.base64EncodedString()
//        let headers = "Basic \(base64Credentials)"
//
//        urlRequest.setValue(headers, forHTTPHeaderField: Constants.HTTPHeaderField.authentication.rawValue)
        
        
        // Parameters
        if let parameters = parameters {
            do {
                print(parameters)
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])

            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }


        }
        


//        if path == "login.php" || path == "edit_profile.php" || path == "edit_avatar.php" || path == "insertorder.php" || path == "add_customer_adrs.php" || path == "insert_order_cart.php"{
//            return try URLEncoding.default.encode(urlRequest, with: parameters)
//        }
        

        
        return urlRequest as URLRequest
        

    }
}
