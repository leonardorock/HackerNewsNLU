//
//  NewsArticlesTableViewController.swift
//  HackerNewsNLU
//
//  Created by Leonardo Oliveira on 04/03/19.
//  Copyright © 2019 Leonardo Oliveira. All rights reserved.
//

import UIKit

class NewsArticlesTableViewController: UITableViewController {

    lazy var service = NewsArticlesService()
    
    var articles: [NewsArticles] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.getArticles(success: { [weak self] (articles) in
            self?.articles = articles
        }, failure: { [weak self] (error) in
            self?.present(error: error)
        }, completion: {})
    }

    func present(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.id?.description
        cell.detailTextLabel?.text = article.title
        return cell
    }

}
