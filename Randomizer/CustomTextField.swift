//
//  CustomTextField.swift
//  Randomizer_MVVM
//
//  Created by Alex Murphy on 24.11.2023.
//

import UIKit

final class CustomTextField: UITextField {

	private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)

	init(placeholder: String) {
		super.init(frame: .zero)
		setupTextField(placeholder: placeholder)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Padding for textField.text
	override func textRect(forBounds bounds: CGRect) -> CGRect { // bounds = прямоугольник для textField
		bounds.inset(by: padding)
	}

	// MARK: - Padding for placeholder
	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		bounds.inset(by: padding)
	}

	// MARK: - Padding for edited text
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		bounds.inset(by: padding)
	}

	private func setupTextField(placeholder: String) {
		textColor = .black
		layer.cornerRadius = 10
		layer.backgroundColor = UIColor.white.cgColor

		layer.shadowColor = UIColor.black.cgColor
		layer.shadowRadius = 7
		layer.shadowOpacity = 0.4
		layer.shadowOffset = CGSize(width: 15, height: 15)

		attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
		font = .boldSystemFont(ofSize: 18)
		clearButtonMode = .whileEditing
		keyboardType = .numberPad

		heightAnchor.constraint(equalToConstant: 60).isActive = true
	}
}


