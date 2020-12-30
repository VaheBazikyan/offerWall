//
//  ViewController.swift
//  OfferWall
//
//  Created by Ваге Базикян on 29.12.2020.
//

import UIKit
import WebKit

enum ContentType: String {
    case text = "text"
    case webView = "webview"
    case game = "game"
}

class ViewController: BaseViewController {
    
    @IBOutlet weak var contentLbl: UILabel!
    
    private lazy var webView: WKWebView =  {
        let webView = WKWebView()
        return webView
    }()
    
    private var currentProduct: Int = 0
    private var model: [Product] = []
    var nemtworking = Networking()

    override func viewDidLoad() {
        super.viewDidLoad()
        nemtworking.getProducts { (products) in
            self.model = products
        }
    }
    
    override func updateView(viewState: ViewState) {
        super.updateView(viewState: viewState)
        switch viewState{
        case .showText(let text):
            setText(text: text)
        case .showURL(let url):
            self.createWebView(url)
        default:
            break
        }
    }
    
   private func createWebView(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        self.contentLbl.isHidden = true
        webView.frame = self.view.bounds
        webView.load(request)
        self.view.insertSubview(webView, at: 0)
    }
    
   private func setText(text: String) {
        self.contentLbl.isHidden = false
        webView.removeFromSuperview()
        self.contentLbl.text = text
    }
    
    @IBAction func contionueBtnAction(_ sender: Any) {
        getArticle()
    }
}

extension ViewController {
    func getArticle() {
        updateView(viewState: .inProgress)
        nemtworking.getArticle(id: model[currentProduct].id) { (article) in
            self.currentProduct.incr()
            switch article.type {
            case ContentType.text.rawValue:
                self.updateView(viewState: .showText(article.contents ?? ""))
            case ContentType.webView.rawValue:
                self.updateView(viewState: .showURL(article.url ?? ""))
            case ContentType.game.rawValue:
                self.currentProduct = 0
                self.getArticle()
            default:
                break
            }
            
        }
    }
}
