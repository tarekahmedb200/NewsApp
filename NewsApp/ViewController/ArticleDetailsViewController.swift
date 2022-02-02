//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by lapshop on 2/2/22.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ArticleDetailsViewController : UIViewController {
    
    var viewModel : ArticleDetailsViewModel!
    let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleDateLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articelSourceLabel: UILabel!
    @IBOutlet weak var articelAuthorLabel: UILabel!
    @IBOutlet weak var articelContentText: UITextView!
    
    
    lazy var activityIndicator : UIActivityIndicatorView  = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.white
        activityIndicator.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = self.view.frame
        self.view.addSubview(activityIndicator)
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    
    static func instantiate(with viewModel: ArticleDetailsViewModel) -> ArticleDetailsViewController? {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        
        guard let articleDetailsViewController = storyBoard.instantiateViewController(identifier: "ArticleDetailsViewController") as? ArticleDetailsViewController
        else {
            return nil
        }
        articleDetailsViewController.viewModel = viewModel
        return articleDetailsViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
    }
    
    private func setupObserver() {
        viewModel.stateObservable.drive(onNext: { [weak self] in
            guard let weakSelf = self else {return}
            switch $0 {
            case .gettingData:
                weakSelf.activityIndicator.startAnimating()
            case .loadingData:
                weakSelf.activityIndicator.stopAnimating()
                weakSelf.setupUI()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupUI() {
        if let imageStringUrl = viewModel.articleImageUrl {
            articleImage.kf.setImage(with: imageStringUrl)
        }
        articleDateLabel.text = viewModel.articleDateString
        articleTitleLabel.text = viewModel.articleTitle
        articelSourceLabel.text = viewModel.articleSourceName
        articelAuthorLabel.text = viewModel.articleAuthorName
        articelContentText.text = viewModel.articleContent
    }

}
