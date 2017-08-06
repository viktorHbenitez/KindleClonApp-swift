//
//  ViewController.swift
//  KindleClonApp
//
//  Created by Victor Hugo Benitez Bosques on 04/08/17.
//  Copyright © 2017 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var books : [Book]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Kindle App"
        
        view.backgroundColor = .red
        // can provide custom code starting here
        setupBooks()
        
    }
    
    func setupBooks(){
        let page1 = Page(number: 1, text: "Text for the first page")
        let page2 = Page(number: 2, text: "This is the text for second page")
        
        let pages : [Page] = [page1, page2]
        
        let book = Book(title: "Steve Jobs", author: "Walter Isaacson", pages: pages)
        
        
        // Create new Book object
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Becraft",
                         pages: [Page(number: 1, text: "Text for page 1"),
                                 Page(number: 2, text: "Text for page 2"),
                                 Page(number: 3, text: "Text for page 3"),
                                 Page(number: 4, text: "Text for page 4")])
        
        self.books = [book, book2]
        
        
        // another way
        //        guard let books = self.books else { return }
        //
        //        for book in books{
        //            print(book.title)
        //            for page in book.pages {
        //                print(page.text)
        //            }
        //
        //        }
        
        // Loop of the books and the pages in it, use optional value
        if let books = self.books{
            
            for book in books{
                print(book.title)
                for page in book.pages {
                    print(page.text)
                }
                
            }
        }

    
    }
    
}

