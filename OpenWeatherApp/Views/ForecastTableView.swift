//
//  ForecastWeatherListView.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import UIKit

class ForecastTableView: UIView {
		
	private let tableView = UITableView()
	
	private var forecasts: [Forecast]?
	private var expandedSections = Set<Int>()
	
	var dayTitles: [String] {
		var sectionTitles = [String]()
		if let forecasts {
			forecasts.forEach { forecast in
				let date = forecast.fullDate?.formatted(date: .complete, time: .omitted)
				if !sectionTitles.contains(where: { $0 == date }) {
					sectionTitles.append(date ?? forecast.dayString)
				}
			}
		}
		return sectionTitles
	}
	
	var forecastsByDay: [[Forecast]] {
		var groupedForecasts = [[Forecast]]()
		if let forecasts {
			for forecast in forecasts {
				let date = forecast.dayString
				if let index = groupedForecasts.firstIndex(where: { $0[0].dayString == date } ) {
					groupedForecasts[index].append(forecast)
				} else {
					groupedForecasts.append([forecast])
				}
			}
		}
		return groupedForecasts
	}
		
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupTableView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ForecastCell")
		addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
		])
	}
	
	func updateUI(with forecast: ForecastsResponce) {
		forecasts = forecast.list
		tableView.reloadData()
	}
}

extension ForecastTableView: UITableViewDataSource, UITableViewDelegate {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		forecastsByDay.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if expandedSections.contains(section) {
			return forecastsByDay[section].count
		} else {
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let forecast = forecastsByDay[indexPath.section][indexPath.row]
		let cellIdentifier = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
		let cell = cellIdentifier
		var configuration = cell.defaultContentConfiguration()
		configuration.text = forecast.fullDate?.formatted(date: .omitted, time: .shortened)
		configuration.secondaryText = """
Температура: \(forecast.main.temperature.formatted())°, облачность: \(forecast.clouds.percentage.formatted()) %
ветер: \(forecast.wind.speed) м/с, \(forecast.weather[0].description)
"""
		configuration.image = UIImage(named: forecast.weather[0].icon)
		cell.contentConfiguration = configuration
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = CustomHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 10, height: .infinity))
		headerView.setTitle(dayTitles[section])
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
		headerView.addGestureRecognizer(tapGesture)
		headerView.tag = section
		return headerView
	}
	
	@objc func headerTapped(_ gesture: UITapGestureRecognizer) {
		guard let section = gesture.view?.tag else { return }
		if expandedSections.contains(section) {
			expandedSections.remove(section)
		} else {
			expandedSections.insert(section)
		}
		tableView.reloadSections(IndexSet(integer: section), with: .automatic)
	}
	
}
