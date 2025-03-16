//
//  ApiClient.swift
//  MadeInKuwait
//
//  Created by mostafa elsanadidy on 1/29/22.
//  Copyright © 2022 mostafa elsanadidy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient {

    @discardableResult
       private static func performSwiftyRequest(route:APIRouter,_ completion:@escaping (JSON)->Void,_ failure:@escaping (Error?)->Void) -> DataRequest {
        
           return AF
            .request(route)
            .responseJSON(completionHandler: { (response) in
                   switch response.result {
                   case .success :
                    guard let _ = response.value
                        else {
                           failure(response.error)
                           return
                       }
                       print(response.result , route.urlRequest as Any)
                       let json = JSON(response.value as Any)
                       print(json)
                       
                       completion(json)
                      
                   case .failure( _):
                       failure(response.error)
                   }
               })
       }

    static func cancelAllRequests(completed : @escaping ()->() ) {
        AF.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
            completed()
        }
    }

    static func getWorkouts(completionHandler:@escaping ([Workout]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
        
        var route : APIRouter
        route = .getWorkouts
//        switch section{
//        case .TopRatedMovies:
//            route = .top_ratedMovies
//        case .PopularMovies:
//            route = .popularMovies
//        case .ComingSoon:
//            route = .upcomingMovies
//        case .NowPlaying:
//            route = .now_playingMovies
//        }
        
        performSwiftyRequest(route: route, { (jsonData) in
            
            do{
            let json_Data = try JSON(jsonData).rawData()
                print(json_Data)
                let movies = try JSONDecoder().decode(Array<Workout>.self, from: json_Data)
                completionHandler(movies)}
            catch{
                completionFaliure(error)
            }
         }) { (error) in
             completionFaliure(error)
         }
     }

//    static func getPopularMovies(api_key:String, completionHandler:@escaping ([Movie_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
//       performSwiftyRequest(route: .popularMovies(apiKey: api_key), { (jsonData) in
//
//           do{
//           let json_Data = try JSON(jsonData)["results"].rawData()
//               let user = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
//               completionHandler(user)}
//           catch{
//               completionFaliure(error)
//           }
//        }) { (error) in
//            completionFaliure(error)
//        }
//    }
    
//    static func getUpcomingMovies(api_key:String, completionHandler:@escaping ([Movie_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
//       performSwiftyRequest(route: .upcomingMovies(apiKey: api_key), { (jsonData) in
//
//           do{
//           let json_Data = try JSON(jsonData)["results"].rawData()
//               let user = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
//               completionHandler(user)}
//           catch{
//               completionFaliure(error)
//           }
//        }) { (error) in
//            completionFaliure(error)
//        }
//    }
    
//    static func getPlayingNowMovies(api_key:String, completionHandler:@escaping ([Movie_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
//       performSwiftyRequest(route: .now_playingMovies(apiKey: api_key), { (jsonData) in
//
//           do{
//           let json_Data = try JSON(jsonData)["results"].rawData()
//               let user = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
//               completionHandler(user)}
//           catch{
//               completionFaliure(error)
//           }
//        }) { (error) in
//            completionFaliure(error)
//        }
//    }
   
//    static func getMovieRecommendations(movieID:Int,
//                                        completionHandler:@escaping ([Movie_M]?)->Void ,
//                                        completionFaliure:@escaping (_ error:Error?)->Void){
//          performSwiftyRequest(route: .getMovieRecommendations(movieID: movieID), { (jsonData) in
//
//              do{
//              let json_Data = try JSON(jsonData)["results"].rawData()
//                  let user = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
//                  completionHandler(user)}
//              catch{
//                  completionFaliure(error)
//              }
//           }) { (error) in
//               completionFaliure(error)
//           }
//       }
//
//    static func getMovieCasts(movieID:Int,
//                                     completionHandler:@escaping ([CastUser_M]?)->Void ,
//                                     completionFaliure:@escaping (_ error:Error?)->Void){
//       performSwiftyRequest(route: .getMovieCasts(movieID: movieID), { (jsonData) in
//
//           do{
//           let json_Data = try JSON(jsonData)["cast"].rawData()
//               let user = try JSONDecoder().decode(Array<CastUser_M>.self, from: json_Data)
//               completionHandler(user)}
//           catch{
//               completionFaliure(error)
//           }
//        }) { (error) in
//            completionFaliure(error)
//        }
//    }
//
//    static func getMovieReviews(movieID:Int,
//                                     completionHandler:@escaping ([MovieReview_M]?)->Void ,
//                                     completionFaliure:@escaping (_ error:Error?)->Void){
//       performSwiftyRequest(route: .getMovieReviews(movieID: movieID), { (jsonData) in
//
//           do{
//           let json_Data = try JSON(jsonData)["results"].rawData()
//               let movieReviews = try JSONDecoder().decode(Array<MovieReview_M>.self, from: json_Data)
//               completionHandler(movieReviews)}
//           catch{
//               completionFaliure(error)
//           }
//        }) { (error) in
//            completionFaliure(error)
//        }
//    }
//
//    static func getMovieVideos(movieID:Int,
//                                     completionHandler:@escaping ([MovieVideo_M]?)->Void ,
//                                     completionFaliure:@escaping (_ error:Error?)->Void){
//       performSwiftyRequest(route: .getMovieVideos(movieID: movieID), { (jsonData) in
//
//           do{
//           let json_Data = try JSON(jsonData)["results"].rawData()
//               let movieVideos = try JSONDecoder().decode(Array<MovieVideo_M>.self, from: json_Data)
//               completionHandler(movieVideos)}
//           catch{
//               completionFaliure(error)
//           }
//        }) { (error) in
//            completionFaliure(error)
//        }
//    }
//
//
//    static func getMovieDetails(movieID:Int, completionHandler:@escaping (MovieDetails_M?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
//        performSwiftyRequest(route: .getMovieDetails(movieID: movieID), { (jsonData) in
//
//           do{
//           let json_Data = try JSON(jsonData).rawData()
//               let MovieDetails = try JSONDecoder().decode(MovieDetails_M.self, from: json_Data)
//               completionHandler(MovieDetails)}
//           catch{
//               completionFaliure(error)
//           }
//        }) { (error) in
//            completionFaliure(error)
//        }
//    }
//
////    18f1dd9d9a6779af535c45513bd22779
//    static func getMovieGenres(completionHandler:@escaping ([MovieGenre_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
//        performSwiftyRequest(route: .getMoviesGenres, { (jsonData) in
//
//           do{
//           let json_Data = try JSON(jsonData)["genres"].rawData()
//               let MovieDetails = try JSONDecoder().decode(Array<MovieGenre_M>.self, from: json_Data)
//               completionHandler(MovieDetails)}
//           catch{
//               completionFaliure(error)
//           }
//        }) { (error) in
//            completionFaliure(error)
//        }
//    }
//
//
//static func searchMovies(query:String, completionHandler:@escaping ([Movie_M]?)->Void , completionFaliure:@escaping (_ error:Error?)->Void){
//   performSwiftyRequest(route: .searchMovies(query: query), { (jsonData) in
//
//       do{
//       let json_Data = try JSON(jsonData)["results"].rawData()
//           let movies = try JSONDecoder().decode(Array<Movie_M>.self, from: json_Data)
//           completionHandler(movies)}
//       catch{
//           completionFaliure(error)
//       }
//    }) { (error) in
//        completionFaliure(error)
//    }
//}

}
