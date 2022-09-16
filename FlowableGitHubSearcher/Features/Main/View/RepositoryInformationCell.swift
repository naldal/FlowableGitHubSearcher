//
//  RepositoryInformationCell.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import Then
import SnapKit
import RxSwift
import UIKit

final class RepositoryInformationCell: UITableViewCell, ViewModelBindableType {
    // MARK: - ViewModel Type
    var viewModel: MainViewModelType!
    
    // MARK: - Disposable
    let disposeBag = DisposeBag()
    
    // MARK: - Components
    private let thumbnailImage: UIImageView = UIImageView()
    private let repositoryTitle: String = ""
    
    // MARK: - Component Option
    
    
    
    // MARK: - Layout
    
    func configureLayout() {
        
    }
    
    
    // MARK: - Constraint
    
    func setConstraint() {
        
    }
    
    // MARK: - Bind
    
    func bindViewModel() {
        let _ = viewModel.input
        let _ = viewModel.output
        
        // MARK: input
        
        
        // MARK: output
        
        
    }
    
}
