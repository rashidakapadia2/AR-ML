//
//  ViewController.swift
//  NotificationObservers
//
//  Created by Apple on 21/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var Btn: UIButton!
    
    var lblValue: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tearDownObserver()
    }

    func setUpObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(incrementingCount), name: Notification.Name(NotificationString.incrementCount.rawValue), object: nil)
    }
    func callingObserver() -> Notification {
        let notification = Notification(name: Notification.Name.incrementCount, object: userArr)
       return notification
    }
    func tearDownObserver() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.incrementCount, object: userArr)
    }
    
    @objc func incrementingCount(notification: Notification) {
//        lblCount.text = "\(lblValue)"
        let dataToo = notification.object as? [User]
        if let count = dataToo?.count, lblValue < count {
            lblCount.text = dataToo?[lblValue].name
            lblValue += 1
        }
    }
    
    @IBAction func btnTapped(_ sender: Any) {
//        NotificationCenter.default.post(name: Notification.Name.incrementCount, object: nil)
        NotificationCenter.default.post(callingObserver())
    }
}

