//
//  MainViewController.swift
//  Randomizer_MVVM
//  https://youtu.be/wcN3-E1_ZxU?feature=shared
//  Created by Alex Murphy on 22.11.2023.
//

import UIKit

final class MainViewController: UIViewController, iSetRangeProtocolDelegate {

	private var firstNumber = 0
	private var lastNumber = 0
	
	private let resultButton = UIButton()

	// MARK: - Protocol Implementation
	func setRange(first: String, last: String) {
		firstNumber = Int(first) ?? 0
		lastNumber = Int(last) ?? 0
		firstNumberLabel.text = first
		lastNumberLabel.text = last
	}

	// MARK: - User Interface
	let fromLabel: UILabel = {
		let label = UILabel()
		label.text = "From"
		label.font = .systemFont(ofSize: 20)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let firstNumberLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 35)
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let toLabel: UILabel = {
		let label = UILabel()
		label.text = "To"
		label.font = .systemFont(ofSize: 20)
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	let lastNumberLabel: UILabel = {
		let label = UILabel()
		label.font = .boldSystemFont(ofSize: 35)
		label.adjustsFontSizeToFitWidth = true
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private var labelStackView = UIStackView()

	// MARK: - Result label
	let resultLabel: UILabel = {
		let label = UILabel()
		label.adjustsFontSizeToFitWidth = true
		label.clipsToBounds = true
		label.layer.cornerRadius = 10
		label.text = "Start generating!"
		label.textAlignment = .center
		label.font = .boldSystemFont(ofSize: 90)
		label.translatesAutoresizingMaskIntoConstraints = false

		// MARK: - Label Shadow settings
		label.layer.shadowColor = UIColor.black.cgColor
		label.layer.shadowRadius = 7
		label.layer.shadowOpacity = 0.4
		label.layer.shadowOffset = CGSize(width: 15, height: 15)

		return label
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		setupNavigationController()
		setupConstraints()
		configureButton()
		setRange(first: "1", last: "100")
	}

	// MARK: - Button Configuration
	func configureButton() {
		resultButton.configuration = .filled()
		resultButton.configuration?.title = "Get Result"
		resultButton.configuration?.baseBackgroundColor = UIColor(red: 65/255, green: 90/255, blue: 119/255, alpha: 1)
		resultButton.configuration?.baseForegroundColor = .white
		resultButton.configuration?.cornerStyle = .medium

		// MARK: - Button Shadow settings
//		resultButton.layer.shadowColor = UIColor.black.cgColor
//		resultButton.layer.shadowRadius = 7
//		resultButton.layer.shadowOpacity = 0.4
//		resultButton.layer.shadowOffset = CGSize(width: 15, height: 15)

		let action = UIAction { [weak self] _ in
			self?.getResult()
		}
		resultButton.addAction(action, for: .primaryActionTriggered)
		setButtonConstraints()
	}

	// MARK: - Number Generator Function
	func getResult() {
		let randomNumber = Int.random(in: firstNumber...lastNumber)
		resultLabel.text = String(randomNumber)
	}

	// MARK: - View Setup
	private func setupView() {
		self.title = "Random Number"
		view.backgroundColor = UIColor(red: 119/255, green: 141/255, blue: 169/255, alpha: 1)
		labelStackView = UIStackView(arrangedSubviews: [
			fromLabel, firstNumberLabel, toLabel, lastNumberLabel
		])
		labelStackView.axis = .horizontal
		labelStackView.spacing = 2
		labelStackView.distribution = .fillEqually
		labelStackView.alignment = .fill
		labelStackView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(labelStackView)
		view.addSubview(resultLabel)
	}

	// MARK: - Navigation Controller Setup
	private func setupNavigationController() {
		self.navigationItem.title = "Random Number"
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.navigationItem.largeTitleDisplayMode = .always
//		self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(pushSettings))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(pushSettings))
	}

	// MARK: - Settings Screen Transition
	@objc
	private func pushSettings() {
		let rootVC = SettingsViewController()
		rootVC.delegate = self
		let navVC = UINavigationController(rootViewController: rootVC)
		navVC.modalPresentationStyle = .popover
		present(navVC, animated: true)
	}

	// MARK: - Labels Constraints
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			resultLabel.widthAnchor.constraint(equalToConstant: 300),
			resultLabel.heightAnchor.constraint(equalToConstant: 150),

			labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
			labelStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			labelStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
			labelStackView.heightAnchor.constraint(equalToConstant: 100)
		])
	}

	// MARK: - Button Constraints
	private func setButtonConstraints() {
		view.addSubview(resultButton)
		resultButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			resultButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
			resultButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			resultButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
			resultButton.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}
