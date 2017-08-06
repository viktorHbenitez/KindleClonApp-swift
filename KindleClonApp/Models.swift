//
//  Models.swift
//  KindleClonApp
//
//  Created by Victor Hugo Benitez Bosques on 06/08/17.
//  Copyright © 2017 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation

class Book {
    let title: String
    let author: String
    let pages: [Page]  // one to many : for that book class has the Page's object
    
    init(title: String, author: String, pages: [Page]) {
        self.title = title
        self.author = author
        self.pages = pages
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