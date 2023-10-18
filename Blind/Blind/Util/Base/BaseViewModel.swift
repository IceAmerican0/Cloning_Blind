//
//  BaseViewModel.swift
//  Blind
//
//  Created by Khai on 2023/10/18.
//

import UIKit
import RxSwift
import RxCocoa

public protocol ViewModelBusinessLogic: AnyObject {}

public protocol ViewModelable: AnyObject {}

public class BaseViewModel: BaseDisposeBag, ViewModelable {
    let bag = DisposeBag()
    
    let navigationPopViewControllerRelay = PublishRelay<Void>()
    let navigationPushViewControllerRelay = PublishRelay<UIViewController?>()
    
    public init() {
        baseBinding()
    }
    
    func baseBinding() {}
    
    func bindInnerViewModelPresentationBindingToSelf(_ innerViewModel: BaseViewModel) {
        innerViewModel.navigationPopViewControllerRelay
            .bind(to: navigationPopViewControllerRelay)
            .disposed(by: bag)
        innerViewModel.navigationPushViewControllerRelay
            .bind(to: navigationPushViewControllerRelay)
            .disposed(by: bag)
    }
}
