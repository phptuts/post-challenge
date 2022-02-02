//
//  ViewController.swift
//  PostJasonChallenge
//
//  Created by Noah Glaser on 1/29/22.
//

import UIKit
import Alamofire

class ViewController: UITableViewController {

    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                posts = try await getPosts()
                tableView.reloadData()
            } catch {
                navigateToErrorPage()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "post") else {
            fatalError("No Cell for table view :(")
        }
        cell.textLabel?.text = posts[indexPath.row].title
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "post_detail_view") as? PostViewController else { return }
        
        Task {
            [weak self] in
            
            guard let listOfPosts = self?.posts else { return }
            do {
                let postDetail = try await  getPostDetail(post: listOfPosts[indexPath.row])
                vc.post = postDetail
                navigationController?.pushViewController(vc, animated: true)
            } catch {
                navigateToErrorPage()
            }
        }
    }
    
    func navigateToErrorPage() {
        print("ERROR ERROR")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "error_view") else {
            fatalError("Bad view id")
        }
        navigationController?.pushViewController(vc, animated: true)

    }
}

