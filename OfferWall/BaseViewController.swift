//
//  BaseViewController.swift
//  OfferWall
//
//  Created by Ваге Базикян on 30.12.2020.
//

import UIKit

enum ViewState {
    case viewDidLoad
    case showText(String)
    case showURL(String)
    case inProgress
}

class BaseViewController: UIViewController {
    
    let loader = UIActivityIndicatorView()
    
    func createLoader(){
        loader.center = self.view.center
        loader.style = .large
        loader.hidesWhenStopped = true
        loader.color = .darkGray
        loader.startAnimating()
        loader.hidesWhenStopped = false
        view.addSubview(loader)
    }
    
    func loaderStop() {
        self.loader.hidesWhenStopped = true
        self.loader.stopAnimating()
    }
    
    func updateView(viewState: ViewState) {
        switch viewState {
        case .inProgress:
            createLoader()
        default:
            loaderStop()
        }
    }
}
