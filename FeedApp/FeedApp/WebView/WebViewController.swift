//
//  WebViewController.swift
//  FeedApp
//
//  Created by Domagoj on 16.09.2021..
//

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {

    private let viewModel: WebViewModel

    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title

        let webView = WKWebView()
        view.addSubview(webView)
        webView.pinEdges(to: view)

        if let request = viewModel.urlRequest {
            webView.load(request)
        }
    }
}
