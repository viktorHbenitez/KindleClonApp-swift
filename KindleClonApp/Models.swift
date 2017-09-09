//
//  Models.swift
//  KindleClonApp
//
//  Created by Victor Hugo Benitez Bosques on 06/08/17.
//  Copyright © 2017 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class Book {
    let title: String
    let author: String
    let image: UIImage
    let pages: [Page]  // one to many : for that book class has the Page's object
    
    init(title: String, author: String, image: UIImage, pages: [Page]) {
        self.title = title
        self.author = author
        self.image = image
        self.pages = pages
    }
    
    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.author = dictionary["author"] as? String ?? ""
        image = #imageLiteral(resourceName: "steve_jobs")
        
        var bookPages = [Page]()
        
        // fetch the pages from the JSON file
        if let pagesDictionaries = dictionary["pages"] as? [[String: Any]]{
            
            for pageDictionary in pagesDictionaries{
                
                if let pageText = pageDictionary["text"] as? String{  // get the text of the authors
                    
                    let page = Page(number: 1, text: pageText) // create a pages' objects and add to container
                    bookPages.append(page)
                    
                }
                
            }
        
        }
        pages = bookPages
    }
    
}

class Page {
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}
