//
//  HapticsManager.swift
//  PeopleApp
//
//  Created by LuciaDecode on 20.12.2022..
//

import Foundation
import UIKit

class HapticManager {
    static let shared = HapticManager()
    private let feedback = UINotificationFeedbackGenerator()
    
    private init() { }
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
    }
}
func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
        HapticManager.shared.trigger(notification)
    }
    // in user defaults if the boolean value for the key is true then we should trigger the haptic notification
}
