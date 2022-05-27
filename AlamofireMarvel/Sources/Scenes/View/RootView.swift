//
//  RootView.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 25.05.2022.
//

import UIKit

class RootView: UIView {
    
    // MARK: - Configuration
    
    func configureView(with model: [Character]) {
        self.model = model
        charactersTableView.reloadData()
    }
    
    // MARK: - Properies

    var delegate: RootViewDelegate?
    var model = [Character]()
    
    // MARK: - Views

    private lazy var charactersTableView = UITableView(frame: self.bounds, style: UITableView.Style.plain)

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
        
        setupDataSource()
        setupDelegate()
        setupTableCells()
    }
    
    // MARK: - Settings
    
    private func setupHierarchy() {
        self.addSubview(charactersTableView)
    }

    private func setupLayout() {
        charactersTableView.addConstraints(top: self.topAnchor, left: self.leadingAnchor, paddingLeft: Metric.sidePadding,
                                           right: self.trailingAnchor, paddingRight: Metric.sidePadding, bottom: self.bottomAnchor)
    }
    
    private func setupView() {
        self.backgroundColor = .secondarySystemBackground | .systemBackground
    }
    
    private func setupDataSource() {
        charactersTableView.dataSource = self
    }

    private func setupDelegate() {
        charactersTableView.delegate = self
    }
    
    private func setupTableCells() {
        charactersTableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
    }
}

// MARK: - Delegate, обработка высоты рядов
// Работает в паре с setupDelegate()

extension RootView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Metric.characterCellHeight
    }
}

// MARK: - Data source, модель ячейки
// Работает в паре с setupDataSource()

extension RootView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = model[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }

        cell.configureCell(with: model)
        return cell
    }
}

// MARK: - Обработка нажатия на ячейку

extension RootView {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let character = model[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)

        delegate?.changeViewController(with: character)
    }
}

// MARK: - Constants

extension RootView {
    enum Metric {
        static let characterCellHeight: CGFloat = 120
        static let sidePadding: CGFloat = 0
    }
}
