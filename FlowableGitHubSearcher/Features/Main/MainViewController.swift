//
//  ViewController.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import Lottie
import Then
import SnapKit
import RxCocoa
import RxSwift
import UIKit
import RxFlow

class MainViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModelType
    
    var viewModel: MainViewModelType!
    
    
    // MARK: - Components
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var loadingAnimationView = LottieManager.shared.managedLottieAnimation
    
    private let searchField = UISearchBar().then {
        $0.positionAdjustment(for: .search)
        $0.searchTextPositionAdjustment = UIOffset(horizontal: 10, vertical: .zero)
        $0.setPositionAdjustment(UIOffset(horizontal: 10, vertical: .zero), for: .search)
        
        $0.setSearchBarOptions(tintColor: .white,
                               cornerRadius: 21,
                               borderWidth: 0.8,
                               borderColor: .brightOrange)
        
        if let textField = $0.getTextField() {
            textField.setTextFieldOptions(textColor: .charcoal,
                                          font: .appleSDGothicNeo(weight: .medium,
                                                                  size: 16),
                                          align: .left,
                                          keyboardType: .alphabet
            )
            textField.clearButtonMode = .whileEditing
            textField.setPlaceHolder(text: "검색어를 입력해주세요", color: .greenishGrey)
            
            if let glassIconView = textField.leftView as? UIImageView {
                glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
                glassIconView.tintColor = .greenishGrey
            }
        }
    }
    
    private let repositoriesTableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .singleLine
        $0.layoutMargins = .zero
        $0.backgroundColor = .white
        $0.bounces = false
    }
    
    
    // MARK: - Component Options
    
    private func configureTableView() {
        self.repositoriesTableView.delegate = self
        self.repositoriesTableView.register(RepositoryInformationCell.self, forCellReuseIdentifier: Constants.CellIdentifier.repositoryInformationCell)
        self.repositoriesTableView.separatorInset = UIEdgeInsets.zero
    }

    // MARK: - DisposeBag
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LottieManager.shared.setLottie(animation: "loadingLottie".lottie, mode: .loop)
        
        self.configureTableView()
        self.setLayout()
        self.configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - Set Layout
    
    private func setLayout() {
        self.view.addSubview(baseView)
        baseView.addSubviews([searchField,
                              repositoriesTableView])
    }
    
    private func setLottieLayout() {
        repositoriesTableView.addSubview(loadingAnimationView)
    }
    
    
    // MARK: - Configure Constraints
    
    private func configureConstraints() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
            searchField.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(Constants.DeviceScreen.SAFE_AREA_TOP)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(50)
            }
            repositoriesTableView.snp.makeConstraints { make in
                make.top.equalTo(searchField.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    private func configureLottieConstraints() {
        loadingAnimationView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(150)
        }
    }

    // MARK: - Bind
    
    func bindViewModel() {
        let input = self.viewModel.input
        let output = self.viewModel.output
        
        // MARK: Input
        
        searchField.getTextField()?.rx.value
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .bind(to: input.searchValue)
            .disposed(by: self.disposeBag)
        
        repositoriesTableView.rx
            .modelSelected(RepoInfo.self)
            .asDriver()
            .drive(onNext: { [weak self] information in
                guard let self = self else { return }
                self.view.endEditing(true)
                input.steps.accept(FlowSteps.detailRepositoryInformationIsRequired(repoName: information.name,
                                                                                   ownerName: information.owner.login)
                )
            })
            .disposed(by: self.disposeBag)
        
        repositoriesTableView.rx.didScroll
            .asDriver()
            .drive(onNext: { _ in
                self.view.endEditing(false)
            })
            .disposed(by: self.disposeBag)
        
        
        // MARK: Output
        
        output.searchStartTrigger
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                if !self.repositoriesTableView.subviews.contains(self.loadingAnimationView) {
                    self.setLottieLayout()
                    self.configureLottieConstraints()
                }
                LottieManager.shared.startLottie()
            })
            .disposed(by: self.disposeBag)
        
        output.repositoryInformations
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: self.repositoriesTableView.rx.items(cellIdentifier: Constants.CellIdentifier.repositoryInformationCell,
                                                          cellType: RepositoryInformationCell.self)) { [weak self] (index, model, cell) in
                guard let _ = self else { return }
                cell.contentView.clipsToBounds = false
                cell.clipsToBounds = true
                cell.contentView.backgroundColor = .clear
                
                cell.bind(repositoryInfo: model)
                LottieManager.shared.stopLottie()
            }
            .disposed(by: self.disposeBag)
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
}
