//
//  MainService.swift
//  IMovies
//
//  Created by Amrizal on 23/07/21.
//

import ReactiveSwift
import Alamofire
import SwiftyJSON

class MainService {
    
    func fetchGenres() -> SignalProducer<[GenreModel], Error> {
        
        return SignalProducer { observer, disposable in
            
            var param = [String:Any]()
            param["api_key"] = "e0efd93f12aa10917135138b0a1bfcde"
            
            let request = AF.request(UrlConstant.pathGenreList, method: .get, parameters: param)
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    do {
                        let json = try JSON(data: response.data!)
                        let items : [GenreModel] = json["genres"].arrayValue.compactMap{
                            return GenreModel(fromJson: $0)
                        }
                        observer.send(value: items)
                    } catch {
                        observer.send(error: error)
                    }
                    observer.sendCompleted()
                    
                case .failure(let error):
                    observer.send(error: error)
                }
            })
        }
    }
    
    func fetchMovies(_ genre:GenreModel) -> SignalProducer<[MovieModel], Error> {
        
        return SignalProducer { observer, disposable in
            
            var param = [String:Any]()
            param["api_key"] = "e0efd93f12aa10917135138b0a1bfcde"
            param["with_genres"] = genre.id
            
            print("params:\(param)")
            
            let request = AF.request(UrlConstant.pathMovieList, method: .get, parameters: param)
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    do {
                        let json = try JSON(data: response.data!)
                        print("json:\(json)")
                        let items : [MovieModel] = json["results"].arrayValue.compactMap{
                            return MovieModel(fromJson: $0)
                        }
                        observer.send(value: items)
                    } catch {
                        observer.send(error: error)
                    }
                    observer.sendCompleted()
                    
                case .failure(let error):
                    observer.send(error: error)
                }
            })
        }
    }
    
    func fetchMovieDetail(_ id:Int) -> SignalProducer<MovieDetailModel, Error> {
        
        return SignalProducer { observer, disposable in
            
            var param = [String:Any]()
            param["api_key"] = "e0efd93f12aa10917135138b0a1bfcde"
            
            let url = "\(UrlConstant.pathMovieDetail)\(id)"
            
            let request = AF.request(url, method: .get, parameters: param)
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    do {
                        let json = try JSON(data: response.data!)
                        print("json:\(json)")
                        let item = MovieDetailModel(fromJson: json)
                        observer.send(value: item)
                    } catch {
                        observer.send(error: error)
                    }
                    observer.sendCompleted()
                    
                case .failure(let error):
                    observer.send(error: error)
                }
            })
        }
    }
    
    func fetchCredit(_ id:Int) -> SignalProducer<CreditListModel, Error> {
        
        return SignalProducer { observer, disposable in
            
            var param = [String:Any]()
            param["api_key"] = "e0efd93f12aa10917135138b0a1bfcde"
            
            let url = "\(UrlConstant.pathMovieDetail)\(id)/credits"
            
            let request = AF.request(url, method: .get, parameters: param)
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    do {
                        let json = try JSON(data: response.data!)
                        print("json:\(json)")
                        let item = CreditListModel(fromJson: json)
                        observer.send(value: item)
                    } catch {
                        observer.send(error: error)
                    }
                    observer.sendCompleted()
                    
                case .failure(let error):
                    observer.send(error: error)
                }
            })
        }
    }
}
