//
//  RootController.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 25.05.2022.
//

import UIKit

class RootController: UIViewController {
    
    // MARK: - Properties
    
    var model: [Character]?
    var characters: [Character]?
    
    private let networkProvider = NetworkProvider()

    private var rootView: RootView? {
        guard isViewLoaded else { return nil }
        return view as? RootView
    }
    
    private lazy var searchController: UISearchController = {
        var search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = Strings.searchBarPlaceholder

        return search
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = RootView()
        setupNavigation()
        setupSeach()
        
        searchController.searchBar.delegate = self
        configureViewDelegate()
        configureNetworkProviderDelegate()
        
        networkProvider.fetchData(characterName: nil) { characters in
            self.model = characters
            self.characters = characters
            self.configureView()
        }
    }
}

// MARK: - Navigation

extension RootController {
    private func setupNavigation() {
        navigationItem.title = Strings.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Search

extension RootController {
    private func setupSeach() {
        navigationItem.searchController = searchController
    }
}

extension RootController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let characterName = searchController.searchBar.text else { return }
        networkProvider.fetchData(characterName: characterName) { characters in
            self.model = characters
            self.configureView()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = nil
        searchController.searchBar.resignFirstResponder()
        model = characters
        configureView()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard characters != nil,
              searchController.searchBar.text == ""
        else { return }
        
        self.model = characters
        self.configureView()
    }
}

// MARK: - Error Alert

extension RootController: NetworkProviderDelegate {
    func showAlert(message: String?) {
        let alert = UIAlertController(title: Strings.errorAlertTitle,
                                      message: message != nil ? message : Strings.errorAlertText,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: Strings.errorAlertButtonTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - RootViewDelegate

extension RootController: RootViewDelegate {
    func changeViewController(with character: Character) {
        let detailViewController = DetailViewController()
        detailViewController.model = character
        
        detailViewController.modalPresentationStyle = .popover
        detailViewController.modalTransitionStyle = .coverVertical
        navigationController?.present(detailViewController, animated: true, completion: nil)
    }
}

// MARK: - Configuration

extension RootController: ModelDelegate {
    func configureView() {
        guard let model = model else { return }
        rootView?.configureView(with: model)
    }
}

private extension RootController {
    func configureViewDelegate() {
        rootView?.delegate = self
    }
    
    func configureNetworkProviderDelegate() {
        networkProvider.delegate = self
    }
}

// MARK: - Constants

extension RootController {
    enum Strings {
        static let searchBarPlaceholder = "Поиск по имени персонажа"
        static let navigationTitle = "Персонажи"
        
        static let errorAlertTitle = "Ошибка"
        static let errorAlertText = "По вашему запросу ничего не найдено. Попробуйте ввести другой запрос."
        static let errorAlertButtonTitle = "OK"
    }
}
