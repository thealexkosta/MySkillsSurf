//
//  ViewController.swift
//  MySkillsSurf
//
//  Created by Alex Kosta on 01.08.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var geoposition: UILabel!
    @IBOutlet private weak var iconGeoposition: UIImageView!
    @IBOutlet private weak var abillitiesTitles: UILabel!
    @IBOutlet private weak var addAbillities: UIButton!
    @IBOutlet private weak var about: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var aboutDescription: UILabel!
    
    // MARK: - Private Properties
    
    private var cellTitles: [String] = [""]
    
    // MARK: - Lifcecircle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Профиль"
        configurationCollectionView()
        configurationLabels()
        configurationImages()
    }
    
    // MARK: - Actions
    
    @IBAction func addAbilitesAction(_ sender: Any) {
        addCell()
    }
    
}

// MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AbillitiesCollectionViewCell", for: indexPath) as? AbillitiesCollectionViewCell else { return UICollectionViewCell() }
        let cellType: AbillitiesCollectionViewCell.ConfigurationType = indexPath.row == (cellTitles.count - 1) ? .add : .abillities

        cell.configuration(name: cellTitles[indexPath.row], type: cellType)
        cell.action = { [weak self] type in
            if type == .abillities {
                self?.cellTitles.remove(at: indexPath.row)
                self?.collectionView.reloadData()
            } else {
                self?.addCell()
            }
            
        }

        return cell
    }
    
    
}

// MARK: - Private Methods

private extension ProfileViewController {
    
    func configurationCollectionView() {
        collectionView.register(UINib(nibName: "AbillitiesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AbillitiesCollectionViewCell")
        collectionView.dataSource = self
        layoutCells()
    }

    func configurationLabels() {
        name.text = "Костин Алексей Александрович"
        descriptionLabel.text = "Trainee IOS-dev"
        geoposition.text = "Ижевск"
        abillitiesTitles.text = "Мои навыки"
        about.text = "О себе"
        aboutDescription.text = "Начинающий IOS-dev"
        
        
        name.font = .systemFont(ofSize: 24, weight: .bold)
        descriptionLabel.font = .systemFont(ofSize: 14)
        geoposition.font = .systemFont(ofSize: 14)
        abillitiesTitles.font = .systemFont(ofSize: 16, weight: .medium)
        about.font = .systemFont(ofSize: 16, weight: .medium)
        aboutDescription.font = .systemFont(ofSize: 14, weight: .regular)
        
        name.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        descriptionLabel.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        geoposition.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        abillitiesTitles.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        about.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        aboutDescription.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        
        name.numberOfLines = 2
        descriptionLabel.numberOfLines = 2
        aboutDescription.numberOfLines = 0
        
        name.textAlignment = .center
        descriptionLabel.textAlignment = .center
        geoposition.textAlignment = .left
    }
    
    func configurationImages() {
        iconView.image = UIImage(named: "icon-round.png")
        iconGeoposition.image = UIImage(named: "Frame.png")
        addAbillities.setImage(UIImage(named: "Frame-2.png"), for: .normal)
    }
    
    func addCell() {
        let alertController = UIAlertController(title: "Добавление навыка",
                                                message: "Введите название навыка которым вы владеете",
                                                preferredStyle: .alert)
        
        alertController.addTextField { _ in }

        let action = UIAlertAction(title: "Добавить", style: .default) { [weak self] alert in
            guard let self = self else { return }
            if let textField = alertController.textFields?.first, let text = textField.text {
                self.cellTitles = [[text], self.cellTitles].flatMap { $0 }
                self.collectionView.reloadData()
            }
        }
        let dissmiss = UIAlertAction(title: "Отмена", style: .cancel)
        
        alertController.addAction(action)
        alertController.addAction(dissmiss)
        
        present(alertController, animated: true)
    }
    
    func layoutCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        layout.minimumInteritemSpacing = 5.0
        layout.minimumLineSpacing = 5.0
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        collectionView.collectionViewLayout = layout
    }

}
