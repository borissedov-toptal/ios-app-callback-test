//
//  ViewController.swift
//  ios-app-callback-test
//
//  Created by Boris Sedov on 08.11.2019.
//  Copyright © 2019 Boris Sedov. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.uiDelegate = self
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "http://ios-app-callback-test.s3-website.us-east-2.amazonaws.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let uuid = UUID().uuidString
        let js = "js_app_call('\(uuid)')"
        webView.evaluateJavaScript(js)
    }
    
}

extension ViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
        completionHandler()
    }
    
}

