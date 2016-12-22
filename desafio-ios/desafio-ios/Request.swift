//
//  Request.swift
//  desafio-ios
//
//  Created by Jean Carlos on 10/16/16.
//  Copyright © 2016 Jean Carlos. All rights reserved.
//

import Foundation

typealias ReposResponse = [String:Any]

let repoUrlString = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"

let session = URLSession.shared
(session.dataTask(with: URL(string:repoUrlString) { (data, reponse, error) in
    
    // Tratamento de erro;
    guard error == nill else { return }
    
    do {
        
        if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? ReposResponse {
            
            // O array de repositórios se encontra na chave "itens" do JSON, portanto, precisamos pegá-lo antes;
            guard let reposJson = json["items"] as? [ReposResponse] else { return }
            
            DispatchQueue.main.async {
                
                let tv
                
            }
        }
        
    }
    
    
})




)
