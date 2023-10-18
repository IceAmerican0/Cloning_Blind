//
//  BaseDisposeBag.swift
//  Blind
//
//  Created by Khai on 2023/10/18.
//

import RxSwift

protocol BaseDisposeBag {
    var bag: DisposeBag { get }
}
