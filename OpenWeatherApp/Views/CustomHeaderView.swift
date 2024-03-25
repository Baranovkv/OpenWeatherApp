//
//  HeaderCellView.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 25/03/24.
//

import UIKit


class CustomHeaderView: UIView {
	
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .label
		label.font = UIFont.boldSystemFont(ofSize: 16)
		return label
	}()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupUI()
	}
	
	private func setupUI() {
		backgroundColor = .opaqueSeparator
		layer.cornerRadius = 10
		clipsToBounds = true
		
		addSubview(titleLabel)
		
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
		titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
		titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
		titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
		titleLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
		])
	}
	
	
	func setTitle(_ title: String) {
		titleLabel.text = title
	}
}
