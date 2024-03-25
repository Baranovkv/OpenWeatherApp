//
//  OtherDetails.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import Foundation

struct WindDetails: Codable {
	let speed: Double
	let degrees: Int
	let gust: Double?
	
	enum CodingKeys: String, CodingKey {
		case speed
		case degrees = "deg"
		case gust
	}
}

struct RainVolume: Codable {
	let lastHour: Double?
	
	enum CodingKeys: String, CodingKey {
		case lastHour = "1h"
	}
}

struct Cloudiness: Codable {
	let percentage: Int
	
	enum CodingKeys: String, CodingKey {
		case percentage = "all"
	}
}

struct SystemInfo: Codable {
	let type: Int?
	let id: Int?
	let country: String?
	let sunrise: Int?
	let sunset: Int?
}
