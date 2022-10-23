//
//  DetailViewController.swift
//  MovieApp2
//
//  Created by Furkan Ayşavkı on 16.10.2022.
//



import UIKit
import Alamofire
import Kingfisher
import Lottie

class DetailViewController: UIViewController, DetailViewModelOutput {
    
    var animationView = AnimationView()
    var movies : Search?
    private let getDetailData : GetDetailData = NetworkManager()
    private lazy var detailViewModel = DetailViewModel(getDetailData: getDetailData)
   
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailViewModel.detailOutput = self
        lottieInitialize()
        lottieStart()
        favButton.addTarget(self, action: #selector(favList(_:)), for: .touchUpInside)
        detailViewModel.fetchDetail(with: movies!.imdbID)
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CoreDataManager.shared.checkIsFavourite(with: (movies?.title ?? "")) { result in
            switch result {
            case .success(let bool):
                bool ? self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            case .failure(let error):
                print(error)
            }
        }
    }
    
   func detailView(director: String, actor: String, plot: String, genre: String, imdb: String, poster: String) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.actorsLabel.text = "Actors: \(actor)"
        self.directorLabel.text = "Directors: \(director)"
        self.plotLabel.text = plot
        self.genreLabel.text = genre
        self.imdbLabel.text = imdb
        if let url = URL(string : poster) {
            DispatchQueue.main.async {
                    self.posterImage.kf.setImage(with : url)
                    }
         }
            self.lottieStop()
        }
        }
    
    @objc func favList(_ favButton: UIButton) {
        CoreDataManager.shared.checkIsFavourite(with: movies!.title ) { result in
            switch result {
            case .success(let bool):
                if bool {
                    CoreDataManager.shared.deleteMovie(with: self.movies!.title) { error in
                        print(error)
                    }
                    self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                
                } else {
                    CoreDataManager.shared.createMovie(with: self.movies!)
                    favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    }


extension DetailViewController {
    func lottieInitialize(){
        animationView.isHidden = true
        animationView.animation = Animation.named("moviecutAnimation" )
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
