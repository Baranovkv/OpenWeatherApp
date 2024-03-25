//
//  WeatherViewController.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import UIKit
import CoreLocation
import MapKit

class WeatherViewController: UIViewController {
	
	let weatherViewModel = WeatherViewModel()
	let currentWeatherView = CurrentWeatherView()
	let forecastTableView = ForecastTableView()
	
	let searchCityView = SearchCityView()
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
		weatherViewModel.requestLocation()
		
		
		view.backgroundColor = .systemBackground
		
		
		self.weatherViewModel.onCurrentWeaterUpdated = { [weak self] in
			DispatchQueue.main.async {
				if let currentWeather = self?.weatherViewModel.currentWeather {
					self?.currentWeatherView.updateUI(with: currentWeather)
				}
			}
		}
		
		self.weatherViewModel.onForecastUpdated = { [weak self] in
			DispatchQueue.main.async {
				if let forecastWeather = self?.weatherViewModel.forecastWeather {
					self?.forecastTableView.updateUI(with: forecastWeather)
				}
			}
		}
		
		view.addSubview(searchCityView)
		searchCityView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			searchCityView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
			searchCityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			searchCityView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
		])
		searchCityView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
		
		view.addSubview(currentWeatherView)
		currentWeatherView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			currentWeatherView.topAnchor.constraint(equalTo: searchCityView.safeAreaLayoutGuide.topAnchor, constant: 64),
			currentWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			currentWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
		])
		
		view.addSubview(forecastTableView)
		forecastTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			forecastTableView.topAnchor.constraint(equalTo: currentWeatherView.bottomAnchor, constant: 16),
			forecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			forecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			forecastTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
	}
	
	
	@objc func searchButtonTapped() {
		guard let cityName = searchCityView.cityTextField.text, !cityName.isEmpty else {
			return
		}
		
		let searchRequest = MKLocalSearch.Request()
		searchRequest.naturalLanguageQuery = cityName
		let search = MKLocalSearch(request: searchRequest)
		search.start { [weak self] (response, error) in
			guard let self = self else { return }
			
			if let error = error {
				print("Error searching for city: \(error.localizedDescription)")
				return
			}
			
			if let firstPlacemark = response?.mapItems.first?.placemark {
				let cityCoordinate = firstPlacemark.coordinate
				self.weatherViewModel.userLocation = CLLocation(latitude: cityCoordinate.latitude,
																longitude: cityCoordinate.longitude)
				self.weatherViewModel.fetchWeatherForLocation()
			}
		}
		
		self.view.endEditing(true)
	}
	
}
