//
//  BookPagerController.swift
//  KindleClonApp
//
//  Created by Victor Hugo Benitez Bosques on 16/08/17.
//  Copyright © 2017 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class BookPagerController: UICollectionViewController {
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        navigationItem.title = self.book?.title
        
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        // tell the collection view to scroll horizontally
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout  // we need this for the properties
        layout?.scrollDirection = .horizontal
        layout?.minimumLineSpacing = 0
        collectionView?.isPagingEnabled = true
        
        // Add close button
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(handlerCloseBook))
    }
    
    func handlerCloseBook() {
        dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book?.pages.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let pages = book?.pages[indexPath.item]
        pageCell.textLabel.text = pages?.text
        
        return pageCell
        
    }
    
}

extension BookPagerController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - 44 - 20)
    }
    
}





