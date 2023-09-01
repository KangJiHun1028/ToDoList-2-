//
//  ViewController.swift
//  ToDoList
//
//  Created by t2023-m0053 on 2023/08/30.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")
        image.load(url: url!)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
