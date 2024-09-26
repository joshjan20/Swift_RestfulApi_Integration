//
//  Post.swift
//  Swift_RestfulApi_Integration
//
//  Created by JJ on 26/09/24.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

