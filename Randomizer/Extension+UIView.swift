//
//  Extension+UIView.swift
//  Randomizer_MVVM
//
//  Created by Alex Murphy on 24.11.2023.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...) {
		views.forEach({
			addSubview($0)
		})
	}
}
