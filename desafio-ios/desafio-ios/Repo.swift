//
//  Repo.swift
//  desafio-ios
//
//  Created by Jean Carlos on 10/16/16.
//  Copyright © 2016 Jean Carlos. All rights reserved.
//

import Foundation

extension String{
    var userName:String{
        return components(separatedBy: "/").first ?? ""
    }
}

struct Repo {
    let id:Int
    let nameRepo:String //Nome do repositório;
    let full_name:String //UserName + Nome do repositório;
    let userName:String
    let description:String //Descrição do respositório;
    let avatar_url:String //Avatar do usuário/autor do PR (se tiver);
}

enum SerializationError:Error {
    case missing(String)
}

extension Repo {
    init?(json:[String:Any]) throws {
        
        guard let id = json["id"] as? Int else {
            throw SerializationError.missing("id")
        }
        
        guard let nameRepo = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let full_name = json["full_name"] as? String else {
            throw SerializationError.missing("full_name")
        }
        
        guard let description = json["description"] as? String else {
            throw SerializationError.missing("description")
        }
        
        guard let ownerJson = json["owner"] as? [String:Any] else {
            throw SerializationError.missing("owner for getting avatar")
        }
        
        guard let avatar_url = ownerJson["avatar_url"] as? String else {
            throw SerializationError.missing("avatar_url")
        }

        self.id = id
        self.nameRepo = nameRepo
        self.full_name = full_name
        self.userName = full_name.userName
        self.description = description
        self.avatar_url = avatar_url
    }
}
