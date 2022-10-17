//
//  ViewController.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//

import UIKit
import Alamofire
import Kingfisher
import Lottie


class HomeViewController: UIViewController, MovieViewModelOutput, ErrorViewModelOutput {
   
    var moviesArray : [Search] = []
    var animationView = AnimationView()
    private let listMovieData : ListMovieData = NetworkManager()
    private lazy var viewModel = MovieViewModel(listMovieData: listMovieData)
    private let searchBar = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieInitialize()
        activityIndicator.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        createSearchBar()
        self.viewModel.output = self
        self.viewModel.errorOutput = self
        }
    
    func updateView(search: [Search], response : String) {
        if(response == "True"){
        lottieStart()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.moviesArray = search
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.lottieStop()
        }
    }
    }
    }
    func errorView(response: String, message: String) {
        if(response == "False") {
        let ErrorMessage = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
        ErrorMessage.addAction(ok)
        self.present(ErrorMessage, animated: true, completion: nil)
    }
    }
     private func createSearchBar() {
        navigationItem.searchController = searchBar
        searchBar.searchBar.delegate = self
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        activityIndicator.isHidden = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      
        viewModel.fetchMovieData(with: searchBar.text!.replacingOccurrences(of: " ", with: "+"))
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if segue.identifier == "toDetail" {
                   let movies = sender as? Search
                   let destinationVC = segue.destination as? DetailViewController
                   destinationVC!.movies = movies
                   
               }
           }
    }

extension HomeViewController {
    func lottieInitialize(){
        animationView.isHidden = true
        animationView.animation = Animation.named("movieAnimation" )
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 3
        animationView.backgroundColor = .white
        view.addSubview(animationView)
    }
    func lottieStart(){
        animationView.isHidden = false
        animationView.play()
    }
    
    func lottieStop(){
        animationView.isHidden = true
        animationView.stop()
    }


}
extension HomeViewController :  UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         
         if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? HomeCollectionViewCell {
             
             let moviesModel = moviesArray[indexPath.row]
             cell.layer.shadowColor = UIColor.lightGray.cgColor
             cell.layer.shadowRadius = 5
             cell.layer.shadowOpacity = 1
             cell.layer.shadowOffset = CGSize(width: 0, height: 0)
             cell.layer.masksToBounds = false
             cell.contentView.layer.cornerRadius = 20.0
             cell.titleLabel.text = moviesModel.title
             let url = URL(string: moviesModel.poster)
             cell.posterImage.kf.setImage(with: url)
             
             return cell
         } else {
             return UICollectionViewCell()
     }
     }

 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     let moviesModel = moviesArray[indexPath.row]
   performSegue(withIdentifier: "toDetail", sender: moviesModel)
     
 }
     }


