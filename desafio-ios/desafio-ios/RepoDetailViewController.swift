//
//  RepoDetailViewController.swift
//  desafio-ios
//
//  Created by Jean Carlos on 10/24/16.
//  Copyright © 2016 Jean Carlos. All rights reserved.
// //"https://api.github.com/repos/%3Ccriador%3E/%3Creposit%C3%B3rio%3E/pulls"

import UIKit

class RepoDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var tableViewRepoDetail: UITableView!
    
    // Variáveis de controle;
    var pullRequestList = [PullRequest]()
    
    // MARK: Properties
    var prCreator: String?
    var prRepository: String?
    
    //Função que faz o request da API do GitHub contendo os pull requests
    func request() {
        typealias PullRequestResponse = [String:Any]
        if let prCreator = prCreator, let prRepository = prRepository{
            
            let urlPullRequest = "https://api.github.com/repos/\(prCreator)/\(prRepository)/pulls"
            
            print(urlPullRequest)
            
            let session = URLSession.shared
            (session.dataTask(with: URL(string:urlPullRequest)!) { [weak self] (data, reponse, error) in
                
                //MARK: Tratamento de erro;
                guard error == nil else { return }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [PullRequestResponse] {
                        
                        //;
                        //guard let pullRequestJson = json as? [PullRequestResponse] else { return }
                        
                        do {
                            self?.pullRequestList = try json.flatMap(PullRequest.init)
                            
                            DispatchQueue.main.async {
                                self?.tableViewRepoDetail.reloadData()
                            }
                            
                            print(self?.pullRequestList.count)
                        } catch let error {
                            print(error)
                        }
                        
                    } else {
                        print("Wrong format")
                    }
                    
                } catch let error {
                    print(error)
                }
                
            }).resume()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Métodos de UITableViewDelegate e UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        DispatchQueue.main.async {
//            self.tableViewRepoDetail.reloadData()
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustonTableViewCellDetail
        
        let meuObjetoPR:PullRequest = pullRequestList[indexPath.row] as PullRequest
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: NSURL(string: meuObjetoPR.avatar_URL_PR) as! URL)
            cell.imgAvatarPR.image = UIImage(data: data!)
        }
        
        cell.lblTittlePR.text = pullRequestList[indexPath.row].title
        cell.lblLoginPR.text = pullRequestList[indexPath.row].login
        cell.lblBodyPR.text = pullRequestList[indexPath.row].body
        cell.lblDatePR.text = pullRequestList[indexPath.row].createdAt
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequestList.count
    }
}
