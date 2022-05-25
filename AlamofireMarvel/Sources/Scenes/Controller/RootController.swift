//
//  RootController.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 25.05.2022.
//

import UIKit

class RootController: UIViewController {
    
    // MARK: - Properties

    private var rootView: RootView? {
        guard isViewLoaded else { return nil }
        return view as? RootView
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = RootView()
        setupNavigation()
        setupSeach()
    }
    
    private lazy var searchController: UISearchController = {
        var search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = Strings.searchBarPlaceholder

        return search
    }()
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
    // todo
}

// MARK: - Configuration

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
