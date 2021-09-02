//
//  ViewController.swift
//  TestMVP
//
//  Created by VKoshelev@detmir.ru on 02.09.2021.
//

import UIKit

class ViewController: UIViewController {

    // Собственно сам презентер (у которого есть свой инстанс класса сервиса), который принадлежит этому VC
    private let trafficLightPresenter = TrafficLightPresenter(trafficLightService: TrafficLightService())
    
    // MARK: - UI
    
    private let red: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(redButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let yellow: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(yellowButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let green: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(greenButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [red, yellow, green])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private let lable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        // Установка self в качестве делегата презентера
        trafficLightPresenter.setViewDelegate(trafficLightViewDelegate: self)
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        view.addSubview(stackView)
        view.addSubview(lable)
        makeConstrints()
    }
    
    private func makeConstrints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -170)
        ])
        
        NSLayoutConstraint.activate([
            lable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lable.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
        ])
    }


    // MARK: - Button's selectors
    
    @objc private func redButtonPressed(_ sender: UIButton) {
        trafficLightPresenter.trafficLightColorSelected(colorName: "Red")
    }
    
    @objc private func yellowButtonPressed(_ sender: UIButton) {
        trafficLightPresenter.trafficLightColorSelected(colorName: "Yellow")
    }
    
    @objc private func greenButtonPressed(_ sender: UIButton) {
        trafficLightPresenter.trafficLightColorSelected(colorName: "Green")
    }
}


// Реализация протокола
extension ViewController: TrafficLightViewDelegate {
    func displayTrafficLights(description: (String)) {
        lable.text = description
    }
}

