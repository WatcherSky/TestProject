//
//  CryptoInfoViewController.swift
//  TestApplication
//
//  Created by Владимир on 28.05.2025.
//

import Foundation
import UIKit

final class CryptoInfoViewController: UIViewController {
    //MARK: - Properties
    
    let viewModel: CryptoInfoViewModel
    
    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.CryptoInfo.CryptoInfoColors.bottomSheet
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.blackTextColor
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.medium)
        return label
    }()
    
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.subColor
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultSmall)
        return label
    }()
    
    private let chartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "chartImage")
        imageView.layer.cornerRadius = 28
        imageView.layer.contentsGravity = .bottom
        return imageView
    }()
    
    private let bottomSheetTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.blackTextColor
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultMeduim)
        label.text = "Market Statistic"
        return label
    }()
    
    private let priceIconImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let marketcapLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.subColor
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultSmall)
        label.text = "Market Capitalization"
        return label
    }()
    
    private let marketcapValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.blackTextColor
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultSmall)
        return label
    }()
    
    private let supplyLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.subColor
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultSmall)
        label.text = "Circulating Suply"
        return label
    }()
    
    private let supplyValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.blackTextColor
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultSmall)
        return label
    }()
    
    //MARK: - Init
    
    init(viewModel: CryptoInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - vc Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.CryptoInfo.CryptoInfoColors.backgroundColor
        configureView()
        configure(cryptoData: viewModel.cryptoData)
        setupNavigationBar()
    }
    
    //MARK: - Configure View
    
    func configure(cryptoData: CryptoData) {
        title = cryptoData.name + " (\(cryptoData.symbol))"
        
        let price = viewModel.formatNumberSmart(cryptoData.price)
        let priceChange = viewModel.formatNumberSmart(cryptoData.priceChange)
        let supply = viewModel.formatNumberSmart(cryptoData.priceChange)
        priceLabel.text = "$" + price
        priceChangeLabel.text = priceChange + "%"
        marketcapValueLabel.text = "$" + " \(cryptoData.marketCap)"
        supplyValueLabel.text = supply + " " + cryptoData.symbol
        setupIcon(priceChange: cryptoData.priceChange)
    }
    
    private func setupIcon(priceChange: Double) {
        if priceChange < 0 {
            priceIconImageView.image = UIImage(named: "arrowDown")
        } else {
            priceIconImageView.image = UIImage(named: "arrowUp")
        }
    }
    
    private func setupNavigationBar() {
        let backImage = UIImage(systemName: "chevron.left")
        let backButton = UIButton(type: .system)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
        
        
        let logoutImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        let logoutButton = UIBarButtonItem(image: logoutImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(logout))
        logoutButton.tintColor = .black
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func logout() {
        UserDefaults.standard.logoutUser()
        viewModel.logout()
    }
    
    //MARK: - Setup View & Constraints
    
    private func configureView() {
        [chartImageView, priceLabel, priceChangeLabel, bottomSheetView, priceIconImageView].forEach {
            view.addSubview($0)
        }
        
        [bottomSheetTitleLabel, marketcapLabel, marketcapValueLabel, supplyLabel, supplyValueLabel].forEach {
            bottomSheetView.addSubview($0)
        }
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        priceChangeLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        chartImageView.snp.makeConstraints { make in
            make.top.equalTo(priceChangeLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(Constants.Constraints.inset)
            make.height.equalTo(56)
            make.width.equalTo(view.bounds.width - 50)
        }
        
        priceIconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(priceChangeLabel.snp.centerY)
            make.trailing.equalTo(priceChangeLabel.snp.leading).offset(-5)
            make.size.equalTo(12)
        }
        
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(Constants.Login.LoginConstraints.inset * 10)
        }
        
        bottomSheetTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(Constants.Login.LoginConstraints.inset)
            make.left.right.equalTo(Constants.Login.LoginConstraints.inset)
            make.height.equalTo(Constants.Constraints.inset)
        }
        
        marketcapLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomSheetTitleLabel.snp.bottom).offset(Constants.Constraints.offset)
            make.leading.equalToSuperview().offset(Constants.Constraints.inset)
            make.height.equalTo(Constants.Size.cellSizeSmallSize)
        }
        
        marketcapValueLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomSheetTitleLabel.snp.bottom).offset(Constants.Constraints.offset)
            make.trailing.equalToSuperview().inset(Constants.Constraints.inset)
            make.height.equalTo(Constants.Size.cellSizeSmallSize)
        }
        
        supplyLabel.snp.makeConstraints { make in
            make.top.equalTo(marketcapLabel.snp.bottom).offset(Constants.Constraints.offset)
            make.leading.equalToSuperview().inset(Constants.Constraints.inset)
            make.height.equalTo(Constants.Size.cellSizeSmallSize)
        }
        
        supplyValueLabel.snp.makeConstraints { make in
            make.top.equalTo(marketcapValueLabel.snp.bottom).offset(Constants.Constraints.offset)
            make.trailing.equalToSuperview().inset(Constants.Constraints.inset)
            make.height.equalTo(Constants.Size.cellSizeSmallSize)
        }
    }
}
