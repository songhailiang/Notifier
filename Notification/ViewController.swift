//
//  ViewController.swift
//  Notification
//
//  Created by songhailiang on 28/03/2018.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        Notifier.register(.login, to: self, selector: #selector(handleNotification(_:)))
        Notifier.register(.keyboardWillShow, to: self, selector: #selector(handleKeyboardWillShow(_:)))
        Notifier.register(.keyboardWillHide, to: self, selector: #selector(handleKeyboardWillHide(_:)))
    }

    deinit {
        Notifier.unregister(.login, from: self)
        Notifier.unregister(.keyboardWillShow, from: self)
        Notifier.unregister(.keyboardWillHide, from: self)
    }

    @objc func handleNotification(_ notification: Notification) {
        let success: Bool = notification.value(for: .result) ?? false
        let name: String = notification.value(for: .name) ?? ""
        print("notification: \(success) ---- \(name)")
    }

    @objc func handleKeyboardWillShow(_ notification: Notification) {
        print("\(#function)")
    }

    @objc func handleKeyboardWillHide(_ notification: Notification) {
        print("\(#function)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

