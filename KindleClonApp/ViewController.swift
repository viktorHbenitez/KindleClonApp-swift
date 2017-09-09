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

        
        // can provide custom code starting here
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        
        
        navigationItem.title = "Kindle App"
        
//        // create all books manually
//        setupBooks()

        fetchBooks()  // JSON FILE
        
    }
    
    func fetchBooks() {
        
        print("Fetching Books from external json...")
        
        // Fetch books from json: URLSession, runs in background thread
        if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json"){
            
            // 1. Fetch the books from JSON file
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if let err = error{
                    print("Faild to fetch external json books: ", err)
                    return
                }
                guard let data = data else { return }
                
                // 2. JSON serialization
                do{
                    let json =  try JSONSerialization.jsonObject(with: data, options: .mutableContainers)  // return array of dictionaries [[String : Any]]
                    
                    // Cast the json in array of dictionaries [Array [Dictionary (String : Any)]]
                    guard let bookDictionaries = json as? [[String : Any]] else { return }
                    
                    self.books = []  // inicialization of the book's array
                    
                    // 3. Create the book's object with the data of the JSON file
                    for bookDictionary in bookDictionaries{
                        
                        let book = Book(dictionary: bookDictionary)
                        self.books?.append(book)
              
                    }
                    
                    guard let allBooks = self.books else { return }
                    print("All our books: ", allBooks.count)
                    
                    // 4. IMPORTANT : RELOAD THE TABLEVIEW IN THE MAIN THREAD (UPDATE THE UIVIEW'S IN THE MAIN THREAD )
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }catch let jsonError{
                    print("Failed to parse JSON properly: ", jsonError)
                
                }
            
            }).resume()
            
        
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Add author to the collectionView
        let selectedBook = self.books?[indexPath.row]
//        print(book?.title)
//        return
        
        // Create a collectionViewController
        let layout = UICollectionViewFlowLayout()
        let bookPagerController = BookPagerController(collectionViewLayout: layout)
        
        bookPagerController.book = selectedBook  // pass selected book object
        
        let navController = UINavigationController(rootViewController: bookPagerController)
        present(navController, animated: true, completion: nil)

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        
        let book = books?[indexPath.row]
        cell.book = book
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = books?.count{
            return count
        }
        return 0
    }
    
    func setupBooks(){
        let page1 = Page(number: 1, text: "Text for the first page")
        let page2 = Page(number: 2, text: "This is the text for second page")
        
        let pages : [Page] = [page1, page2]
        
        let book = Book(title: "Steve Jobs", author: "Walter Isaacson", image: #imageLiteral(resourceName: "steve_jobs"), pages: pages)
        
        
        // Create new Book object
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Becraft", image: #imageLiteral(resourceName: "bill_gates"),
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
//        if let books = self.books{
//            
//            for book in books{
//                print(book.title)
//                for page in book.pages {
//                    print(page.text)
//                }
//                
//            }
//        }

    
    }
    
}

