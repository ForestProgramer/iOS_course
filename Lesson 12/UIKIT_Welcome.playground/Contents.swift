//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    //поле для вводу
    let feedbackField = UITextField()
    //степпер (+/-)
    let stepper = UIStepper(frame: CGRect(x: 145, y: 520, width: 200, height: 44))
    //слайдер
    let slider = UISlider(frame: CGRect(x: 90, y: 470, width: 200, height: 44))
    //масив відгуків для підключення елементів в таблицю
    let arrayOfReviews = ["I like it!","That`s nice!","I cant believe it!","This one special to me!","Thanks Apple for service!","At start have problems with that😅","Cant believe this is real","Really like to work with it","Thanks Apple!","The best framework!!!"]
    // таблиця
    let tableOfReviews = UITableView(frame: CGRect(x: 40, y: 200, width: 300, height: 150))
    override func loadView() {
        //основне view
        let view = UIView()
        //заданий колір
        view.backgroundColor = .white
        //лейбл (текст)
        let label = UILabel()
        //задані розміри лейблу
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        //задав тексту лейблу
        label.text = "UI Kit"
        // задав шрифт і величину його і тип
        label.font = UIFont.systemFont(ofSize: 42, weight: .heavy)
        //колір тексту
        label.textColor = .systemGreen
        // вирівеювання тексту по центру
        label.textAlignment = .center
        //кількість рядкіів в лейблі
        label.numberOfLines = 1
        // моє додаткове в'ю і зразу задав йому позицію і розміри
        let myView = UIView(frame: CGRect(x: 140, y: 140, width: 100, height: 100))
        //колір для нового в'ю
        myView.backgroundColor = .systemGreen
        //перевірив розміри в frame i bounds
        myView.frame
        myView.bounds
//використав властивість трансофрм і задава їй об'єкт такого типу і вибрав конструктор з значення rotationAngle і задава 45 градусів оборот для того щоб подивитись значення поля bounds при повороті view
        myView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
        //задав розміри для поля введення тексту
        feedbackField.frame = CGRect(x: 75, y: 400, width: 220, height: 42)
        //задав колір для поля введення
        feedbackField.backgroundColor = .white
        //задав стиль рамки для поля введення
        feedbackField.borderStyle = .roundedRect
        //задав плейсхолдер для поля введення
        feedbackField.placeholder = "Your feedback here!"
        // задав вирівння тексту по центру в полі введення
        feedbackField.textAlignment = .center
        //створив кнопку
        let feedbackbutton = UIButton()
        // задав розміри для неї
        feedbackbutton.frame = CGRect(x: 100, y: 570, width: 180, height: 44)
        // задав їй колір
        feedbackbutton.backgroundColor = .systemGreen
        //задав назву для кнопки
        feedbackbutton.setTitle("Send Feedback", for: .normal)
        //колір для тексту в кнопці
        feedbackbutton.tintColor = .white
        //заокруглив кнопку по кутам
        feedbackbutton.layer.cornerRadius = 22
        //створив імейдж в'ю і задав розміри йому
        let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 700))
        backgroundImage.image = UIImage(named: "background.jpeg")
       // задав мін і макс здачення для кроку в степпері
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        //задав крок в степері
        stepper.stepValue = 1
        //це стрічка виконує функцію valueChanged при нажиманні степпера
        stepper.addTarget(self, action: #selector(valueChanged), for: .touchUpInside)
        //задав мін і макс для слайдера
        slider.minimumValue = 0
        slider.maximumValue = 10
        //це стрічка виконує функцію valueChanged при нажиманні слайдера
        slider.addTarget(self, action: #selector(slideValueChange), for: .touchUpInside)
        //задав ширину рамки таблиці
        tableOfReviews.layer.borderWidth = 2
        //  і колір для рамки
        tableOfReviews.layer.borderColor = UIColor.green.cgColor
        // задав делегат для таблиці
        tableOfReviews.dataSource = self
        // створив другий лейбл
        let label2 = UILabel(frame: CGRect(x: 150, y: 125, width: 100, height: 100))
        //задав текст для другого лейблу
        label2.text = "Reviews"
        // задав шрифт лейблу2
        label2.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        // і колір
        label2.textColor = .white
        // додаю по черзі сабв'ю до головного в'ю, тобто наші елементи по черзі
        view.addSubview(backgroundImage)
        view.addSubview(myView)
        view.addSubview(label)
        view.addSubview(feedbackField)
        view.addSubview(feedbackbutton)
        view.addSubview(stepper)
        view.addSubview(slider)
        view.addSubview(tableOfReviews)
        view.addSubview(label2)
        self.view = view
    }
    // функція обджект сі при виконанні якій міняється int значення(текст) в середині поля введенення (text field) при нажиманні кнопки на степер
    @objc func valueChanged(){
        feedbackField.text = String(Int(stepper.value))
    }
    // функція обджект сі при виконанні якій міняється float значення(текст) в середині поля введенення (text field) при взаємодії з слайдером
    @objc func slideValueChange(){
        feedbackField.text = String(slider.value)
    }
}
//розширення нашого класу делегатом UITableViewDataSource
extension MyViewController : UITableViewDataSource{
    //повертає кількість елементів
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfReviews.count
    }
    //створює комірку в таблиці і через indexPath.row додає по черзі наші елементи з масиву
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = arrayOfReviews[indexPath.row]
        return cell
    }
    //ЗАВДАННЯ №2 БУЛО РЕАЛІЗОВАНО В ІНШОМУ ПРОЕКТІ ДЕ І РЕАЛІЗОВАНЕ ЗАВДАННЯ №3 . ТУТ ПРОСТО НЕ ЗНАВ КУДА ВЛІПИТИ ТІ ТОГЛИ І ПІКЕРИ)
    
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()



//UILABEL
////: A UIKit based Playground for presenting user interface
//
//import UIKit
//import PlaygroundSupport
//
//class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .lightGray
//
//        let label = UILabel()
//        label.frame = CGRect(x: 150, y: 200, width: 100, height: 20)
//        label.text = "Hello World!"
//        label.textColor = .black
//        label.backgroundColor = .red
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
//        label.lineBreakMode = .byTruncatingMiddle
//
//        view.addSubview(label)
//        self.view = view
//    }
//}
//// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()

//Subviews and views
////: A UIKit based Playground for presenting user interface
//
//import UIKit
//import PlaygroundSupport
//
//class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .lightGray
//
//        let myView = UIView()
//        myView.frame = CGRect(x: 10, y: 20, width: 100, height: 100)
//        myView.backgroundColor = .white
//        myView.layer.cornerRadius = 50
//
//        let myView2 = UIView()
//        myView2.frame = CGRect(x: 20, y: 60, width: 20, height: 20)
//        myView2.backgroundColor = .blue
//        myView2.layer.cornerRadius = 10
//
//        myView.addSubview(myView2)
//
//
//        view.addSubview(myView)
//        self.view = view
//    }
//}
//// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()


//UIButton

//: A UIKit based Playground for presenting user interface
  
//import UIKit
//import PlaygroundSupport
//
//class MyViewController : UIViewController {
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .lightGray
//
//        let myButton = UIButton()
//        myButton.frame = CGRect(x: 10, y: 50, width: 120, height: 44)
//        myButton.setTitle("Go", for: .normal)
//        myButton.layer.cornerRadius = 22
//        myButton.backgroundColor = .magenta
//
//        myButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//
//        myButton.isUserInteractionEnabled = true
//
//
//        view.addSubview(myButton)
//        self.view = view
//    }
//
//    @objc func buttonClicked() {
//        print("Button clicked!")
//    }
//}
//// Present the view controller in the Live View window
//PlaygroundPage.current.liveView = MyViewController()
