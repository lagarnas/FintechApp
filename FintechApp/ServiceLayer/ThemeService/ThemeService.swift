//
//  ThemeService.swift
//  FintechApp
//
//  Created by Rudolf Oganesyan on 04.10.2020.
//  Copyright © 2020 Рудольф О. All rights reserved.
//

import UIKit

protocol ThemeServiceProtocol {
    var currentTheme: Theme { get }
    func updateThemeWith(_ theme: Theme, completion: @escaping VoidClosure)
    func setupNavigationBarAppearance()
}

final class ThemeService: ThemeServiceProtocol {
    
    private let selectedThemeKey = "selectedTheme"
    
    var currentTheme: Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: selectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .classic
        }
    }
    
    func updateThemeWith(_ theme: Theme, completion: @escaping VoidClosure) {
        DispatchQueue.global().async {
            UserDefaults.standard.setValue(theme.rawValue, forKey: self.selectedThemeKey)
            
            DispatchQueue.main.async {
                self.setupNavigationBarAppearance()
                completion()
            }
        }
    }
    
    func setupNavigationBarAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.shadowImage = UIImage()
        navigationBarAppearance.barTintColor = currentTheme.backgroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: currentTheme.primaryTextColor]
    }
}
