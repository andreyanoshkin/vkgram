//
//  LoginFormController.swift
//  LoginForm
//
//  Created by Andrey on 30/07/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import WebKit
//import FirebaseAuth

class LoginFormViewController: UIViewController {
    
    var webView: WKWebView = {
        let view = WKWebView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        }()
    
    var authService = AuthService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(webView)
        webView.pin(to: self.view)
        webView.navigationDelegate = self
        
        let credentialsRequest = authService.getLoginForm()
        webView.load(credentialsRequest)
        
    }
    
}

extension LoginFormViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        
        let userId = params["user_id"]
        
        ApiManager.session.token = token!
        
        ApiManager.session.userId = userId!
        
        let tabBarController = MainTabBarViewController()
        
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true, completion: nil)
        
        decisionHandler(.cancel)
    }
}
