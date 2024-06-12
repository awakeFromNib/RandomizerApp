//
//  Extension+Alert.swift
//  Randomizer_MVVM
//
//  Created by Alex Murphy on 26.11.2023.
//

import UIKit

// MARK: - Alert Controller
extension UIViewController {
	func showAlert(title: String, message: String, textField: CustomTextField? = nil) {
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default) { _ in
			textField?.text = nil
		}
		alert.addAction(okAction)
		present(alert, animated: true)
	}
}

