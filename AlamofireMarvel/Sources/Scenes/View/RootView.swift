//
//  RootView.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 25.05.2022.
//

import UIKit

class RootView: UIView {
    
    // MARK: - Properies

    var delegate: RootViewDelegate?

    // MARK: - Initial

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        // Todo
    }

    private func setupLayout() {
        // Todo
    }
    
    private func setupView() {
        self.backgroundColor = .secondarySystemBackground | .systemBackground
    }

}
