//
//  NSUserDefault+Extension.swift
//  HeyTaxi
//
//  Created by Trương Thắng on 2/22/17.
//  Copyright © 2017 Trương Thắng. All rights reserved.
//

import Foundation


extension Double {
    func saveToUserDefaults(withKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: key)
        defaults.synchronize()
    }
    static func loadFromUserDefaults(withKey key: String) -> Double {
        let defaults = UserDefaults.standard
        return defaults.double(forKey:key)
    }
}

extension Float {
    func saveToUserDefaults(withKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: key)
        defaults.synchronize()
    }
    static func loadFromUserDefaults(withKey key: String) -> Float {
        let defaults = UserDefaults.standard
        return defaults.float(forKey: key)
    }
}

extension Bool {
    func saveToUserDefaults(withKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: key)
        defaults.synchronize()
    }
    static func loadFromUserDefaults(withKey key: String) -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: key)
    }
}

extension String {
    func saveToUserDefaults(withKey key: String) {
        let defaults = UserDefaults.standard
        if String.loadFromUserDefaults(withKey: key) != "" {
            defaults.set(nil, forKey: key)
        }
        defaults.set(self, forKey: key)
        defaults.synchronize()
    }
    static func loadFromUserDefaults(withKey key: String) -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key) ?? ""
    }
    
}

extension URL {
    func saveToUserDefaults(withKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: key)
        defaults.synchronize()
    }
    static func loadFromUserDefaults(withKey key: String) -> URL? {
        let defaults = UserDefaults.standard
        return defaults.url(forKey: key)
    }
    
}

extension NSData {
    func saveToUserDefaults(withKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: key)
        defaults.synchronize()
    }
    static func loadFromUserDefaults(withKey key: String) -> Data? {
        let defaults = UserDefaults.standard
        return defaults.data(forKey: key)
    }
}

extension Int {
    func saveToUserDefaults(withKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(self, forKey: key)
        defaults.synchronize()
    }
    static func loadFromUserDefaults(withKey key: String) -> Int {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: key)
    }
}
