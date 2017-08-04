//
//  ViewController.swift
//  KindleClonApp
//
//  Created by Victor Hugo Benitez Bosques on 04/08/17.
//  Copyright © 2017 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit


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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        // can provide custom code starting here
        
        let page1 = Page(number: 1, text: "Text for the first page")
        let page2 = Page(number: 2, text: "This is the text for second page")
        
        let pages : [Page] = [page1, page2]
//        print(page1.text)
//        print(page2.text)
        
        let book = Book(title: "Steve Jobs", author: "Walter Isaacson", pages: pages)
//        print("Author \(book.author) is of the \(book.title) book")
        
        // Access to the first page to the Steve Jobs Book
        let firstPage = book.pages[0]
        print(firstPage.text)
    }
}

