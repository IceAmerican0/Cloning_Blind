//
//  TrendView.swift
//  Blind
//
//  Created by Khai on 2023/10/18.
//

import UIKit

final class TrendView: UIView {
    public init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .red
    }
}
