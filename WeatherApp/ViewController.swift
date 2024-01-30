//
//  ViewController.swift
//  WeatherApp
//
//  Created by Luiz Oliveira on 26/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    var data: [Weather] = []
    
    var city1 = "recife"
    
    let service = Service()
    
    private var weatherReponse: Weather?
    
    var week: [day] = [
        day(name: "monday", temp: 32, feelsLike: 36, wind: 10, forecast: "Sunny"),
        day(name: "tuesday", temp: 32, feelsLike: 36, wind: 10, forecast: "Sunny"),
        day(name: "wednesday", temp: 12, feelsLike: 36, wind: 10, forecast: "Rainny"),
        day(name: "thuesday", temp: 32, feelsLike: 36, wind: 10, forecast: "Sunny"),
        day(name: "friday", temp: 23, feelsLike: 36, wind: 10, forecast: "Cloud"),
        day(name: "saturday", temp: 32, feelsLike: 36, wind: 10, forecast: "Sunny"),
        day(name: "sunday", temp: 32, feelsLike: 36, wind: 10, forecast: "Sunny"),
    ]
    
    let backgroundImage = UIImageView()
    let cityLabel = UILabel()
    let dateLabel = UILabel()
    let tempLabel = UILabel()
    let forecastLabel = UILabel()
    let searchBar = UISearchBar()
    var date = Date().formatted(date: .abbreviated, time: .shortened)
    var tableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        fetchData()
        configureBackgroundImage()
        configurecityLabel()
        configureDateLabel()
        configureTempLabel()
        configureForecastLabel()
        configureSearchBar()
        configureTVLabel()
        
    }
    
     func fetchData() {
        service.fetchData(city: city1.lowercased()) { [weak self] response in
            self?.weatherReponse = response
            DispatchQueue.main.async {
                self?.loadData()
            }
        }
    }
    
     func loadData() {
        cityLabel.text = weatherReponse?.name
         tempLabel.text = "\(weatherReponse?.main.temp.rounded() ?? 0)º"
         forecastLabel.text = weatherReponse?.weather[0].description.capitalized
    }
    
    
    func configureBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "sky")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.8
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    func configurecityLabel() {
        view.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textAlignment = .center
        cityLabel.font = .preferredFont(forTextStyle: .extraLargeTitle)
        cityLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func configureDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.text = "\(date)"
        dateLabel.textAlignment = .center
        dateLabel.font = .preferredFont(forTextStyle: .body)
        dateLabel.textColor = .white.withAlphaComponent(0.7)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func configureTempLabel() {
        view.addSubview(tempLabel)
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.font = .systemFont(ofSize: 100, weight: .bold)
        tempLabel.textAlignment = .center
        tempLabel.textColor = .white
        tempLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            tempLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            tempLabel.widthAnchor.constraint(equalToConstant: 220),
            tempLabel.heightAnchor.constraint(equalToConstant: 140),
        ])
    }
    
    func configureForecastLabel() {
        view.addSubview(forecastLabel)
        forecastLabel.translatesAutoresizingMaskIntoConstraints = false
        forecastLabel.textColor = .white
        forecastLabel.font = .preferredFont(forTextStyle: .title1)
        
        NSLayoutConstraint.activate([
            forecastLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 0),
            forecastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    func configureTVLabel() {
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        tableview.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        tableview.backgroundColor = .red
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = .clear
        tableview.rowHeight = 100
        tableview.layer.cornerRadius = 20
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: forecastLabel.bottomAnchor, constant: 20),
            tableview.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -20),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func configureSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.placeholder = "Search City Here:"
        searchBar.searchTextField.font = .boldSystemFont(ofSize: 22)
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        
        NSLayoutConstraint.activate([
            searchBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            searchBar.widthAnchor.constraint(equalToConstant: 360),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return week.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.labelSubDay.text = week[indexPath.row].name.capitalized
        cell.labelSubTemp.text = "Temperature: \(week[indexPath.row].temp)º"
        if week[indexPath.row].forecast == "Sunny"{
            cell.imageIcon.image = UIImage(systemName: "sun.max.fill" )
        } else if  week[indexPath.row].forecast == "Rainny"{
            cell.imageIcon.image = UIImage(systemName: "cloud.rain" )
            cell.imageIcon.tintColor = .white
        } else {
            cell.imageIcon.image = UIImage(systemName: "cloud")
            cell.imageIcon.tintColor = .white
        }
        cell.backgroundColor = .black.withAlphaComponent(0.1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        city1 = searchBar.text!
        fetchData()
        searchBar.enablesReturnKeyAutomatically = true
    }
    
    }
    

