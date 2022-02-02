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
    
    
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var rateButtin: UIButton!
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleDateLabel: UILabel!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articelSourceLabel: UILabel!
    @IBOutlet weak var articelAuthorLabel: UILabel!
    @IBOutlet weak var articelContentText: UITextView!
    
   
    lazy var activityIndicator : UIActivityIndicatorView  = {
        let activityIndicator = UIUtitles.shared.createActivityIndicator(self)
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
        setupTextFiledObserver()
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
            case .showAlertMessage:
                weakSelf.showAlertRateConfirmationAlertMessage()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupTextFiledObserver() {
        rateTextField.rx.text.orEmpty
            .asObservable()
            .subscribe( onNext: { text in
                guard let number = Int(text)  else {
                    return
                }
                self.rateButtin.isEnabled = (number > 0 && number < 6)
                self.rateButtin.backgroundColor = (number > 0 && number < 6) ? .systemBlue : .systemGray
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
        rateButtin.isEnabled = false
        rateButtin.backgroundColor = UIColor.systemGray
    }
   

    @IBAction func saveButtonClicked(_ sender: UIButton) {
        viewModel.onAction(action: .clickButton)
    }
    
    private func showAlertRateConfirmationAlertMessage() {
        UIUtitles.shared.showAlertMessage(title: "Done", message: "Thanks For Rating", self)
    }
    
}
