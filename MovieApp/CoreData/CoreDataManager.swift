//
//  CoreDataManager.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 17.10.2022.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    var coreDataStack: CoreDataStack
    var moc: NSManagedObjectContext {
        return coreDataStack.managedContext
    }
    
    private init(coreDataStack: CoreDataStack = CoreDataStack(modelName: "MovieApp")) {
        self.coreDataStack = coreDataStack
    }
    
    private func getRequest() -> NSFetchRequest<Movie> {
        let request:NSFetchRequest<Movie> = Movie.fetchRequest()
        request.returnsObjectsAsFaults = false
        return request
    }
    
    private func uniqueMovieNamePredicate(of request: NSFetchRequest<Movie>, with uniqueName: String) -> NSPredicate {
        request.predicate =
            NSPredicate(format: "title == %@", uniqueName)
        return request.predicate!
    }
    
    
    func getMoviesFromPersistance(completion: @escaping (Result<[Movie], Error>) -> Void){
        do {
            let request = getRequest()
            let movies = try moc.fetch(request)
            completion(.success(movies))
        } catch {
            completion(.failure(error))
        }

    }
    
    func checkIsFavourite(with movieTitle: String, completion: @escaping (Result<Bool, Error>) -> Void){

        do {
            let request = getRequest()
            request.predicate = uniqueMovieNamePredicate(of: request, with: movieTitle)
            let fetchedResults = try moc.fetch(request)
            fetchedResults.first != nil ? completion(.success(true)) : completion(.success(false))
        } catch {
            completion(.failure(error))
        }
    }

    func createMovie(with movieResult: Search) {
        let movie = Movie(context: moc)
        movie.title = movieResult.title
        movie.image = movieResult.poster
        coreDataStack.saveContext()
    }
    
    func deleteMovie(with movieTitle: String, completion: @escaping (Error) -> Void) {
        let request = getRequest()
        request.predicate = uniqueMovieNamePredicate(of: request, with: movieTitle)
        do {
            let fetchedResult = try moc.fetch(request)
            if let movieModel = fetchedResult.first {
                print("debug: deleting movie model which is \(movieModel)")
                moc.delete(movieModel)
                coreDataStack.saveContext()
            }
        } catch {
            completion(error)
        }
    }
}
