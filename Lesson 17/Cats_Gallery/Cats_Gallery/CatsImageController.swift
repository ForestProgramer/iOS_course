//
//  ViewController3.swift
//  Cats_Gallery
//
//  Created by Максим Оліярник on 09.04.2023.
//

import UIKit
// контроллер який містить в'ю з картинками
class CatsImageController: UIViewController {
    // імедж в'ю змінна
    let imageView :UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    // змінна для збереження початкового зображення (оригіналу без фільтрів)
    var startImage : UIImage!
    // булівська змінна для визначення застосування фільтру або його відстуність
    var isBlackAndWhite : Bool!
    // ініціалізатор для додавання картинок в імедж в'ю
    init(imageName : String) {
        super.init(nibName: nil, bundle: nil)
        startImage = UIImage(named: imageName)
        imageView.image = startImage
        isBlackAndWhite = false
       
    }
    // обо'язковий ініцалізор при помилці
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        layout()
    }
    

}
//функція лейауту з констретами зображення на в'ю
extension CatsImageController{
    func layout(){
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
