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

        setupNavigationBarStyle()
        setupNavBarButtons()
        
        // can provide custom code starting here
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        
        
        navigationItem.title = "Kindle App"
        
//        // create all books manually
//        setupBooks()

        fetchBooks()  // JSON FILE
        
    }
    
    // Add Footer in the UITableView
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1.0)
        
        // Add the segmentControl view in the FooterSection
        let segmentControl = UISegmentedControl(items: ["Cloud", "Device"])
        
        // Configure de segmentedControl
        segmentControl.tintColor = .white
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false  //important to add constraints

        footerView.addSubview(segmentControl)
        
        // Add constrains to the segmentControl
        segmentControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        // Add buttons in the Footer Section
        let gridButton = UIButton(type: .system)
        gridButton.setImage(#imageLiteral(resourceName: "grid").withRenderingMode(.alwaysOriginal), for: .normal)
        gridButton.translatesAutoresizingMaskIntoConstraints = false //important to add constraints
        
        footerView.addSubview(gridButton) // add to the main view (Footerview)
        
        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor,
                                         constant: 8).isActive = true
        gridButton.widthAnchor.constraint(equalToConstant: 40)
            .isActive = true
        gridButton.heightAnchor.constraint(equalToConstant: 40)
            .isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
            .isActive = true
        
        let sortButton = UIButton(type: .system)
        sortButton.setImage(#imageLiteral(resourceName: "sort").withRenderingMode(.alwaysOriginal), for: .normal)
        sortButton.translatesAutoresizingMaskIntoConstraints = false //important to add constraints
        
        footerView.addSubview(sortButton) // add to the main view (Footerview)
        
        sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor,
                                         constant: -8).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 40)
            .isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 40)
            .isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
            .isActive = true
        

        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func setupNavBarButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(handlerMenuPress))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "amazon_icon").withRenderingMode(.alwaysOriginal),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handlerIconPress))
    }
    
    func handlerMenuPress(){
        print("Menu Pressed")
    }
    func handlerIconPress(){
        print("Amazon Icon Pressed")
    }
    
    func setupNavigationBarStyle(){
        print("Setting nav bar styles")
        // Setup color to navigationBar
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255,
                                                                   green: 40/255,
                                                                   blue: 40/255,
                                                                   alpha: 1.0)
        navigationController?.navigationBar.isTranslucent = false
        
        // Set navigationBar font's color
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
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

