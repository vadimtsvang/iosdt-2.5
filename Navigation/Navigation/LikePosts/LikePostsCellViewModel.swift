//
//  LikePostsCellViewModel.swift
//  Navigation
//
//  Created by Vadim on 04.08.2022.
//

import Foundation

struct LikePostsCellViewModel {

    var post: LikePosts

    var title: String {
        return post.title
    }

    var description: String {
        return post.description
    }

    var image: String {
        return post.image
    }
    var likes: UInt {
        return UInt(post.likes)
    }

    var views: UInt {
        return UInt(post.views)
    }
    
    var author: String {
        return post.author
    }
}
