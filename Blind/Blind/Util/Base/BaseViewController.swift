//
//  BaseViewController.swift
//  Blind
//
//  Created by Khai on 2023/10/18.
//

import UIKit
import RxSwift
import Then
import FlexLayout
import PinLayout

public class BaseViewController<ViewModel>: UIViewController, BaseDisposeBag where ViewModel: BaseViewModel {
    
    lazy var bag: DisposeBag = {
        self.viewModel.bag
    }()
    
    var viewModel: ViewModel
    
    var container = UIView()
    
    // MARK: - Initialize
    
    init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        container.pin.all(view.pin.safeArea)
        container.flex.layout()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(container)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func layout() { }
    
    func bind() {
        viewBinding()
        viewModelBinding()
    }
    
    func viewBinding() {}
    
    func viewModelBinding() {
        viewModel
            .navigationPopViewControllerRelay
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: bag)
        
        viewModel
            .navigationPushViewControllerRelay
            .bind(with: self) { owner, viewController in
                guard let viewController else { return }
                owner.navigationController?.pushViewController(viewController, animated: true)
            }
            .disposed(by: bag)
    }
}
