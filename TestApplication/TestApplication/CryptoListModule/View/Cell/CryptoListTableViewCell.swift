//
//  CryptoListTableViewCell.swift
//  TestApplication
//
//  Created by Владимир on 27.05.2025.
//

import Foundation
import UIKit

final class CryptoListTableViewCell: UITableViewCell {
    //MARK: - Properties
    
    private let messageBackground: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 10
        return backgroundView
    }()
    
    private let cryptoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let cryptoNameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.small)
        label.textColor = Constants.Colors.mainTextBlackColor
        return label
    }()
    
    private let cryptoSymbolLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultSmall)
        label.textColor = Constants.Colors.subColor
        
        return label
    }()
    
    private let priceIconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultSmall)
        label.textColor = Constants.Colors.mainTextBlackColor
        
        return label
    }()
    
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultSmall)
        label.textColor = Constants.Colors.subColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(messageBackground)
        
        [cryptoImageView, cryptoNameLabel, cryptoSymbolLabel, priceIconImageView, priceLabel, priceChangeLabel].forEach {
            messageBackground.addSubview($0)
        }
        
        makeConstraints()
    }
    
    //MARK: - Init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    
    func configure(name: String, symbol: String, price: String, priceChange: String, priceChangeValue: Double) {
        cryptoNameLabel.text = name
        cryptoSymbolLabel.text = symbol
        priceLabel.text = "$" + price
        priceChangeLabel.text = priceChange + "%"
        setupIcon(priceChange: priceChangeValue)
        cryptoImageView.image = UIImage(named: symbol.lowercased())
    }
    
    private func setupIcon(priceChange: Double) {
        if priceChange < 0 {
            priceIconImageView.image = UIImage(named: "arrowDown")
        } else {
            priceIconImageView.image = UIImage(named: "arrowUp")
        }
    }
    
    private func makeConstraints() {
        messageBackground.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.bottom.equalToSuperview()
        }
        
        cryptoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(Constants.Login.LoginConstraints.inset)
            make.size.equalTo(Constants.Login.LoginConstraints.inset * 2)
        }
        
        cryptoNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(cryptoImageView.snp.trailing).offset(20)
            make.height.equalTo(Constants.Size.cellSizeMediumSize)
        }
        
        cryptoSymbolLabel.snp.makeConstraints { make in
            make.top.equalTo(cryptoNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(cryptoImageView.snp.trailing).offset(20)
            make.height.equalTo(Constants.Size.cellSizeSmallSize)
        }
        
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(Constants.Size.cellSizeMediumSize)
        }
        
        priceChangeLabel.snp.makeConstraints { make in
            make.top.equalTo(cryptoNameLabel.snp.bottom).offset(3)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(Constants.Size.cellSizeSmallSize)
        }
        
        priceIconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(priceChangeLabel.snp.centerY)
            make.trailing.equalTo(priceChangeLabel.snp.leading).offset(-5)
            make.size.equalTo(12)
        }
    }
}
