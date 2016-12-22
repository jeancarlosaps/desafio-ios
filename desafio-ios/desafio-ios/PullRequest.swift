//
//  PullRequest.swift
//  desafio-ios
//
//  Created by Jean Carlos on 12/15/16.
//  Copyright © 2016 Jean Carlos. All rights reserved.
//

import Foundation

struct PullRequest {
        //PR
        let title:String //Título do PR
        let login:String //Nome do autor do PR
        let avatar_URL_PR:String //Avatar do usuário/autor do PR (se tiver);
        let body:String //Body do PR
        let createdAt:String //Data do PR
}

enum SerializationErrorPR:Error {
    case missing(String)
}

extension PullRequest{
    init?(json:[String:Any])throws {
        guard let title = json["title"] as? String else{
            throw SerializationErrorPR.missing("title")
        }
        
        guard let userJson = json["user"] as? [String:Any] else{
            throw SerializationErrorPR.missing("user for get login and avatar")
        }
        
        guard let login = userJson["login"] as? String else{
            throw SerializationErrorPR.missing("login")
        }
        
        guard let avatar_URL_PR = userJson["avatar_url"] as? String else{
            throw SerializationErrorPR.missing("avatar_URL_PR")
        }
        
        guard let body = json["body"] as? String else{
            throw SerializationErrorPR.missing("body")
        }
        
        guard let createdAt = json["created_at"] as? String else{
            throw SerializationErrorPR.missing("createdAt")
        }
        
        //PR
        self.title = title
        self.login = login
        self.avatar_URL_PR = avatar_URL_PR
        self.body = body
        self.createdAt = createdAt
    }
}
