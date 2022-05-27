//
//  RootController.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 25.05.2022.
//

import UIKit
import Alamofire

class RootController: UIViewController {
    
    // MARK: - Properties
    
    var model: [Character]?
    
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
        
        networkProvider.fetchData() { characters in
            self.model = characters
            self.configureView()
        }
        
        configureViewDelegate()
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
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

extension RootController: UISearchResultsUpdating {
    func updateSearchResults(for search: UISearchController) {
        // TODO
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
}

// MARK: - Constants

extension RootController {
    enum Strings {
        static let searchBarPlaceholder = "Поиск"
        static let navigationTitle = "Персонажи"
    }
}
