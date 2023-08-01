//
//  AbillitiesCollectionViewCell.swift
//  MySkillsSurf
//
//  Created by Alex Kosta on 01.08.2023.
//

import UIKit


final class AbillitiesCollectionViewCell: UICollectionViewCell {

    // MARK: - Nested Type
    
    enum ConfigurationType {
        case add
        case abillities
    }
    
    // MARK: - IBOutlets

    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    // MARK: - Properties

    var action: ((ConfigurationType) -> Void)?

    // MARK: - Private Properties

    private var type: ConfigurationType = .add
    private var name: String?
    
    // MARK: - Lifecircle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(named: "TopBackgrounColor")
        layer.cornerRadius = 12
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        actionButton.setImage(nil, for: .normal)
    }
    
    // MARK: - Actions

    @IBAction func selectedAction(_ sender: Any) {
        action?(type)
    }

    // MARK: - Methods

    func configuration(name: String? = nil, type: ConfigurationType) {
        self.name = name
        self.type = type
        
        switch type {
        case .add:
            title.isHidden = true
            actionButton.setImage(UIImage(named: "plus.svg"), for: .normal)
        case .abillities:
            title.isHidden = false
            title.text = name
            title.textAlignment = .center
            title.font = .systemFont(ofSize: 14)
            actionButton.setImage(UIImage(named: "delete.png"), for: .normal)
        }
    }

}
