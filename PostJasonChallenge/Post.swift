//
//  Post.swift
//  PostJasonChallenge
//
//  Created by Noah Glaser on 2/1/22.
//

import Foundation
import Alamofire

struct Post: Codable {
    let title: String
    let body: String
    let id: Int
    let userId: Int
}

struct Author: Codable {
    var id: Int
    var name: String
}

struct Comment: Codable {
    var id: Int
    var postId: Int
}

struct PostDetail {
    
    init (post: Post, author: Author, numberOfComments: Int) {
        self.title = post.title
        self.body = post.body
        self.authorName = author.name
        self.numberOfComments = numberOfComments
    }
    
    var title: String
    var body: String
    var authorName: String
    var numberOfComments: Int
}

func getPosts() async throws -> [Post] {
 return try await AF.request("http://jsonplaceholder.typicode.com/posts").serializingDecodable([Post].self).value

}

func getPostDetail(post: Post) async throws -> PostDetail {
    let comments = try await getComments(postId: post.id)
    let author = try await getAuthor(id: post.userId)
    
    return PostDetail(post: post, author: author, numberOfComments: comments.count)
}

func getAuthor(id: Int) async throws -> Author {
    return try await AF.request("http://jsonplaceholder.typicode.com/users/\(id)").serializingDecodable(Author.self).value
}

func getComments(postId: Int) async throws -> [Comment] {
    return try await AF.request("http://jsonplaceholder.typicode.com/posts/\(postId)/comments").serializingDecodable([Comment].self).value

}

extension String {
    
    func title(upTo: Int) -> String {
        let offset = self.count > upTo ? upTo : self.count;
        
        var title = String(self.prefix(upTo: self.index(self.startIndex, offsetBy: offset)))
        if self.count > upTo {
            title = "\(title) ..."
        }
        
        return title
    }
}
