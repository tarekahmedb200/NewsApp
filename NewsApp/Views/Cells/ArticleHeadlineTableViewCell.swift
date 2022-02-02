//
//  ArticleHeadlineTableViewCell.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import UIKit
import Kingfisher

class ArticleHeadlineTableViewCell: UITableViewCell {

    @IBOutlet weak var articleHeadlineImageView: UIImageView!
    @IBOutlet weak var articleHeadlineTitleLabel: UILabel!
    
    override func layoutSubviews() {
        articleHeadlineImageView.layer.cornerRadius = 10
    }
    
    func configureCell(_ article:Article) {
        
        if let imageStringUrl = article.imageUrl , let imageUrl = URL(string:imageStringUrl) {
            articleHeadlineImageView.kf.setImage(with: imageUrl)
        }
        
        articleHeadlineTitleLabel.text = article.title
    }
    
}
