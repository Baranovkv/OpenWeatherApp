//
//  File.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import Foundation

struct WeatherDetails: Codable {
	let temperature: Double
	let feelsLike: Double
	let minTemperature: Double
	let maxTemperature: Double
	let pressure: Int
	let humidity: Int
	let seaLevel: Int?
	let groundLevel: Int?
	
	enum CodingKeys: String, CodingKey {
		case temperature = "temp"
		case feelsLike = "feels_like"
		case minTemperature = "temp_min"
		case maxTemperature = "temp_max"
		case pressure
		case humidity
		case seaLevel = "sea_level"
		case groundLevel = "grnd_level"
	}
}
