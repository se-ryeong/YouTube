//
//  DetailViewController.swift
//  YouTubeApp
//
//  Created by SeoJunYoung on 2023/09/04.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = detailView
    }

}
