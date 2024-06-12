//
//  SettingsViewController.swift
//  Randomizer_MVVM
//
//  Created by Alex Murphy on 22.11.2023.
//

import UIKit

// MARK: - Protocol
protocol iSetRangeProtocolDelegate: AnyObject {
	func setRange(first: String, last: String)
}

final class SettingsViewController: UIViewController {

	// MARK: - Delegate
	weak var delegate: iSetRangeProtocolDelegate?

	// MARK: - User Interface
	let initialRangeTextField: CustomTextField = {
		let textField = CustomTextField(placeholder: "Range from")
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()

	let endRangeTextField: CustomTextField = {
		let textField = CustomTextField(placeholder: "End of range")
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()


	let gearImageView: UIImageView = {
		let imageView = UIImageView()
		if #available(iOS 16.0, *) {
			imageView.image = UIImage(systemName: "gearshape", variableValue: 1.0, configuration: UIImage.SymbolConfiguration(weight: .ultraLight))?.withTintColor(.white, renderingMode: .alwaysOriginal)
		} else {
			imageView.image = UIImage(systemName: "gearshape")
		}
		imageView.alpha = 0.5
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(red: 119/255, green: 141/255, blue: 169/255, alpha: 1)
		view.addSubviews(initialRangeTextField, endRangeTextField, gearImageView)
		initialRangeTextField.delegate = self
		endRangeTextField.delegate = self
		setupSettingsNavigationController()
		setupNavBarColour()
		setConstraints()
	}

	// MARK: - Navigation Bar Colour Setup
	private func setupNavBarColour() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()

		appearance.backgroundColor = UIColor(red: 65/255, green: 90/255, blue: 119/255, alpha: 1)
		appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
		navigationController?.navigationBar.compactAppearance = appearance

		navigationController?.navigationBar.tintColor = .white
		UIBarButtonItem.appearance().tintColor = .white
	}

	// MARK: - Navigation Controller Setup
	private func setupSettingsNavigationController() {
		navigationItem.title = "Settings"
//		self.navigationItem.style = .navigator
		navigationItem.largeTitleDisplayMode = .never
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveSettings))
	}

	// MARK: - Cancel function
	@objc
	private func cancel() {
		dismiss(animated: true)
	}

	// MARK: - Saving Settings function
	@objc
	private func saveSettings() {
		guard
			initialRangeTextField.hasText,
			endRangeTextField.hasText else {
			showAlert(title: "Error!",
					  message: "Enter number!")
			return
		}

		delegate?.setRange(
			first: initialRangeTextField.text ?? "",
			last: endRangeTextField.text ?? "")
		dismiss(animated: true)
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		view.endEditing(true)
	}

//	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//		view.endEditing(true)
//		return true
//	}

	// MARK: - Constraints
	private func setConstraints() {
		NSLayoutConstraint.activate([
			initialRangeTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
			initialRangeTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8), // ширина 80% от superview
			initialRangeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			endRangeTextField.topAnchor.constraint(equalTo: initialRangeTextField.bottomAnchor, constant: 10),
			endRangeTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			endRangeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			gearImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			gearImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			gearImageView.widthAnchor.constraint(equalToConstant: 200),
			gearImageView.heightAnchor.constraint(equalToConstant: 200)
		])
	}
}

// MARK: - Textfields limitations
extension SettingsViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if textField == textField {
			let allowedCharacters = "0123456789"
			let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
			let typedCharacterSetIn = CharacterSet(charactersIn: string)
			let numbers = allowedCharacterSet.isSuperset(of: typedCharacterSetIn)
			return numbers
		}
		return true
	}
}
