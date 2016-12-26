//
//  WebViewViewController.swift
//  desafio-ios
//
//  Created by Jean Carlos on 12/26/16.
//  Copyright © 2016 Jean Carlos. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var prWebView: UIWebView!
    
    //MARK: Properties
    var prWebViewCreator: String?
    var prWebViewRepository: String?
    var prWebViewNumber: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let prWebViewCreator = prWebViewCreator, let prWebViewRepository = prWebViewRepository, let prWebViewNumber = prWebViewNumber{
            
            let webViewURL = URL(string: "https://github.com/\(prWebViewCreator)/\(prWebViewRepository)/pull/\(prWebViewNumber)")
            let request = URLRequest(url: webViewURL!)
            self.prWebView.loadRequest(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
