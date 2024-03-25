//
//  NetworkError.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import Foundation


enum APIError: Error {
	case invalidURL(String)
	case noData(String)
	case invalidResponse(String)
	case decodingError(String)
}
