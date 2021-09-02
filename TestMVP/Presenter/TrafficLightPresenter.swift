//
//  TrafficLightPresenter.swift
//  TestMVP
//
//  Created by VKoshelev@detmir.ru on 02.09.2021.
//

import Foundation

protocol TrafficLightViewDelegate: NSObjectProtocol {
    func displayTrafficLights(description: (String))
}

class TrafficLightPresenter {
    private let trafficLightService: TrafficLightService
    weak private var delegate: TrafficLightViewDelegate?
    
    init(trafficLightService: TrafficLightService) {
        self.trafficLightService = trafficLightService
    }
    
    func setViewDelegate(trafficLightViewDelegate: TrafficLightViewDelegate?) {
        self.delegate = trafficLightViewDelegate
    }
    
    func trafficLightColorSelected(colorName: String){
        trafficLightService.getTrafficLight(colorName: colorName) { [weak self] trafficLight in
            if let trafficLight = trafficLight {
                self?.delegate?.displayTrafficLights(description: trafficLight.description)
            }
        }
    }
}
