//
//  BookCell.swift
//  KindleClonApp
//
//  Created by Victor Hugo Benitez Bosques on 08/08/17.
//  Copyright © 2017 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    var book: Book? {
        didSet{
            titleLabel.text = book?.title
            authorLabel.text = book?.author
            
            // Download the Url from the JSON file: use URLSession
            coverImageView.image = nil
            
            guard let coverImageUrl = book?.coverImageUrl else { return }  // String URL
            guard let url = URL(string: coverImageUrl) else { return }  // create the url
            
            // 1. USE URLSession to download the image from JSON file
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let err = error{
                    print("Failed to retrieve our book cover image: ", err)
                    return
                }
                
                guard let imageData = data else { return }  // the data property is optional  too
                let image = UIImage(data: imageData) // 2. create the image with the data property
                
                // Render the image in the main Thread
                DispatchQueue.main.async {
                    self.coverImageView.image = image

                }
            }.resume()
            
            
        }
    }
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()  // init
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()  // run the code
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "This is the text for the title of our book inside of our cell"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
      let label = UILabel()
        label.textColor = .lightGray
        label.text = "This is some author for the book that we have in this row"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        // Add to the mainView
        addSubview(coverImageView)
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Add the lable in the main view
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor , constant: -10).isActive = true
        
        addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
