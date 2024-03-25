//
//  CurrentWeatherView.swift
//  OpenWeatherApp
//
//  Created by Kirill Baranov on 24/03/24.
//

import UIKit
import CoreLocation

class CurrentWeatherView: UIView {
	
	private let locationLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
		label.textAlignment = .center
		return label
	}()
	
	private let placemarkLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		label.textAlignment = .center
		return label
	}()
	
	private let temperatureLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 64, weight: .bold)
		label.textAlignment = .center
		return label
	}()
	
	private let feelsLikeLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 18)
		label.textAlignment = .center
		return label
	}()
	
	private let weatherDescriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 18)
		label.textAlignment = .center
		return label
	}()
	
	private let windLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 18)
		label.textAlignment = .center
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupSubviews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupSubviews() {
		backgroundColor = .systemBackground
		addSubview(locationLabel)
		addSubview(placemarkLabel)
		addSubview(temperatureLabel)
		addSubview(feelsLikeLabel)
		addSubview(weatherDescriptionLabel)
		addSubview(windLabel)
		
		locationLabel.translatesAutoresizingMaskIntoConstraints = false
		placemarkLabel.translatesAutoresizingMaskIntoConstraints = false
		temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
		feelsLikeLabel.translatesAutoresizingMaskIntoConstraints = false
		weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		windLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			locationLabel.topAnchor.constraint(equalTo: topAnchor),
			locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			placemarkLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
			placemarkLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			placemarkLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			temperatureLabel.topAnchor.constraint(equalTo: placemarkLabel.bottomAnchor, constant: 16),
			temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			feelsLikeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8),
			feelsLikeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			feelsLikeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			weatherDescriptionLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 8),
			weatherDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			weatherDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			windLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 8),
			windLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			windLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			windLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
	
	func updateUI(with currentWeather: CurrentWeather) {
		locationLabel.text = currentWeather.cityName
		temperatureLabel.text = "\(Int(currentWeather.main.temperature))°"
		feelsLikeLabel.text = "Ощущается как \(Int(currentWeather.main.feelsLike))°"
		let descriprion = currentWeather.weather.first?.description ?? ""
		weatherDescriptionLabel.text = descriprion.prefix(1).uppercased() + descriprion.dropFirst()
		windLabel.text = "Скорость ветра: \(currentWeather.wind.speed) м/с"
		
		counPlacemark(coordinates: currentWeather.coordinates) { (locality) in
			if let locality = locality {
				self.placemarkLabel.text = locality
			} else {
				print("Не удалось получить название местности")
			}
		}
	}
	
	
	func counPlacemark(coordinates: Coordinates, completion: @escaping (String?) -> Void) {
		let geocoder = CLGeocoder()
		let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
		geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
			if let error = error {
				print("Reverse geocoding failed with error: \(error.localizedDescription)")
				completion(nil)
				return
			}
			
			if let placemark = placemarks?.first {
				if let locality = placemark.locality {
					print("Пользователь находится в \(locality)")
					completion(locality)
				} else {
					print("Местоположение без названия местности")
					completion(nil)
				}
			} else {
				print("Не удалось найти местоположение")
				completion(nil)
			}
		}
	}
	
}
