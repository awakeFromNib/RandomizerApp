//
//  NavAppearance.swift
//  Randomizer_MVVM
//
//  Created by Alex Murphy on 22.11.2023.
//

import UIKit

extension UINavigationController {

	func setupNavBarColor() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()

		appearance.backgroundColor = UIColor(red: 65/255, green: 90/255, blue: 119/255, alpha: 1)
		appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

		self.navigationBar.standardAppearance = appearance
		self.navigationBar.scrollEdgeAppearance = appearance
		self.navigationBar.compactAppearance = appearance
		self.navigationBar.tintColor = .white
		UIBarButtonItem.appearance().tintColor = .white
	}
}
