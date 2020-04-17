//
//  MangaTableViewController.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 13/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import UIKit

class MangaTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBAction func unwindToMangaTable(segue:UIStoryboardSegue) { }
    
    var topList: [TopData] = []
    var selectedMangaId: Int = 0
    var isLoading = false
    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchTopManga()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let destinationVC = segue.destination as? AnimeDetailViewController else {
            return
        }
        destinationVC.animeId = selectedMangaId
    }
    
    
}


extension MangaTableViewController {
    func fetchTopManga() {
        MangaProviders().getTopManga(page: page) { [weak self] (resp, error) in
            guard let topList = resp?.top else { return }
            self?.topList.append(contentsOf: topList)
            self?.tableView.reloadData()
        
        }
    }
}

extension MangaTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeTableViewCell", for: indexPath) as! AnimeTableViewCell
        let item = topList[indexPath.row]
        cell.titleLabel.text = item.title
        cell.configureWith(url: item.image_url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedMangaId = topList[indexPath.row].mal_id
        return indexPath
    }
}
