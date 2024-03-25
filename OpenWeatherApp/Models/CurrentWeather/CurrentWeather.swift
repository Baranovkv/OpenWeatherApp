//
//  WeatherData.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 23/03/24.
//

import Foundation

struct CurrentWeather: Codable {
	let coordinates: Coordinates
	let weather: [WeatherDescription]
	let main: WeatherDetails
	let wind: WindDetails
	let rain: RainVolume?
	let clouds: Cloudiness
	let date: Int
	let systemInfo: SystemInfo
	let timezone: Int
	let cityId: Int
	let cityName: String
	let cod: Int
	
	enum CodingKeys: String, CodingKey {
		case coordinates = "coord"
		case weather
		case main
		case wind
		case rain
		case clouds
		case date = "dt"
		case systemInfo = "sys"
		case timezone
		case cityId = "id"
		case cityName = "name"
		case cod
	}
	
}
