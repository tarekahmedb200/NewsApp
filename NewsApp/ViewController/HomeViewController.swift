//
//  HomeViewController.swift
//  NewsApp
//
//  Created by lapshop on 2/1/22.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController : ViewController {
        
    var viewModel : HomeViewModel!
    var disposeBag = DisposeBag()
    
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
        self.view.backgroundColor = .blue
//        setupTableView()
//        registerCells()
//        setupObserver()
//        setupSearchViewController()
    }
//
//    private func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//
//    private func registerCells() {
//        tableView.register(UINib(nibName: "\(GameInfoTableViewCell.self)", bundle: nil) , forCellReuseIdentifier: "\(GameInfoTableViewCell.self)")
//    }
//
//    private func setupObserver() {
//        viewModel.stateObservable.drive(onNext: { [weak self] in
//            guard let weakSelf = self else {return}
//            switch $0 {
//            case .loadSpinner:
//                weakSelf.activityIndicator.startAnimating()
//            case .loadGamesInfo:
//                weakSelf.activityIndicator.stopAnimating()
//                weakSelf.tableView.reloadData()
//            case .idle:
//                break
//            case .noresults:
//                break
//            }
//        }).disposed(by: disposeBag)
//    }
//
//
//    fileprivate func setupSearchViewController() {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.barStyle = .black
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.rx
//            .text
//            .asDriver()
//            .debounce(DispatchTimeInterval.milliseconds(1000))
//            .drive(onNext: { [weak self] in
//                guard let weakself = self else {return}
//                guard let text = $0 else {
//                    return
//                }
//
//                weakself.viewModel.onAction(action: .searchGame(name: text))
//            }).disposed(by: disposeBag)
//
//        self.navigationItem.searchController = searchController
//    }
//
//
//}
//
//extension HomeViewController : UITableViewDataSource , UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(GameInfoTableViewCell.self)") as? GameInfoTableViewCell else{
//            return UITableViewCell()
//        }
//        let gameInfo = viewModel.gamesInfoArray[indexPath.row]
//        cell.configureCell(with: gameInfo)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.gamesInfoArray.count
//    }
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let selectedGameInfoModel = viewModel.gamesInfoArray[indexPath.row]
//        let gameInfoID = selectedGameInfoModel.id ?? 0
//        viewModel.onAction(action: .clickOnGameInfo(gameInfoID: gameInfoID))
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let position = scrollView.contentOffset.y
//        if position > tableView.contentSize.height - tableView.frame.height  {
//            viewModel.onAction(action: .getMoreGames)
//        }
//    }
//
//
//
//
}
