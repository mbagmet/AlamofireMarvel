//
//  DetailViewController.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 27.05.2022.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .secondarySystemBackground | .systemBackground
    }
    
    // MARK: - Initializers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
