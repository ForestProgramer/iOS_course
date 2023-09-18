//
//  ViewController.swift
//  Lesson17_2
//
//  Created by Максим Оліярник on 02.04.2023.
//https://www.appcoda.com/grand-central-dispatch/

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        simpleQueues()
//        simpleQueuesWithQos()
//        concurrentQueues()
//        if let queue = inactiveQueue {
//            queue.activate()
//        }
//        queueWithDelay()
//        accessingMainAndGlobal()
        fetchImage()
    }
    override func viewDidAppear(_ animated: Bool) {
//        queueWorkItem()
    }

//приклад звичайної черги асинхронно
    func simpleQueues(){

        let queue = DispatchQueue(label: "com.appcoda.myqueue")
        queue.async {
            for i in 0..<10{
                print("🛑", i)
            }
        }
        for i in 100..<110 {
            print("Ⓜ️", i)
        }
    }
//виконанн черги з пріорітетами
//    userInteractive
//    userInitiated
//    default
//    utility
//    background
//    unspecified
    func simpleQueuesWithQos(){
        let queue1 = DispatchQueue(label: "com.appcoda.queue1",qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.appcoda.queue2",qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 0..<10{
                print("🛑", i)
            }
        }
        queue2.async {
            for i in 100..<110 {
                print("🔵", i)
            }
        }
        for i in 1000..<1010 {
            print("Ⓜ️", i)
        }
         
    }
    
//паралельні черги
    var inactiveQueue : DispatchQueue!
    func concurrentQueues(){
        let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility, attributes: [.concurrent, .initiallyInactive])
        inactiveQueue = anotherQueue
        anotherQueue.async {
            for i in 0..<10{
                print("🔴", i)
            }
        }
        anotherQueue.async {
            for i in 100..<110 {
                print("🔵", i)
            }
        }
        anotherQueue.async {
            for i in 1000..<1010 {
                print("⚫️", i)
            }
        }
    }
// черга з затримкою в часі
    func queueWithDelay(){
        let delayQueue = DispatchQueue(label: "com.appcoda.delayqueue",qos: .userInitiated)
        let additionalTime: DispatchTimeInterval = .seconds(2)
        
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print(Date())
        }
    }
// доступ до головної і глобальної черги
    func accessingMainAndGlobal(){
        let globalQueue = DispatchQueue.global(qos: .userInitiated)
        
        globalQueue.async {
            for i in 0..<10{
                print("🔴", i)
            }
        }
    }
//діставання зображення за допомогою url
    func fetchImage() {
        let imageURL: URL = URL(string: "https://upload.wikimedia.org/wikipedia/uk/4/47/FC_Barcelona.png?20100206221457")!
     
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
     
            if let data = imageData {
                print("Did download image data")
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
               
            }
        }).resume()
    }
// використання DispatchWorkItem об'єктів
    func queueWorkItem(){
        var value = 10
         
            let workItem = DispatchWorkItem {
                value += 5
            }
         
            workItem.perform()
         
            let queue = DispatchQueue.global(qos: .utility)
         
            queue.async(execute: workItem)
         
            workItem.notify(queue: DispatchQueue.main) {
                print("value = ", value)
            }
    }

}

