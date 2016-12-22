//
//  ViewController.swift
//  desafio-ios
//
//  Created by Jean Carlos on 10/6/16.
//  Copyright © 2016 Jean Carlos. All rights reserved.
//

import UIKit
//import PINRemoteImage


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Outlets;
    @IBOutlet weak var tableView: UITableView!
    
    // Variáveis de controle;
    var repoList = [Repo]()
    
    // Função que faz o request na API do github;
    func request() {
        typealias ReposResponse = [String:Any]
        
        let repoUrlString = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1"
        
        let session = URLSession.shared
        (session.dataTask(with: URL(string:repoUrlString)!) { [weak self] (data, reponse, error) in
            
            //MARK: Tratamento de erro;
            guard error == nil else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? ReposResponse {
                    
                    // O array de repositórios se encontra na chave "itens" do JSON, portanto, precisamos pegá-lo antes;
                    guard let reposJson = json["items"] as? [ReposResponse] else { return }
                    
                    do {
                        self?.repoList = try reposJson.flatMap(Repo.init)

                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                        
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
//            tableView.reloadData()
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustonTableViewCell
        
        let meuObjetoRepo:Repo = repoList[indexPath.row] as Repo
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: NSURL(string: meuObjetoRepo.avatar_url) as! URL)
            DispatchQueue.main.async {
                cell.imgAvatar.image = UIImage(data: data!)
            }
        }
        
        cell.lblRepoName.text = repoList[indexPath.row].nameRepo
        cell.lblDescription.text = repoList[indexPath.row].description
        cell.lblUserName.text = repoList[indexPath.row].userName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoList.count
    }

    //MARK: PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let repoDetailVC = segue.destination as? RepoDetailViewController else { return }
        guard let cell = sender as? UITableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        repoDetailVC.prCreator = repoList[indexPath.row].userName
        repoDetailVC.prRepository = repoList[indexPath.row].nameRepo
    }

}

