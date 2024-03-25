//
//  CityDetails.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import Foundation

struct CityDetails: Codable {
	let id: Int
	let name: String
	let coordinates: Coordinates
	let country: String
	let population: Int
	let timezone: Int
	let sunrise: Int
	let sunset: Int
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case coordinates = "coord"
		case country
		case population
		case timezone
		case sunrise
		case sunset
	}
}
