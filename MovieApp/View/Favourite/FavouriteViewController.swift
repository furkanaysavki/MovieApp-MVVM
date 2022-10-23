//
//  FavouriteViewController.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 17.10.2022.
//

import UIKit

class FavouriteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var favoritedMovies: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
 
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        CoreDataManager.shared.getMoviesFromPersistance { result in
            switch result {
            case .success(let movies):
                self.favoritedMovies = movies
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritedMovies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteCell", for: indexPath) as? FavouriteCollectionViewCell {
            let movies = favoritedMovies[indexPath.row]
            cell.saveFavoriteMovie(model: movies)
            return cell
        } else {
            return UICollectionViewCell()
    }
        
        }
}
