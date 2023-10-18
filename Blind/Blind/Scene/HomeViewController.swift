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
    
    var view: UIView {
        switch self {
        case .home: return HomeView()
        case .trending: return TrendView()
        }
    }
}

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    private let topTabBar = UITabBar()
    
    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        settingTabBar()
    }

    override func layout() {
        super.layout()
        
        container.flex.define {
            $0.addItem(topTabBar).width(UIScreen.main.bounds.width)
        }
    }
    
    override func bind() {
        super.bind()
    }
    
    private func settingTabBar() {
        var temp: [UIView] = []
        Tab.allCases.forEach { tab in
            let vc = tab.view
//            vc.tabBarItem = UITabBarItem(title: tab.rawValue,
//                                         image: nil,
//                                         selectedImage: nil)
            temp.append(vc)
        }
    }
}
