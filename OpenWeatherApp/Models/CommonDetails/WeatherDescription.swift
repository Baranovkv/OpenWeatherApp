//
//  Weat.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import Foundation

struct WeatherDescription: Codable {
	let id: Int
	let main: String
	let description: String
	let icon: String
}
