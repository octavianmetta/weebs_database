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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var topList: [TopData] = []
    var selectedAnimeId: Int = 0
    var isLoading = false
    var page: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopAnime()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeTableViewCell", for: indexPath) as! AnimeTableViewCell
        let item = topList[indexPath.row]
        cell.titleLabel.text = item.title
        cell.configureWith(url: item.image_url)
        
        if indexPath.row == topList.count - 1 { // last cell
            page += 1
            fetchTopAnime()
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedAnimeId = topList[indexPath.row].mal_id
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
        guard !isLoading else { return }
        isLoading = true
        AnimeProviders().getTopAnime(page: self.page) { [weak self] (resp, error) in
            guard let topList = resp?.top else { return }
            self?.topList.append(contentsOf: topList)
            self?.isLoading = false
            self?.tableView.reloadData()
        }
    }
}

