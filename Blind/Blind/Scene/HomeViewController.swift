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
    
    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    private var mainView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        mainView.addSubview(HomeView())
    }

    override func layout() {
        super.layout()
        
        container.flex.define {
            $0.addItem(mainView).grow(1)
        }
    }
    
    override func bind() {
        super.bind()
    }
}
