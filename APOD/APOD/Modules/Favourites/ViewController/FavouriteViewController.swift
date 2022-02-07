//
//  FavouriteViewController.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 05/02/22.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    let viewModel: FavouriteViewModel
    private let numberOfColumns = 2
    private let cellOffset: CGFloat = 50.0
    
    var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    init(viewModel: FavouriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.screenTitle
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    private func refreshData() {
        viewModel.configureFavoriteDetails()
        collectionView.reloadData()
    }
    
    func setupView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: cellOffset, right: 0.0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavouriteGridCell.self, forCellWithReuseIdentifier: "CollectionCellIdentifier")
        collectionView.backgroundColor = .clear
    }

}

extension FavouriteViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.noOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellIdentifier", for: indexPath) as! FavouriteGridCell
        cell.configure(with: viewModel.image(at: indexPath.item))
        return cell
    }
    
    
}

extension FavouriteViewController: UICollectionViewDelegate {
    
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - CGFloat(numberOfColumns + 1) * 2.0) / CGFloat(numberOfColumns)
        return CGSize(width: cellWidth, height: cellWidth - 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellOffset
    }
}
