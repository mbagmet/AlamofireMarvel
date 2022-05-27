//
//  DetailView.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 27.05.2022.
//

import UIKit

class DetailView: UIView {

    // MARK: - Configuration
    
    func configureView(with model: Character) {
        self.character = model
        self.setupCharacterData()
        self.setupImage()
    }

    // MARK: - Properies

    var character: Character?
    
    // MARK: - Views
    
    private lazy var mainStackView = createStackView(axis: .vertical, distribution: .fill)
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "detail")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var titleLabel = createLabel(size: Metric.titleFontSize, weight: .bold, multiline: false)
    private lazy var descriptionLabel = createLabel(size: Metric.descriptionFontSize, weight: .regular, multiline: true)
    private lazy var comicsTitleLabel = createLabel(size: Metric.subtitleFontSize, weight: .bold, multiline: false)
    
    private lazy var comicsTableView = UITableView(frame: self.bounds, style: UITableView.Style.plain)
    
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
        setupView()
        setupHierarchy()
        setupLayout()
        
        setupDataSource()
        setupTableCells()
    }
    
    // MARK: - Settings
    
    private func setupView() {
        self.backgroundColor = .tertiarySystemBackground | .systemBackground
    }
    
    private func setupHierarchy() {
        self.addSubview(imageView)
        
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(descriptionLabel)
        
        self.addSubview(comicsTitleLabel)
        self.addSubview(comicsTableView)
    }

    private func setupLayout() {
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        mainStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Metric.titleTopPadding).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metric.leftPadding).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metric.rightPadding).isActive = true

        comicsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        comicsTitleLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: Metric.betweenBlocksPadding).isActive = true
        comicsTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metric.leftPadding).isActive = true
        comicsTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metric.rightPadding).isActive = true
        
        comicsTableView.translatesAutoresizingMaskIntoConstraints = false
        comicsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        comicsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        comicsTableView.topAnchor.constraint(equalTo: comicsTitleLabel.bottomAnchor, constant: Metric.comicTitleBottomPadding).isActive = true
        comicsTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupDataSource() {
        comicsTableView.dataSource = self
    }
    
    private func setupTableCells() {
        comicsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "charactersTableCell")
    }
    
    private func setupImage() {
        character?.image?.getImage(size: .big, completion: { data in
            guard let character = data else { return }
            self.imageView.image = UIImage(data: character)
        })
    }
    
    private func setupCharacterData() {
        guard let character = character else { return }
        
        titleLabel.text = character.name
        descriptionLabel.text = character.description
        
        if character.comics?.items?.count ?? 0 > 0 {
            comicsTitleLabel.text = Strings.comicTableTitle
        }
    }
    
    // MARK: - Private functions

    private func createStackView(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) -> UIStackView {
        let stackView = UIStackView()

        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = Metric.stackViewSpacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }
    
    private func createLabel(size: CGFloat, weight: UIFont.Weight, multiline: Bool) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: size, weight: weight)
        if multiline {
            label.numberOfLines = 0
        }
        
        return label
    }
}

// MARK: - Data source, модель ячейки
// Работает в паре с setupDataSource()

extension DetailView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character?.comics?.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comic = character?.comics?.items?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "charactersTableCell", for: indexPath)
        cell.textLabel?.text = comic?.name

        return cell
    }
}

// MARK: - Constants

extension DetailView {
    enum Metric {
        static let stackViewSpacing: CGFloat = 12
        static let leftPadding: CGFloat = 20
        static let rightPadding: CGFloat = -20
        static let titleTopPadding: CGFloat = 20
        static let betweenBlocksPadding: CGFloat = 30
        static let comicTitleBottomPadding: CGFloat = 5
        
        static let titleFontSize: CGFloat = 36
        static let subtitleFontSize: CGFloat = 22
        static let descriptionFontSize: CGFloat = 16
    }
    
    enum Strings {
        static let comicTableTitle = "Комиксы"
    }
}
