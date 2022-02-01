////
////  HomeViewModel.swift
////  NewsApp
////
////  Created by lapshop on 2/1/22.
////
//
//import Foundation
//import RxSwift
//import RxCocoa
//
class HomeViewModel {
//    
//   // private(set) var NewArray : [GameInfoModel] = []
//    private var offset = 1
//    private var viewState = BehaviorRelay<State>(value: .idle)
//    var stateObservable : Driver<State>   {
//        return viewState.asDriver()
//    }
//    private var newSearchWord : String = ""
//    private var currentSearchWord : String = ""
//    private var videoGameInfoRepository : VideoGameInfoRepository
//    private var mainCoordinator : MainCoordinatorProtocol
//    
//    enum State {
//        case idle
//        case noresults
//        case loadSpinner
//        case loadGamesInfo
//    }
//        
//    enum Action {
//        case clickOnGameInfo(gameInfoID:Int64)
//        case searchGame(name:String)
//        case getMoreGames
//    }
//    
//    
//    init(videoGameInfoRepository : VideoGameInfoRepository,mainCoordinator:MainCoordinatorProtocol) {
//        self.videoGameInfoRepository = videoGameInfoRepository
//        self.mainCoordinator = mainCoordinator
//        getGamesInfo()
//    }
//    
//    
//    func getGamesInfo() {
//        
//        resetParametersIfNewSearhWordIsDifferent()
//        
//        loadSpinner()
//        
//        self.videoGameInfoRepository.getAllGames(with: .getAllGames(offset: offset, name: currentSearchWord)) { [weak self] (result) in
//            guard let weakself = self else {return}
//            switch result {
//               case .success(let gameModelsArray):
//                weakself.gamesInfoArray.append(contentsOf: gameModelsArray)
//                weakself.offset += 1
//                weakself.viewState.accept(.loadGamesInfo)
//               case .failure(let customErrorModel):
//                print(customErrorModel.description)
//            }
//        }
//        
//    }
//    
//     func resetParametersIfNewSearhWordIsDifferent() {
//            if currentSearchWord != newSearchWord {
//                gamesInfoArray.removeAll()
//                viewState.accept(.loadGamesInfo)
//                currentSearchWord = newSearchWord
//                offset = 1
//            }
//       }
//    
//      func loadSpinner() {
//            viewState.accept(.loadSpinner)
//      }
//    
//      func onAction(action:Action)  {
//        switch action {
//        case .clickOnGameInfo(let gameInfoID):
//            mainCoordinator.goToGameInfoViewController(gameInfoID)
//        case .searchGame(let name):
//            newSearchWord = name
//            getGamesInfo()
//        case .getMoreGames:
//            getGamesInfo()
//        }
//     }
}

