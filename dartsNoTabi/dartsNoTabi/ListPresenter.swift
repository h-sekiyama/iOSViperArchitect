//
//  DetailPresenter.swift
//  dartsNoTabi
//
//  Created by 関山　秀光 on 2020/02/28.
//  Copyright © 2020 関山　秀光. All rights reserved.
//

import Foundation

typealias ListPresenterDependencies = (
    router: ListRouterTransitionProtocol,
    interactor: ListInteractorProtocol
)

class ListPresenter {
    
    private weak var view: ListViewController?
    /// 遷移時のパラメータ
    private let entry: ListEntryEntity
    
    /// 遷移元（VC）
    private weak var transition: ViewControllerTransition?
    
    private let dependencies: ListPresenterDependencies
    
    /// イニシャライザ
    init(
        entry: ListEntryEntity,
        view: ListViewController,
        transition: ViewControllerTransition,
        dependencies: ListPresenterDependencies? = nil) {
            // entry.propertyTypeをanalyticsに設定したいため、初期値をinit内で生成しています。
            self.dependencies = dependencies ?? ListPresenterDependencies(
                router: ListRouterTransition(),
                interactor: ListInteractor())
            self.entry = entry
            self.view = view
            self.transition = transition
        }
    
}

extension ListPresenter: ListDelegate {
    func tekito() {
        print("適当")
    }
    
    func didLoad() {

    }

    func willAppear() {

    }
}
