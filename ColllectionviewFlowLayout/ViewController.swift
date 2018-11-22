//
//  ViewController.swift
//  ColllectionviewFlowLayout
//
//  Created by Vimal Das on 22/11/18.
//  Copyright © 2018 Vimal Das. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
}
