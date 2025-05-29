//
//  CryproListController.swift
//  TestApplication
//
//  Created by Владимир on 26.05.2025.
//

import Foundation
import UIKit

final class CryptoListViewController: UIViewController {
    private let viewModel: CryptoListViewModel
    var byAscending = true
    
    private let group = DispatchGroup()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        
        return tableView
    }()
    
    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.bottomSheet
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.white
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.large)
        label.text = "Home"
        return label
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = Constants.Colors.bottomSheet
        return view
    }()
    
    private let bottomSheetTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.blackTextColor
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultMeduim)
        label.text = "Trending"
        return label
    }()
    
    private let affiliateProgramLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.white
        label.font = Constants.Fonts.baseFont(size: Constants.Fonts.Size.defaultMeduim)
        label.text = "Affiliate program"
        return label
    }()
    
    private let primaryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cryptoImage")
        return imageView
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sortIcon"), for: .normal)
        button.addTarget(self, action: #selector(sortAction), for: .touchUpInside)
        return button
    }()
    
    private let moreButton: UIButton = {
        let moreButton = UIButton(type: .system)
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .black
        moreButton.backgroundColor = Constants.Colors.whiteAlpha80
        moreButton.layer.cornerRadius = 24
        return moreButton
    }()
    
    private let learnMoreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.Colors.white
        button.setTitle("Learn More", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    //MARK: - Init
    
    init(viewModel: CryptoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - vc lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.CryptoList.CryptoListColors.topBackgroundColor
        configureView()
        getCryptoList()
        bind()
        moreButton.menu = createMenu()
        moreButton.showsMenuAsPrimaryAction = true
    }
    
    //MARK: - Methods
    
    private func getCryptoList() {
        viewModel.cryptoData.removeAll()
        self.tableView.reloadData()
        activityIndicatorView.startAnimating()
        for crypto in viewModel.cryptoList {
            viewModel.fetchCryptoData(for: crypto, group: group) {
                
            } failure: { error in
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.tableView.reloadData()
        }
    }
    
    private func bind() {
        self.viewModel.cryptoModel.bind { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            self.viewModel.cryptoData.append(result)
        }
    }
    
    
    func createMenu() -> UIMenu {
        let refreshAction = UIAction(
            title: "Обновить",
            image: UIImage(named: "reloadIcon")) { [weak self] _ in
                self?.getCryptoList()
            }
        let logoutAction = UIAction(
            title: "Выйти",
            image: UIImage(named: "logoutIcon")) { [weak self] _ in
                UserDefaults.standard.logoutUser()
                self?.viewModel.logout()
            }
        
        let menu = UIMenu(title: "", children: [refreshAction, logoutAction])
        
        return menu
    }
    
    @objc private func sortAction() {
        viewModel.sortCrypto(by: byAscending)
        byAscending.toggle()
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Configure View
    
    private func configureView() {
        tableView.register(CryptoListTableViewCell.self, forCellReuseIdentifier: Constants.ReuseIdentifiers.cryptoListCell)
        
        [primaryImageView, bottomSheetView].forEach {
            view.addSubview($0)
        }
        
        [headerView, tableView].forEach {
            bottomSheetView.addSubview($0)
        }
        tableView.addSubview(activityIndicatorView)
        
        [bottomSheetTitleLabel, sortButton].forEach {
            headerView.addSubview($0)
        }
        
        [moreButton, titleLabel, affiliateProgramLabel, learnMoreButton].forEach {
            view.addSubview($0)
        }
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide).offset(-215)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.Size.largeHeight)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        bottomSheetTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(Constants.Login.LoginConstraints.inset)
            make.left.equalTo(Constants.Login.LoginConstraints.inset)
            make.height.equalTo(Constants.Size.mediumSize)
            make.width.equalTo(Constants.Size.mediumSize * 3)
        }
        
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(Constants.Size.mediumSize)
            make.right.equalTo(-Constants.Constraints.inset)
            make.size.equalTo(Constants.Size.defaultSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().inset(Constants.Constraints.inset)
            make.height.equalTo(Constants.Size.defaultSize * 2)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        affiliateProgramLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Constraints.smallOffset * 4)
            make.left.equalToSuperview().inset(Constants.Constraints.inset)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(Constants.Size.mediumSize)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(affiliateProgramLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(Constants.Constraints.inset)
            make.height.equalTo(36)
            make.width.equalToSuperview().multipliedBy(0.33)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview().inset(Constants.Constraints.inset)
            make.size.equalTo(Constants.Size.defaultSize * 2)
        }
        
        primaryImageView.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).offset(21)
            make.right.equalToSuperview()
            make.size.lessThanOrEqualTo(242)
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension CryptoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cryptoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIdentifiers.cryptoListCell) as! CryptoListTableViewCell
        
        let data = viewModel.cryptoData[indexPath.row]
        let price = viewModel.formatNumberSmart(data.price)
        let priceChange = viewModel.formatNumberSmart(data.priceChange)
        cell.configure(name: data.name, symbol: data.symbol, price: price, priceChange: priceChange, priceChangeValue: data.priceChange)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.Size.largeHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCrypto(crypto: viewModel.cryptoData[indexPath.row])
    }
}
