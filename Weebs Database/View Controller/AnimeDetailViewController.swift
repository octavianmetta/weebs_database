//
//  AnimeDetailViewController.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 02/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import UIKit
import Alamofire

class AnimeDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleJapaneseLabel: UILabel!
    @IBOutlet weak var totalEpisodesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var animeId: Int?
    var animeDetail: AnimeDetail? = nil {
        didSet {
            setUi(animeDetail: self.animeDetail!)
        }
    }
    private var task: URLSessionDataTask?


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAnimeDetail(id: animeId ?? 0)

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let destinationVC = segue.destination as? PosterDetailViewController else {
            return
        }
        destinationVC.posterImage = self.posterImage.image
    }
 

}

extension AnimeDetailViewController {
    func fetchAnimeDetail(id: Int) {
        let url = "https://api.jikan.moe/v3/anime/\(id)"
        print(url)
        AF.request(url)
            .validate()
            .responseDecodable(of: AnimeDetail.self) { (response) in
                print(response)
                guard let animeDetail = response.value else {return}
                print(animeDetail)
                self.animeDetail = response.value
        }
    }
    
    func setUi(animeDetail: AnimeDetail) {
        titleLabel.text = animeDetail.title
        titleJapaneseLabel.text = animeDetail.title_japanese
        totalEpisodesLabel.text = animeDetail.getEpisodes()
        scoreLabel.text = "\(animeDetail.score ?? 0)"
        synopsisLabel.text = animeDetail.synopsis
        loadImage(url: animeDetail.image_url ?? "")
    }
    
    func loadImage(url string: String) {
        guard let url = URL(string: string) else { return }
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.posterImage.image = image
                    UIView.animate(withDuration: 0.5, animations: {
                        self.posterImage.alpha = 1
                    })
                }
            }
        }
        task?.resume()
    }
}
