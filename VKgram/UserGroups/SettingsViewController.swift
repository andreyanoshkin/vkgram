//
//  SettingsViewController.swift
//  
//
//  Created by Andrey on 31/01/2021.
//

import UIKit

struct SectionData {
    let sectionTitle: String
    let rowTitles: [(title: String, VC: UIViewController)]
    var switchIsShown: Bool
}

class SettingsViewController: UIViewController {
    
    var mainView = SettingsMainView()

    let anotherTestVC = UIViewController()
    
    private (set) var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "LogoutIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var accountData: [SectionData] = [
        SectionData(sectionTitle: "Аккаунт", rowTitles: [(title: "Личная информация", VC: anotherTestVC),
                                                                (title: "Реквизиты",VC: anotherTestVC),
                                                                (title: "Сообщения",VC: anotherTestVC),
                                                                (title: "Избранное", VC: anotherTestVC)], switchIsShown: false),
        SectionData(sectionTitle: "Уведомления", rowTitles: [(title: "Push-уведомления", VC: anotherTestVC),
                                                                        (title: "Sms рассылка", VC: anotherTestVC),
                                                                        (title: "Email рассылка", VC: anotherTestVC)], switchIsShown: true),
        SectionData(sectionTitle: "Поддержка", rowTitles: [(title: "Чат с поддержкой",VC: anotherTestVC)], switchIsShown: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainView
        mainView.parentViewController = self
        mainView.accountData = self.accountData
        mainView.configureTableView()
        setupNavigationBar()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupNavigationBar() {
        logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false // TODO: to find out why the edge is not visible
    }
    
    @objc func logoutButtonPressed(_ sender: Any) {
        
        debugPrint("Logged out successfully")
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        logoutButton.widthAnchor.constraint(equalToConstant: 18),
        logoutButton.heightAnchor.constraint(equalToConstant: 18)
            ])
    }
    
}

