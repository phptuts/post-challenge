//
//  PostViewController.swift
//  PostJasonChallenge
//
//  Created by Noah Glaser on 2/1/22.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: PostDetail?

    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let postDetail = post else {
            fatalError("No post detail")
        }
        
        title = postDetail.title.title(upTo: 15)
        bodyLabel.text = postDetail.body
        commentLabel.text = "Comments: \(postDetail.numberOfComments)"
        authorLabel.text = "Author: \(postDetail.authorName)"
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
