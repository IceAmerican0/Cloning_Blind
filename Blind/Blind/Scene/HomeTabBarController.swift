//
//  HomeTabBarController.swift
//  Instagram
//
//  Created by Khai on 2023/10/18.
//

import UIKit

private enum Tab: String, CaseIterable {
    case home = "house.fill"
    case setting = "star.fill"
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .setting: return "설정"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home: return HomeViewController(EmptyViewModel())
        default: return EmptyViewController()
        }
    }
}

final class HomeTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tabBar.backgroundColor = .white
        
        settingTabs()
    }
    
    private func settingTabs() {
        var temp: [UIViewController] = []
        Tab.allCases.forEach { tab in
            let vc = tab.viewController
            vc.tabBarItem = UITabBarItem(title: tab.title,
                                         image: UIImage(systemName: tab.rawValue),
                                         selectedImage: nil)
            temp.append(vc)
        }
        viewControllers = temp.map { UINavigationController(rootViewController: $0) }
    }
}
