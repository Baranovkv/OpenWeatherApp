//
//  Coordinates.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import Foundation

struct Coordinates: Codable {
	let longitude: Double
	let latitude: Double
	
	enum CodingKeys: String, CodingKey {
		case longitude = "lon"
		case latitude = "lat"
	}
}
