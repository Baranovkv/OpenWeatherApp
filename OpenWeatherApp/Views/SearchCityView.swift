//
//  Search.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 25/03/24.
//

import UIKit

class SearchCityView: UIView {

	let cityTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Введите имя города"
		textField.borderStyle = .roundedRect
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()

	let searchButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Поиск", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupView()
	}

	private func setupView() {
		addSubview(cityTextField)
		addSubview(searchButton)

		NSLayoutConstraint.activate([
			cityTextField.topAnchor.constraint(equalTo: topAnchor),
			cityTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
			cityTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8),
			cityTextField.bottomAnchor.constraint(equalTo: bottomAnchor),

			searchButton.topAnchor.constraint(equalTo: topAnchor),
			searchButton.trailingAnchor.constraint(equalTo: trailingAnchor),
			searchButton.widthAnchor.constraint(equalToConstant: 80),
			searchButton.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
}
