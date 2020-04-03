//
//  AnimeTableViewCell.swift
//  Weebs Database
//
//  Created by Octavian Metta Wisnu on 01/04/20.
//  Copyright © 2020 Octavian Metta Wisnu. All rights reserved.
//

import UIKit

class AnimeTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var task: URLSessionDataTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        let placeholderImage = UIImage(named: "placeholder_movie")
        posterImageView.alpha = 0
        posterImageView.image = placeholderImage
    }
    
    func configureWith(url string: String) {
        guard let url = URL(string: string) else { return }
        
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.posterImageView.image = image
                    UIView.animate(withDuration: 0.5, animations: {
                        self.posterImageView.alpha = 1
                    })
                }
            }
        }
        task?.resume()
    } 

}
