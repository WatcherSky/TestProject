//
//  LoginViewController.swift
//  TestApplication
//
//  Created by Владимир on 25.05.2025.
//

import Foundation
import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    //MARK: - Properties
    
    private let viewModel: LoginViewModel
    private let backgroundSV = UIScrollView()
    private let loginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.Images.loginImage)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = Constants.Login.LoginColors.imageViewColor
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var loginTextFieldView: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.font = Constants.Fonts.baseFont(size: Constants.Login.LoginFontSize.defaultSize)
        textField.backgroundColor = Constants.Login.LoginColors.textFieldColor
        textField.delegate = self
        return textField
    }()
    
    private let userIcon: UIImage = {
        var icon = UIImage()
        if let image = UIImage(named: Constants.Images.userIcon) {
            icon = image
        }
        return icon
    }()
    
    private lazy var passwordTextFieldView: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = Constants.Fonts.baseFont(size: Constants.Login.LoginFontSize.defaultSize)
        textField.backgroundColor = Constants.Login.LoginColors.textFieldColor
        textField.delegate = self
        return textField
    }()
    
    private let passwordIcon: UIImage = {
        var icon = UIImage()
        if let image = UIImage(named: Constants.Images.passwordIcon) {
            icon = image
        }
        return icon
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - vc lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupKeyboardHandling()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginTextFieldView.layer.cornerRadius = Constants.Login.LoginCornerRadius.cornerRadius
        passwordTextFieldView.layer.cornerRadius = Constants.Login.LoginCornerRadius.cornerRadius
        loginButton.layer.cornerRadius = Constants.Login.LoginCornerRadius.cornerRadius
    }
    
    private func setupKeyboardHandling() {
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
        initializeHideKeyboard()
    }
    
    private func initializeHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc private func dismissMyKeyboard() {
        if loginTextFieldView.isFirstResponder || passwordTextFieldView.isFirstResponder {
            view.endEditing(true)
        }
    }
    
    @objc private func loginAction() {
        if loginTextFieldView.text == "1234" && passwordTextFieldView.text == "1234" {
            UserDefaults.standard.setUserLoggedIn(true)
            viewModel.login()
        } else {
            showAlert(title: "Ошибка", message: "Введены неправильные логин и пароль", firstButtonTitle: "Повторить", secondButtonTitle: "Отменить") { [weak self] in
                self?.loginTextFieldView.text = ""
                self?.passwordTextFieldView.text = ""
            }
        }
    }
    
    //MARK: - Configure View & Constraints
    
    private func configureView() {
        view.backgroundColor = Constants.Login.LoginColors.backgroundColor
        view.addSubview(backgroundSV)
        
        [loginImageView, loginTextFieldView, passwordTextFieldView, loginButton].forEach {
            backgroundSV.addSubview($0)
        }
        
        loginTextFieldView.setIcon(userIcon)
        passwordTextFieldView.setIcon(passwordIcon)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        backgroundSV.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        loginImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(Constants.Login.LoginConstraints.loginImageInset)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(view.bounds.width - 2 * 44)
        }
        
        loginTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(loginImageView.snp.bottom).offset(Constants.Login.LoginConstraints.loginFieldTop)
            make.left.right.equalToSuperview().inset(Constants.Login.LoginConstraints.inset)
            make.height.equalTo(Constants.Login.LoginConstraints.height)
        }
        
        passwordTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(loginTextFieldView.snp.bottom).offset(Constants.Login.LoginConstraints.offset)
            make.left.right.equalToSuperview().inset(Constants.Login.LoginConstraints.inset)
            make.height.equalTo(Constants.Login.LoginConstraints.height)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextFieldView.snp.bottom).offset(Constants.Login.LoginConstraints.offset)
            make.left.right.equalToSuperview().inset(Constants.Login.LoginConstraints.inset)
            make.height.equalTo(Constants.Login.LoginConstraints.height)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

//MARK: - Keyboard Show or Hide Method

extension LoginViewController {
    @objc private func keyboardWillShowOrHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
              let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return }
        
        let keyboardFrame = endValue.cgRectValue
        let keyboardHeight = keyboardFrame.height - view.safeAreaInsets.bottom
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            backgroundSV.contentInset.bottom = keyboardHeight
            backgroundSV.verticalScrollIndicatorInsets.bottom = keyboardHeight
        } else {
            backgroundSV.contentInset = .zero
            backgroundSV.verticalScrollIndicatorInsets = .zero
        }
        
        if let activeField = [loginTextFieldView, passwordTextFieldView].first(where: { $0.isFirstResponder }) {
            let fieldFrame = activeField.convert(activeField.bounds, to: backgroundSV)
            let scrollOffset = fieldFrame.maxY - (view.bounds.height - keyboardHeight) + 20
            
            if scrollOffset > 0 {
                backgroundSV.setContentOffset(CGPoint(x: 0, y: scrollOffset), animated: true)
            }
        }
        
        let duration = durationValue.doubleValue
        let options = UIView.AnimationOptions(rawValue: UInt(curveValue.intValue << 16))
        
        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.view.layoutIfNeeded()
        }
    }
}

extension LoginViewController {
    private func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    private func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - TextField Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextFieldView {
            passwordTextFieldView.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
