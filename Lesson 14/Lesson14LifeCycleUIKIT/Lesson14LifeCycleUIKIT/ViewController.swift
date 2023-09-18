//
//  ViewController.swift
//  Lesson14LifeCycleUIKIT
//
//  Created by Максим Оліярник on 06.03.2023.
//

// ТУТ РЕЛІЗНУВ АНІМАЦІЇ З СТАТТІ ПРО АНІМАЦІЇ (ОСТАННЯ АМІНАЦІЯ З ГРАВІТАЦІЄЮ ЧОМУСЬ НЕ ПРАЦЮВАВАЛА)
//ДОБАВИВ ЗМІНУ КОЛЬОРУ ПІД ЧАС АНІМАЦІЇ І ТАК ЩОБ АНІМАЦІЇ КРУТИЛИСЬ ПО КРУГУ ПО КЛІКАХ,ЗРОБЛЕНО ЦЕ ЧЕРЕЗ КАУНТЕР І СВІТЧ КЕЙС
//ПРІНТИ З СТЕЙТАМИ АПКИ РЕАЛІЗОВАНІ В SCENEDELEGATE.SWIFT
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    var counter : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    }

    @IBAction func didTapButton(_ sender: Any) {
        switch self.counter {
        case 0:
            let newButtonWidth : CGFloat = 150
                        
            UIView.animate(withDuration: 2.0) {
                self.button.frame = CGRect(x: 0, y: 0, width: newButtonWidth, height: newButtonWidth)
                self.button.center = self.view.center
                self.button.backgroundColor = .systemGreen
                self.button.layer.cornerRadius = 0
                self.counter += 1
            }
        case 1:
            self.button.frame = CGRect(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2, width: 0, height: 0)
                let newButtonWidth: CGFloat = 60
                UIView.animate(withDuration: 1.0,delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 1,options: UIView.AnimationOptions.curveEaseInOut,animations: ({
                    self.button.frame = CGRect(x: 0, y: 0, width: newButtonWidth, height: newButtonWidth)
                            self.button.center = self.view.center
                    self.button.layer.cornerRadius = 0
                    self.button.backgroundColor = .systemRed
                    self.counter += 1
                }),completion: nil)
        case 2:
            self.button.frame = CGRect(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2, width: 0, height: 0)
                let newButtonWidth: CGFloat = 150
                let animator = UIViewPropertyAnimator(duration:0.3, curve: .linear) { //1
                self.button.frame = CGRect(x: 0, y: 0, width: newButtonWidth, height: newButtonWidth)
                self.button.center = self.view.center
                self.button.backgroundColor = .systemBlue
            }
            animator.startAnimation() //2
            self.counter += 1
        case 3:
//            self.button.frame = CGRect(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2, width: 0, height: 0)
//                let newButtonWidth: CGFloat = 60
            UIView.animateKeyframes(withDuration: 5, //1
              delay: 0, //2
              options: .calculationModeLinear, //3
              animations: { //4
                UIView.addKeyframe( //5
                  withRelativeStartTime: 0.25, //6
                  relativeDuration: 0.25) { //7
                    self.button.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.maxY - self.button.frame.height / 2 ) //8
                    self.button.backgroundColor = .systemGray
                }

                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                    self.button.center = CGPoint(x: self.view.bounds.width - self.button.frame.width / 2 , y: self.view.bounds.height - self.button.frame.height / 2 )
                    self.button.backgroundColor = .systemPink
                }

                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                    self.button.center = self.view.center
                    self.button.backgroundColor = .systemTeal
                }
            })
            counter += 1
        case 4:
            
            self.button.frame = CGRect(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2, width: 0, height: 0)
            let oldValue = button.frame.width/2
            let newButtonWidth: CGFloat = 60

            /* Do Animations */
            CATransaction.begin() //1
            CATransaction.setAnimationDuration(2.0) //2
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)) //3

            // View animations //4
            UIView.animate(withDuration: 1.0) {
                self.button.frame = CGRect(x: 0, y: 0, width: newButtonWidth, height: newButtonWidth)
                self.button.center = self.view.center
                self.button.backgroundColor = .systemYellow
            }

            // Layer animations
            let cornerAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius)) //5
            cornerAnimation.fromValue = oldValue //6
            cornerAnimation.toValue = newButtonWidth/2 //7

            button.layer.cornerRadius = newButtonWidth/2 //8
            button.layer.add(cornerAnimation, forKey: #keyPath(CALayer.cornerRadius)) //9

            CATransaction.commit() //10
            counter = 0
            
        default:
            print("")
       
        }
    }
    
}

