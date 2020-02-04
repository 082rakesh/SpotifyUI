//
//  Section.swift
//  SpotifyLayout
//
//  Created by rakesh.e.mishra on 03/02/20.
//  Copyright © 2020 rakesh.e.mishra. All rights reserved.
//

import Foundation

struct Section {
    var title : String
    var playlists : NSArray
    init(dictionary:[String : Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.playlists = dictionary["playlists"] as? NSArray ?? []
        
}
}
