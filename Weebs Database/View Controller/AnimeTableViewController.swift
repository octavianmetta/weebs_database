//
//  AnimeTableViewController.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 01/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import UIKit
import Alamofire

class AnimeTableViewController: UITableViewController {
    
    @IBAction func unwindToAnimeTable(segue:UIStoryboardSegue) { }

    var topAnime: [Anime] = []
    var selectedAnimeId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopAnime()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topAnime.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeTableViewCell", for: indexPath) as! AnimeTableViewCell
        let item = topAnime[indexPath.row]
        cell.titleLabel.text = item.title
        cell.configureWith(url: item.image_url)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedAnimeId = topAnime[indexPath.row].mal_id
        return indexPath
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let destinationVC = segue.destination as? AnimeDetailViewController else {
            return
        }
        destinationVC.animeId = selectedAnimeId
    }
    

}


extension AnimeTableViewController {
    func fetchTopAnime() {
        AF.request("https://api.jikan.moe/v3/top/anime/1/airing")
            .validate()
            .responseDecodable(of: TopAnime.self) { (response) in
                guard let topAnime = response.value else {return}
                self.topAnime = topAnime.top
                self.tableView.reloadData()
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.alpha = 0
                        self?.image = image
                        UIView.animate(withDuration: 0.5, animations: {
                            self?.alpha = 1
                        })
                    }
                }
            }
        }
    }
}
