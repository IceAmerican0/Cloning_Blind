//
//  TrendView.swift
//  Blind
//
//  Created by Khai on 2023/10/18.
//

import UIKit
import FlexLayout
import PinLayout
import Then

final class TrendView: UIView {
    private let container = UIView()
    
    private let textLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.text = "Trend"
    }
    
    public init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
    
    private func layout() {
        self.flex.addItem(container).alignItems(.center).justifyContent(.center).width(100%).height(100%).define {
            $0.addItem(textLabel)
        }
    }
}
