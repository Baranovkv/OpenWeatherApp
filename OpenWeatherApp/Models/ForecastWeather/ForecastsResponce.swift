//
//  File.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import Foundation

struct ForecastsResponce: Codable {
	let cod: String
	let message: Double
	let count: Int
	let list: [Forecast]
	let city: CityDetails
		
	enum CodingKeys: String, CodingKey {
		case cod
		case message
		case count = "cnt"
		case list
		case city
	}
}

