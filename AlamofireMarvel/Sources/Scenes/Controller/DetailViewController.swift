//
//  DetailViewController.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 27.05.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var model: Character?

    private var detailView: DetailView? {
        guard isViewLoaded else { return nil }
        return view as? DetailView
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view = DetailView()
        self.configureView()
    }
    
    // MARK: - Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Configuration

extension DetailViewController: ModelDelegate {
    func configureView() {
        guard let model = model else { return }
        detailView?.configureView(with: model)
    }
}
