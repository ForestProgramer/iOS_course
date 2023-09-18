//
//  ViewController.swift
//  Cats_Gallery
//
//  Created by Максим Оліярник on 02.04.2023.
//
//Реалізований протокол для утворення зв'зку через делегат між головним контролеерром(цим) і UIPageViewController-ом
protocol SwipingPhotos{
    //функція яка передає команду перегортання вперед
    func swipeNext()
    //функція яка передає команду перегортання назад
    func swipeBack()
    //функція для задання фільтру на картинках при нажиманні кнопки
    func filterUse(to image: UIImage) -> UIImage?
    //функція для перевірки поля isBlackAndWhite класу CatsImageController для зняття фільтра при повторному кліку на кнопку
    func setFilter()
}

import UIKit

class ViewController: UIViewController {
//екземпляр класу UIPageViewController-a
    var pageViewController: MyPageViewController?
    //булівська змінна для перевірки наявності фільтра на фото
    var isBlackAndWhite : Bool! = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // функція підготовки зв'язку між двлма контроллерами

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageVC = segue.destination as? MyPageViewController {
                   self.pageViewController = pageVC
            self.pageViewController?.pageDelegate = self
               }
    }

// айбі екшн на копнку NEXT
    @IBAction func nextTapped(_ sender: Any) {
        // виклик функцій протоколу через делегат змінну
        pageViewController?.pageDelegate?.swipeNext()
        pageViewController?.pageDelegate?.setFilter()
    }
    // айбі екшн на копнку PREVIOUS
    @IBAction func previousTapped(_ sender: Any) {
        // виклик функцій протоколу через делегат змінну
        pageViewController?.pageDelegate?.swipeBack()
        pageViewController?.pageDelegate?.setFilter()
    }
    // айбі екшн на копнку Black and White
    @IBAction func tappedBlackAndWhite(_ sender: Any) {
        // опшинал байдінг для розгортання опціональної змінни
        guard let IsFiltered = isBlackAndWhite else{return}
        if IsFiltered {
                    // Показуємо оригінальне зображення
                    print("Enter Origin")
                    guard let currentPageViewController = pageViewController,
                          let currentViewController = currentPageViewController.viewControllers?.first as? CatsImageController,
                          let originalImage = currentViewController.startImage else { return }
            print("Fetched Origin")
            currentViewController.imageView.image = originalImage
            currentViewController.isBlackAndWhite = false
            isBlackAndWhite = currentViewController.isBlackAndWhite
                } else {
                    // Застосовуємо чорно-білий фільтр
                    guard let currentPageViewController = pageViewController,
                          let currentViewController = currentPageViewController.viewControllers?.first as? CatsImageController,
                          let originalImage = currentViewController.imageView.image,
                          let blackAndWhiteImage = filterUse(to: originalImage) else { return }
                    print("Fetched successfully")
                    currentViewController.imageView.image = blackAndWhiteImage
                    currentViewController.isBlackAndWhite = true
                    isBlackAndWhite = currentViewController.isBlackAndWhite
                }
    }
}

//розширення класу ViewController протоколом SwipingPhotos
extension ViewController : SwipingPhotos{
    //реалізаці методів протоколу
    func swipeNext() {
        pageViewController?.pageControl.currentPage += 1
        pageViewController?.goToNextPage()
        pageViewController?.animateControllsIfNeeeded()
    }
    
    func swipeBack() {
        pageViewController?.pageControl.currentPage -= 1
        pageViewController?.goToPreviousPage()
        pageViewController?.animateControllsIfNeeeded()
    }
    func filterUse(to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image) else { return nil }
        let filter = CIFilter(name: "CIPhotoEffectMono")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        guard let outputCIImage = filter?.outputImage else { return nil }
        let context = CIContext()
        guard let outputCGImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return nil }
        return UIImage(cgImage: outputCGImage)
    }
    func setFilter(){
        isBlackAndWhite = pageViewController!.isBlackAndWhite
        
    }

}

//extension ViewController : UIPageViewControllerDelegate{
//    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
//        .min
//    }
//    
//}
