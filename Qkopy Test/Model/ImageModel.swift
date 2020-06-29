//
//  ImageModel.swift
//  Qkopy Test
//
//  Created by user on 26/06/20.
//  Copyright © 2020 user. All rights reserved.
//

import Foundation
struct ImageModel : Codable {
    let data : [Data]?
    let success : Bool?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case data = "data"
        case success = "success"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([Data].self, forKey: .data)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
struct Data : Codable {
    let id : String?
    let title : String?
    let description : String?
    let datetime : Int?
    let type : String?
    let animated : Bool?
    let width : Int?
    let height : Int?
    let size : Int?
    let views : Int?
    let bandwidth : Int?
    let vote : String?
    let favorite : Bool?
    let nsfw : String?
    let section : String?
    let account_url : String?
    let account_id : Int?
    let is_ad : Bool?
    let in_most_viral : Bool?
    let has_sound : Bool?
    let tags : [String]?
    let ad_type : Int?
    let ad_url : String?
    let edited : String?
    let in_gallery : Bool?
    let deletehash : String?
    let name : String?
    let link : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case description = "description"
        case datetime = "datetime"
        case type = "type"
        case animated = "animated"
        case width = "width"
        case height = "height"
        case size = "size"
        case views = "views"
        case bandwidth = "bandwidth"
        case vote = "vote"
        case favorite = "favorite"
        case nsfw = "nsfw"
        case section = "section"
        case account_url = "account_url"
        case account_id = "account_id"
        case is_ad = "is_ad"
        case in_most_viral = "in_most_viral"
        case has_sound = "has_sound"
        case tags = "tags"
        case ad_type = "ad_type"
        case ad_url = "ad_url"
        case edited = "edited"
        case in_gallery = "in_gallery"
        case deletehash = "deletehash"
        case name = "name"
        case link = "link"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        datetime = try values.decodeIfPresent(Int.self, forKey: .datetime)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        animated = try values.decodeIfPresent(Bool.self, forKey: .animated)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        bandwidth = try values.decodeIfPresent(Int.self, forKey: .bandwidth)
        vote = try values.decodeIfPresent(String.self, forKey: .vote)
        favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
        nsfw = try values.decodeIfPresent(String.self, forKey: .nsfw)
        section = try values.decodeIfPresent(String.self, forKey: .section)
        account_url = try values.decodeIfPresent(String.self, forKey: .account_url)
        account_id = try values.decodeIfPresent(Int.self, forKey: .account_id)
        is_ad = try values.decodeIfPresent(Bool.self, forKey: .is_ad)
        in_most_viral = try values.decodeIfPresent(Bool.self, forKey: .in_most_viral)
        has_sound = try values.decodeIfPresent(Bool.self, forKey: .has_sound)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        ad_type = try values.decodeIfPresent(Int.self, forKey: .ad_type)
        ad_url = try values.decodeIfPresent(String.self, forKey: .ad_url)
        edited = try values.decodeIfPresent(String.self, forKey: .edited)
        in_gallery = try values.decodeIfPresent(Bool.self, forKey: .in_gallery)
        deletehash = try values.decodeIfPresent(String.self, forKey: .deletehash)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        link = try values.decodeIfPresent(String.self, forKey: .link)
    }
    
}
