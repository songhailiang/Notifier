//
//  Notification.swift
//  Notification
//
//  Created by songhailiang on 28/03/2018.
//

import Foundation

/**
 The name of Notification
 Change this as you like.
 You can also manually set a value, this is very usefull if you want to receive a notification from system or other frameworks
 */
public enum NotifierName: String {
    case login
    case logout
    case registration = "NotificationKeyRegistration"

    // system notifications
    case keyboardWillShow
    case keyboardDidShow
    case keyboardWillHide
    case keyboardDidHide

    var notificationName: Notification.Name {
        switch self {
        case .keyboardWillShow:
            return Notification.Name.UIKeyboardWillShow
        case .keyboardDidShow:
            return Notification.Name.UIKeyboardDidShow
        case .keyboardWillHide:
            return Notification.Name.UIKeyboardWillHide
        case .keyboardDidHide:
            return Notification.Name.UIKeyboardDidHide
        default:
            return Notification.Name(rawValue: self.rawValue)
        }
    }
}

/**
 This is used to set\get key:value data to Notification
 Change it as you like
 */
public enum NotifierKey: String {
    case result
    case name
}

public extension Notification {
    
    /// To get a value from userInfo
    /// e.g. let success: Bool? = notification.value(for: .result)
    ///
    /// - Parameter key: see NotifierKey enum
    /// - Returns: value or nil
    public func value<T>(for key: NotifierKey) -> T? {
        guard let v = self.userInfo?[key] as? T else {
            return nil
        }
        return v
    }
}

/**
 More easier to use NotificationCenter
 */
public class Notifier {

    private init() {}

    /// register a notification to an observer
    ///
    /// - Parameters:
    ///   - name: notification name defined in NotifierName enums
    ///   - observer: notification observer
    ///   - selector: notification handle function
    public static func register(_ name: NotifierName, to observer: Any, selector: Selector) {
        unregister(name, from: observer) // to avoid added multi times
        NotificationCenter.default.addObserver(observer, selector: selector, name: name.notificationName, object: nil)
    }

    /// remove a notification from an observer
    ///
    /// - Parameters:
    ///   - name: notification name defined in NotifierName enums
    ///   - observer: notification observer
    public static func unregister(_ name: NotifierName, from observer: Any) {
        NotificationCenter.default.removeObserver(observer, name: name.notificationName, object: nil)
    }

    /// post a notification with some values
    ///
    /// - Parameters:
    ///   - name: notification name defined in NotifierName enums
    ///   - value: a dictionary value passed to the notification
    public static func post(_ name: NotifierName, value: [NotifierKey: Any]? = nil) {
        NotificationCenter.default.post(name: name.notificationName, object: nil, userInfo: value)
    }
}
