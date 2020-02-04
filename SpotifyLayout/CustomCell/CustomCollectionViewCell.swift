//
//  CustomCollectionViewCell.swift
//  SpotifyLayout
//
//  Created by rakesh.e.mishra on 03/02/20.
//  Copyright © 2020 rakesh.e.mishra. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    static let identifier = "CustomCollectionViewCell"
    static let subCollectionViewIdentifier = "subCollectionViewIdentifier"

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        let lcollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        lcollectionView.translatesAutoresizingMaskIntoConstraints = false

        return lcollectionView
    }()
    
    let titleLabel: UILabel = {
        let label  = UILabel()
        label.text = "Section Header"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    var section: Section? {
        didSet {
            guard let section = self.section else {return}
              self.titleLabel.text = section.title
              self.section?.playlists.forEach({ (item) in
                  let playlist = PlayList(dictionary: item as! [String : Any])
                  self.playlists.append(playlist)
              })
              self.collectionView.reloadData()
        }
    }
    
    lazy var playlists = [PlayList]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func setupSubViews() {
        setupTitle()
        setupSubCell()
    }
    
    private func setupTitle() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 8 ).isActive = true
    }
    
    private func setupSubCell() {
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 15).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        collectionView.register(SubCollectionViewCell.self, forCellWithReuseIdentifier:
            CustomCollectionViewCell.subCollectionViewIdentifier)
    }
}

extension CustomCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.subCollectionViewIdentifier, for: indexPath) as? SubCollectionViewCell else { return UICollectionViewCell() }
        cell.playlist = playlists[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.height / 2
        let height = frame.height / 2
        return CGSize(width: width, height: height)
    }
}
