//
//  ViewController.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/15.
//

import Then
import SnapKit
import RxCocoa
import RxSwift
import UIKit

class MainViewController: UIViewController, ViewModelBindableType {
    
    // MARK: - ViewModelType
    
    var viewModel: MainViewModelType!
    
    
    // MARK: - Components
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let searchField = UISearchBar().then {
        $0.backgroundColor = .red
        $0.placeholder = "검색어를 입력해주세요"
        
        $0.positionAdjustment(for: .search)
        $0.searchTextPositionAdjustment = UIOffset(horizontal: 10, vertical: .zero)
        $0.setPositionAdjustment(UIOffset(horizontal: 10, vertical: .zero), for: .search)
        
        $0.isTranslucent = false
        $0.barTintColor = .white
        $0.getTextField()?.backgroundColor = .gray
        
        $0.layer.cornerRadius = 25
        $0.layer.borderWidth = 0.8
        $0.layer.borderColor = UIColor.brightOrange.cgColor
        $0.clipsToBounds = true
        
        let textField = $0.value(forKey: "searchField") as? UITextField
        textField?.textColor = .charcoal
        textField?.clearButtonMode = .whileEditing
    }
    
    private let repositoriesTableView = UITableView().then {
        $0.backgroundColor = .gray
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.rowHeight = 84
        $0.separatorStyle = .singleLine
        $0.layoutMargins = .zero
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // TODO
        $0.bounces = false
    }
    
    
    // MARK: - Component Options

    // MARK: - DisposeBag
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setLayout()
        self.configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.input.viewWillAppear.accept(())
    }
    
    
    // MARK: - Set Layout
    
    private func setLayout() {
        self.view.addSubview(baseView)
        baseView.addSubviews([searchField, repositoriesTableView])
    }
    
    
    // MARK: - Configure Constraints
    
    private func configureConstraints() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
            searchField.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(Constants.DeviceScreen.SAFE_AREA_TOP)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(90)
            }
            
            repositoriesTableView.snp.makeConstraints { make in
                make.top.equalTo(searchField.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalToSuperview()
            }
        }

    }

    // MARK: - Bind
    
    func bindViewModel() {
        let output = self.viewModel.output
        
        output.testOutput
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: self.disposeBag)
        
        output.realDataOutput
            .drive(onNext: { repos in
                print("repose ~> \(repos)")
            })
            .disposed(by: self.disposeBag)
    }
    
}

