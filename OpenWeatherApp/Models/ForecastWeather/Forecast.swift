//
//  File.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import Foundation

struct Forecast: Codable {
	let date: Int
	let main: WeatherDetails
	let weather: [WeatherDescription]
	let clouds: Cloudiness
	let wind: WindDetails
	let visibility: Int?
	let probabilityOfPrecipitation: Double
	let rain: RainVolume?
	let snow: RainVolume?
	let systemInfo: SystemInfo
	let dateText: String
	
	var dayString: String {
		dateText.components(separatedBy: " ")[0]
	}
	var fullDate: Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return dateFormatter.date(from: dateText)
	}
	
	enum CodingKeys: String, CodingKey {
		case date = "dt"
		case main
		case weather
		case clouds
		case wind
		case visibility
		case probabilityOfPrecipitation = "pop"
		case rain
		case snow
		case systemInfo = "sys"
		case dateText = "dt_txt"
	}
}
