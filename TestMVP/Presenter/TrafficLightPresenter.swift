//
//  TrafficLightPresenter.swift
//  TestMVP
//
//  Created by VKoshelev@detmir.ru on 02.09.2021.
//

import Foundation

/// Протокол делегата. Мы будем использовать его, когда захотим передать информацию от presenter в view. Здесь это позволит отправить информацию обратно VC.
protocol TrafficLightViewDelegate: NSObjectProtocol {
    func displayTrafficLights(description: (String))
}


class TrafficLightPresenter {
    
    // Он принадлежит презентеру
    private let trafficLightService: TrafficLightService
    
    // weak ссылка на делегат, поскольку сам презентер будет принадлежать VC
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
                
                // Вызываем метод display, который должен реализовать делегат (VC в нашем случае)
                self?.delegate?.displayTrafficLights(description: trafficLight.description)
            }
        }
    }
}
