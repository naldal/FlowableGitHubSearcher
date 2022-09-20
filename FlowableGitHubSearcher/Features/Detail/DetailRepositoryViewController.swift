//
//  DetailRepositoryViewController.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import Then
import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class DetailRepositoryViewController: UIViewController, ViewModelBindableType {

    var viewModel: DetailRepositoryViewModel!
    
    // MARK: - Components
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    /// 유저 이미지
    private let userImage = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    /// 레포 메인 라벨
    private let repoMainTitleLabel = UILabel().then {
        $0.setLabelOptions(text: "Fastlane",
                           numberOfLines: 1,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .bold, size: 35)
        )

        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
    }
    
    private let repoDescriptionLabel = UILabel().then {
        $0.setLabelOptions(text: "Ansible role - jenkins CI",
                           numberOfLines: 1,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .bold, size: 18)
        )
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
    }
    
    private let starforkStack = StarAndForkView()
    private let topicsStack = TopicsView()
    
    private let createdDate = UILabel().then {
        $0.setLabelOptions(text: "Created at: ",
                           numberOfLines: 1,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .medium,
                                                   size: 16)
        )
    }
    
    private let updatedDate = UILabel().then {
        $0.setLabelOptions(text: "Updated at: ",
                           numberOfLines: 1,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .medium,
                                                   size: 16)
        )
    }
    
    private let gotoGithubPage = UIButton().then {
        let attrString = NSMutableAttributedString()
        attrString.setAttributedString(str: "Github 페이지로 이동", color: .charcoal, font: .appleSDGothicNeo(weight: .bold, size: 15))
        $0.setButtonStyle(attrStr: attrString,
                          bgColor: .gray,
                          borderColor: .clear,
                          borderWidth: 0,
                          radius: 5)
    }
    
    
    // MARK: - Component Options
    
    
    
    // MARK: - DisposeBag
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
        self.configureConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.input.viewWillAppear.onNext(())
    }
    
    
    // MARK: - Set Layout
    
    private func setLayout() {
        self.view.addSubview(baseView)
        baseView.addSubviews([userImage,
                              repoMainTitleLabel,
                              repoDescriptionLabel,
                              starforkStack,
                              topicsStack,
                              createdDate,
                              updatedDate,
                              gotoGithubPage])
    }
    
    
    // MARK: - Configure Constraints
    
    private func configureConstraints() {
    
        baseView.snp.makeConstraints { make in
            make.edges.width.height.equalToSuperview()
        }
        
        userImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
        
        repoMainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
            make.width.equalToSuperview()
        }
        
        repoDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(repoMainTitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        starforkStack.snp.makeConstraints { make in
            make.top.equalTo(repoDescriptionLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(16)
        }
        
        topicsStack.snp.makeConstraints { make in
            make.top.equalTo(starforkStack.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        gotoGithubPage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20+Constants.DeviceScreen.SAFE_AREA_BOTTOM)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }
        
    }
    
    
    // MARK: - Bind
    
    func bindViewModel() {
        let _ = self.viewModel.input
        let output = self.viewModel.output
        
        // MARK: input
        
        // MARK: output
        
        output.repositoryInformation
            .drive(onNext: { info in
                print("info ~~> \(info)")
                
                self.topicsStack.makeTopicsViews(topics: ["asdfg","asdfg","asdfg","asdfg"])
            })
            .disposed(by: disposeBag)
    }
}
