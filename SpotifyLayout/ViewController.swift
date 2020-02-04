//
//  ViewController.swift
//  SpotifyLayout
//
//  Created by rakesh.e.mishra on 03/02/20.
//  Copyright © 2020 rakesh.e.mishra. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        loadJSON()
    }
    
    private func setupCollectionView() {
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
    }

    private func loadJSON() {
        if let bundleUrl = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: bundleUrl), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                if let response = jsonResult as? [ Any ] {
                    response.forEach { (item) in
                        let section = Section(dictionary: item as! [String : Any])
                         sections.append(section)
                    }
                    
                    collectionView.reloadData()
                }
            } catch {
                // handle error
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: CustomCollectionViewCell.identifier,
        for: indexPath) as? CustomCollectionViewCell
        else { return UICollectionViewCell() }

        cell.section = sections[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(300)
        return CGSize(width: view.frame.width, height: height)
    }
}

