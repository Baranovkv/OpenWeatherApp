//
//  APIService.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import Foundation
import CoreLocation

class APIService {
	
	private let apiKey = "68fa681428aeb8a0b10efb71bc16d5ba"
	private let apiCurrentWeatherUrl = "https://api.openweathermap.org/data/2.5/weather?"
	private let apiForecastUrl = "https://api.openweathermap.org/data/2.5/forecast?"
	private let defaultLatitude = 55.7558
	private let defaultLongitude = 37.6173
	private let exclude = "daily,current,alerts"
	
	func loadCurrentWeather(coordinates: CLLocationCoordinate2D, completion: @escaping (Result<CurrentWeather, APIError>) -> Void) {
		print("Request location: \(coordinates)")
		print("loading CurrentWeather")
		let latitude = coordinates.latitude
		let longitude = coordinates.longitude
		let url = "\(apiCurrentWeatherUrl)lat=\(latitude)&lon=\(longitude)&exclude=\(exclude)&appid=\(apiKey)&lang=ru&units=metric"
		fetchData(from: url, completion: completion)
	}
	
	func loadForecastWeather(coordinates: CLLocationCoordinate2D, completion: @escaping (Result<ForecastsResponce, APIError>) -> Void) {
		print("loading Forecast")
		let latitude = coordinates.latitude
		let longitude = coordinates.longitude
		let url = "\(apiForecastUrl)lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&lang=ru&units=metric"
		fetchData(from: url, completion: completion)

	}

	private func fetchData<T: Codable> (
		from url: String,
		completion: @escaping (Result<T, APIError>) -> Void) {
			
			guard let url = URL(string: url) else {
				completion(.failure(.invalidURL(url)))
				return
			}
				URLSession.shared.dataTask(with: url) { data, response, error in
					if let error {
						completion(.failure(.noData(error.localizedDescription)))
						return
					}
					guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
						completion(.failure(.invalidResponse(String(describing: response))))
						return
					}
					print(T.self)
					if let data {
						do {
							let decoded = try JSONDecoder().decode(T.self, from: data)
							completion(.success(decoded))
						} catch {
							completion(.failure(.decodingError(error.localizedDescription)))
						}
					}
				}.resume()
		}
}
