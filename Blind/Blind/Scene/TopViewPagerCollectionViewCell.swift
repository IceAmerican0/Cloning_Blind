//
//  TopViewPagerCollectionViewCell.swift
//  Blind
//
//  Created by Khai on 2023/10/23.
//

import UIKit
import PinLayout
import FlexLayout
import Then
import RxSwift

final class TopViewPagerCollectionViewCell: UICollectionViewCell {
    var bag = DisposeBag()
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textAlignment = .center
    }
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.flex.layout()
    }
    
    func layout() {
        backgroundColor = .clear
        contentView.flex.alignItems(.center).justifyContent(.center).define {
            $0.addItem(titleLabel)
        }
    }
}
