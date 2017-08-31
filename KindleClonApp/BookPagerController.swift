//
//  BookPagerController.swift
//  KindleClonApp
//
//  Created by Victor Hugo Benitez Bosques on 16/08/17.
//  Copyright © 2017 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class BookPagerController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        navigationItem.title = "Book"
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        // tell the collection view to scroll horizontally
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout  // we need this for the properties
        layout?.scrollDirection = .horizontal
        layout?.minimumLineSpacing = 0
        collectionView?.isPagingEnabled = true

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
    
        if indexPath.item % 2 == 0{
            cell.backgroundColor = .red
        }else{
            cell.backgroundColor = .blue
        }
        
        
        
        return cell
        
        
    }
    
}

extension BookPagerController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
}





