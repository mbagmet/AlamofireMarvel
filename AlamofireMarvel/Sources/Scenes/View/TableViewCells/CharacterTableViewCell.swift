//
//  CharacterTableViewCell.swift
//  AlamofireMarvel
//
//  Created by Михаил Багмет on 26.05.2022.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    static let identifier = "DefaultTableViewCell"
    
    // MARK: - Configuration

    public func configureCell(with model: Character) {
        textLabel?.text = model.name
        detailTextLabel?.text = model.description
        
        model.image?.getImage(size: .small, completion: { data in
            guard let data = data else { return }
            self.imageView?.image = UIImage(data: data)
        })
    }

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Settings
    
    private func setupView() {
        imageSetup()
        accessoryType = .disclosureIndicator
    }
    
    private func imageSetup() {
        imageView?.layer.masksToBounds = true
        imageView?.layer.cornerRadius = Metric.iconCornerRadius
        
        imageView?.image = UIImage(named: "standard-medium")
    }
}

extension CharacterTableViewCell {
    enum Metric {
        static let iconCornerRadius: CGFloat = 7
    }
}
