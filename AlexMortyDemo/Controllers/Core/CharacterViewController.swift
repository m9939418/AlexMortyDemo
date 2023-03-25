//
//  CharacterViewController.swift
//  AlexMortyDemo
//
//  Created by AlexYang on 2023/3/21.
//

import UIKit

class CharacterViewController: UIViewController {
    private let characterListView = CharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "角色"
            
        setUpViews()
  
        /// https://rickandmortyapi.com/api/character/?name=rick&status=alive
//        let request = MERequest(endPoint: .character,
//                queryParam: [
//                    URLQueryItem(name: "name", value: "rick"),
//                    URLQueryItem(name: "status", value: "alive")
//                ]
//        )
//        print(request.url)
//
//        APIService.shared.execute(request, excepting: MECharacter.self) { result in
//            switch result {
//            case .success:
//                break
//            case .failure(let error):
//                print(String(describing: error))
//                break
//            }
//        }
        
//        APIService.shared.execute(.listCharactersRequests, excepting: String.self) { result in
//            switch result {
//            case .success(let model):
//                String(describing: error)
//                break
//            case .failure(let error):
//                String(describing: error)
//                break
//            }
//        }
    }
    
    func setUpViews() {
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
