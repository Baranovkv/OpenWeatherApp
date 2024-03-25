//
//  ViewModel.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import Foundation
import CoreLocation

final class WeatherViewModel: NSObject {
	
	let locationManager = CLLocationManager()
	var userLocation: CLLocation?
	
	var currentWeather: CurrentWeather? {
		didSet {
			self.onCurrentWeaterUpdated?()
		}
	}
	var forecastWeather: ForecastsResponce? {
		didSet {
			self.onForecastUpdated?()
		}
	}
	
	var onCurrentWeaterUpdated: (() -> Void)?
	var onForecastUpdated: (() -> Void)?
	
	override init() {
		super.init()
		locationManager.delegate = self
		locationManager.requestAlwaysAuthorization()
	}
	
	func fetchWeatherForLocation() {
		
		if let userLocation {
			
			APIService().loadCurrentWeather(coordinates: userLocation.coordinate) { (result: Result<CurrentWeather, APIError>) in
				switch result {
				case .success(let weatherData):
					self.currentWeather = weatherData
				case .failure(let error):
					print("current weather could not be loaded: \(error.localizedDescription)")
				}
			}
			
			APIService().loadForecastWeather(coordinates: userLocation.coordinate) { (result: Result<ForecastsResponce, APIError>) in
				switch result {
				case .success(let weatherData):
					self.forecastWeather = weatherData
				case .failure(let error):
					print("forecast weather could not be loaded: \(error.localizedDescription)")
				}
			}
		}
	}
	
}


extension WeatherViewModel: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
	
			if status == .authorizedAlways || status == .authorizedWhenInUse {
				userLocation = manager.location
				print("location updated")
						fetchWeatherForLocation()

			}
		}
	
	func requestLocation() {
		locationManager.requestWhenInUseAuthorization()
	}
	
}
