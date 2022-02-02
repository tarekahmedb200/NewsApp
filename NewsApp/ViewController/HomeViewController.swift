//
//  HomeViewController.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class HomeViewController : UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var offlineModeView: UIView!
    
    var viewModel : HomeViewModel!
    var disposeBag = DisposeBag()
    
    lazy var activityIndicator : UIActivityIndicatorView  = {
        let activityIndicator = UIUtitles.shared.createActivityIndicator(self)
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
        setupNoResultsView()
        setupOfflineModeView()
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
            case .showErrorMessage(let errorMessage):
                weakSelf.activityIndicator.stopAnimating()
                weakSelf.showErrorMessage(errorMessage)
            case .noresults:
                weakSelf.noResultsView.isHidden = false
            case .showOfflineModeView:
                weakSelf.offlineModeView.snp.updateConstraints { (make) in
                    make.height.equalTo(75)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupNoResultsView() {
        self.view.addSubview(noResultsView)
        noResultsView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        noResultsView.isHidden = true
    }

    private func showErrorMessage(_ errorMessage:String) {
        UIUtitles.shared.showAlertMessage(title:"Error", message: errorMessage, self)
    }
    
    private func setupOfflineModeView() {
        offlineModeView.snp.makeConstraints { (make) in
            make.height.equalTo(0)
        }
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
