//
//  Posts.swift
//  MobileAcebook
//
//  Created by Alice Birkett on 11/10/2023.
//

import Foundation

public struct Posts: Codable {
    let posts: [Post]
    let token: String
}
public struct Post: Codable {
    let _id: String
    let comments: Int
    let createdAt: String
    let createdBy: String
    let image: String
    let likes: [String]
    let message: String
}
