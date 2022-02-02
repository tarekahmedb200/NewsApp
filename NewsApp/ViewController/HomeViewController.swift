//
//  HomeViewController.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController : UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : HomeViewModel!
    var disposeBag = DisposeBag()
    
    
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
    

    static func instantiate(with ViewModel: HomeViewModel) -> HomeViewController? {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        
        guard let homeViewController = storyBoard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
        else {
            return nil
        }
        homeViewController.viewModel = ViewModel
        return homeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerCells()
        setupObserver()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func registerCells() {
        tableView.register(UINib(nibName: "\(ArticleHeadlineTableViewCell.self)", bundle: nil) , forCellReuseIdentifier: "\(ArticleHeadlineTableViewCell.self)")
    }

    private func setupObserver() {
        viewModel.stateObservable.drive(onNext: { [weak self] in
            guard let weakSelf = self else {return}
            switch $0 {
            case .gettingData:
                weakSelf.activityIndicator.startAnimating()
            case .loadingData:
                weakSelf.activityIndicator.stopAnimating()
                weakSelf.tableView.reloadData()
            case .noresults:
                break
            }
        }).disposed(by: disposeBag)
    }

}

extension HomeViewController : UITableViewDataSource , UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ArticleHeadlineTableViewCell.self)") as? ArticleHeadlineTableViewCell else{
            return UITableViewCell()
        }
        let article = viewModel.articleArray[indexPath.row]
        cell.configureCell(article)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleArray.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = viewModel.articleArray[indexPath.row]
        viewModel.onAction(action: .clickCell(article: selectedArticle))
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - tableView.frame.height  {
            viewModel.onAction(action: .scrollForMore)
        }
    }

}
