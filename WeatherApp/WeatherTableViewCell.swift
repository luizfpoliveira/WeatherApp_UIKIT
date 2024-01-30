//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Luiz Oliveira on 26/01/24.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    static let identifier = "cell"
    
    let labelSubDay = UILabel()
    let labelSubTemp = UILabel()
    let imageIcon = UIImageView()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(labelSubDay)
        addSubview(labelSubTemp)
        addSubview(imageIcon)
        
        labelSubDay.translatesAutoresizingMaskIntoConstraints = false
        labelSubTemp.translatesAutoresizingMaskIntoConstraints = false
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        
        labelSubDay.font = .boldSystemFont(ofSize: 20)
        labelSubDay.textColor = .white
        labelSubTemp.textColor = .white
        labelSubTemp.font = .preferredFont(forTextStyle: .body)
        
        imageIcon.tintColor = .systemYellow
        imageIcon.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            labelSubDay.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            labelSubDay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelSubDay.widthAnchor.constraint(equalToConstant: 120),
            labelSubDay.heightAnchor.constraint(equalToConstant: 30),
            
            labelSubTemp.topAnchor.constraint(equalTo: labelSubDay.bottomAnchor),
            labelSubTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelSubTemp.widthAnchor.constraint(equalToConstant: 140),
            labelSubTemp.heightAnchor.constraint(equalToConstant: 20),
            
            imageIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageIcon.leadingAnchor.constraint(equalTo: labelSubDay.trailingAnchor, constant: 100),
            imageIcon.widthAnchor.constraint(equalToConstant: 60),
            imageIcon.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
