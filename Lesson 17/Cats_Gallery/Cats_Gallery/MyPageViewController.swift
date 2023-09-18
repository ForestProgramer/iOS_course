//
//  MyPageViewController.swift
//  Cats_Gallery
//
//  Created by Максим Оліярник on 09.04.2023.
//

import UIKit
// клас в якому містяться в'ю які перегортаються
class MyPageViewController : UIPageViewController {
   
   // масив де містяться наші в'ю з картинками
    var pages = [UIViewController]()
    // ідикатор сторінок
    let pageControl = UIPageControl()
    //початкова сторінка
    let initialPage = 0
    //змінна делегату
    var pageDelegate : SwipingPhotos?
    //змінни окремих в'ю типу CatsImageController
    var page1 : CatsImageController!
    var page2 : CatsImageController!
    var page3 : CatsImageController!
    //булівська змінна для перевірки наявності фільтра на картинці
    var isBlackAndWhite : Bool!
    //ініціалізатор пейдж в'ю контроллера, в якому ми змінюємо транзишн стайл на .scroll для зміни анімації перегортання
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //виклик функцій
        setUp()
        style()
        layout()
    }

}
//багато окремих розширень для класу MyPageViewController
extension MyPageViewController{
    
    func setUp(){
        //застосовуєм датасоурз і делегат
        dataSource = self
        delegate = self
        //додажмо функцію трекінгу для пейдж контрола
        pageControl.addTarget(self, action: #selector(pageControlTapped(_sender:)), for: .valueChanged)
        
        // ініціалізуєм три в'ю через ініціалізатор
        page1 = CatsImageController(imageName: "firstCat")
        page2 = CatsImageController(imageName: "secondCat")
        page3 = CatsImageController(imageName: "thirdCat")
        //і добавляєм їх в масив
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        // встановлюємо контроллерии для нашого UIPageViewController -a
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        // витягуєм значення поля isBlackAndWhite вибраного контроллера і записуєм в глобальну змінну isBlackAndWhite цього класу
        let currentPageViewController = self
             guard  let currentViewController = currentPageViewController.viewControllers?.first as? CatsImageController else{return}
        currentPageViewController.isBlackAndWhite = currentViewController.isBlackAndWhite
    }
    // функція для настройки зовн вигляду pageControl
    func style(){
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
    }
    // функція настройки лейаута pageControl
    func layout(){
        view.addSubview(pageControl)
        
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1)
        ])
    }
}
extension MyPageViewController {
    // функція для трекінгу pageControl і контроллерів
    @objc func pageControlTapped(_sender : UIPageControl){
        setViewControllers([pages[_sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControllsIfNeeeded()
    }
}

extension MyPageViewController : UIPageViewControllerDataSource {
    //функції датасорс , ця для визначення контроллера який буде вибраний перегорнувши назад
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {return nil}
        if currentIndex == 0{
            pageControl.currentPage = 2
            return pages.last
        }else{
            if isBlackAndWhite {
                        (viewController as? MyPageViewController)?.applyBlackAndWhiteFilter()
                    }
            return pages[currentIndex - 1]
        }
    }
    //функції датасорс , ця для визначення контроллера який буде вибраний перегорнувши вперед
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {return nil}
        if currentIndex < pages.count - 1{
            if isBlackAndWhite {
                        (viewController as? MyPageViewController)?.applyBlackAndWhiteFilter()
                    }
            return pages[currentIndex + 1 ]
        }else{
            pageControl.currentPage = 0
            return pages.first
        }
    }
}

extension MyPageViewController : UIPageViewControllerDelegate {
    // змінна вибраного контролера на pageControl при закінченні анімації
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else {return}
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else {return}
        
        pageControl.currentPage = currentIndex
        animateControllsIfNeeeded()
    }
    // функція амінації(взяв з інтернету)
    func animateControllsIfNeeeded(){
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: self.view.layoutIfNeeded, completion: nil)
    }
}

extension MyPageViewController {
    // функція перегортання контроллерів вперед
    func goToNextPage(animated : Bool = true, completion: ((Bool)->Void)? = nil) {
        guard let currentPage = viewControllers?[0] else {return}
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else {return}
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
        //виттягування значення isBlackAndWhite для того шоб знати чи ми маєм застосувати фільтр чи він вже є застосований і ми маєм його зняти
        let currentPageViewController = self
             guard  let currentViewController = self.viewControllers?.first as? CatsImageController else{return}
        currentPageViewController.isBlackAndWhite = currentViewController.isBlackAndWhite
    }
    // функція перегортання контроллерів назад
    func goToPreviousPage(animated : Bool = true, completion: ((Bool)->Void)? = nil) {
        guard let currentPage = viewControllers?[0] else {return}
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else {return}
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
        // те саме що і в попередньому тільки при гортанні назад
        let currentPageViewController = self
             guard  let currentViewController = self.viewControllers?.first as? CatsImageController else{return}
        currentPageViewController.isBlackAndWhite = currentViewController.isBlackAndWhite
    }
    
}
extension MyPageViewController {
    //додаткова функція для коректного застосування фільтру на картинці
    func applyBlackAndWhiteFilter() {
        let currentPageViewController = MyPageViewController()
            guard let currentViewController = currentPageViewController.viewControllers?.first as? CatsImageController,
                  let originalImage = currentViewController.imageView.image,
                  let blackAndWhiteImage = pageDelegate!.filterUse(to: originalImage) else { return }
        currentViewController.imageView.image = blackAndWhiteImage
    }
}

