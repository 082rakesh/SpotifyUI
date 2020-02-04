//
//  playlist.swift
//  SpotifyLayout
//
//  Created by rakesh.e.mishra on 03/02/20.
//  Copyright © 2020 rakesh.e.mishra. All rights reserved.
//
import Foundation

struct PlayList {
    var title: String
    var image : String
    init(dictionary : [String : Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.image = dictionary["image"] as? String ?? ""
    }
}
