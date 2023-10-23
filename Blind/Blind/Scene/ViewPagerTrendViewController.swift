//
//  ViewPagerTrendViewController.swift
//  Blind
//
//  Created by Khai on 2023/10/18.
//

import UIKit
import FlexLayout
import PinLayout
import Then

final class ViewPagerTrendViewController: UIViewController {
    private let container = UIView()
    
    private let textLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.text = "Trend"
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        container.pin.all()
        container.flex.layout()
        view.addSubview(container)
    }
    
    private func layout() {
        container.flex.alignItems(.center).justifyContent(.center).define {
            $0.addItem(textLabel)
        }
    }
}
