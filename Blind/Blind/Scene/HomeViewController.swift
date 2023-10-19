//
//  HomeViewController.swift
//  Blind
//
//  Created by Khai on 2023/10/18.
//

import UIKit
import FlexLayout
import PinLayout
import Then
import RxSwift

private enum Tab: String, CaseIterable {
    case home = "홈"
    case trending = "인기"
}

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    private lazy var topTabBar = UITabBar().then {
        $0.delegate = self
        $0.barTintColor = .white
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    private var mainView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        settingTabBar()
    }

    override func layout() {
        super.layout()
        
        container.flex.define {
            $0.addItem(topTabBar).marginTop(10).width(UIScreen.main.bounds.width)
            $0.addItem(mainView).width(UIScreen.main.bounds.width).height(300)
        }
    }
    
    override func bind() {
        super.bind()
    }
    
    private func settingTabBar() {
        var barItems: [UITabBarItem] = []
        Tab.allCases.forEach { tab in
            let barItem = UITabBarItem(title: tab.rawValue,
                                       image: nil,
                                       selectedImage: nil)
            barItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
            barItems.append(barItem)
        }
        topTabBar.setItems(barItems, animated: false)
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    }
}

extension HomeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "홈" {
            mainView = HomeView()
        } else {
            mainView = TrendView()
        }
        mainView.flex.markDirty()
    }
}
