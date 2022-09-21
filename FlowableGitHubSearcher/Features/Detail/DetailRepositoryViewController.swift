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
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    /// 레포 메인 라벨
    private let repoMainTitleLabel = UILabel().then {
        $0.setLabelOptions(text: "",
                           numberOfLines: 5,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .bold, size: 35)
        )

        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.lineBreakMode = .byWordWrapping
        $0.sizeToFit()
    }
    
    private let repoDescriptionLabel = UILabel().then {
        $0.setLabelOptions(text: "",
                           numberOfLines: 5,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .bold, size: 18)
        )
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        $0.lineBreakMode = .byCharWrapping
        $0.sizeToFit()
    }
    
    private let starforkStack = StarAndForkView()
    private let topicsStack = TopicsView()
    
    
    private let gotoGithubPage = UIButton().then {
        let attrString = NSMutableAttributedString()
        attrString.setAttributedString(str: "Github 페이지로 이동", color: .white, font: .appleSDGothicNeo(weight: .bold, size: 15))
        $0.setButtonStyle(attrStr: attrString,
                          bgColor: .githubBlack,
                          borderColor: .clear,
                          borderWidth: 0,
                          radius: 5)
    }
    
    
    // MARK: - Component Options
    
    private func setUserImage(link: String) {
        self.userImage.setImage(with: link)
    }
    
    private func setTextOnRepoMainTitle(_ mainTitle: String) {
        self.repoMainTitleLabel.text = mainTitle
    }
    
    private func setTextOnRepoDescription(_ description: String?) {
        self.repoDescriptionLabel.text = description
    }
    
    // MARK: - Private
    
    var githubUrl: String?
    
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
        baseView.addSubviews([userImage, contentView])
        contentView.addSubviews([repoMainTitleLabel,
                                 repoDescriptionLabel,
                                 starforkStack,
                                 topicsStack,
                                 gotoGithubPage])
        self.view.bringSubviewToFront(contentView)
    }
    
    
    // MARK: - Configure Constraints
    
    private func configureConstraints() {
    
        baseView.snp.makeConstraints { make in
            make.edges.width.height.equalToSuperview()
            
            userImage.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(180)
            }
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        repoMainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        repoDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(repoMainTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
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
        let output = self.viewModel.output
        
        // MARK: input
        
        gotoGithubPage.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self,
                      let giturl = self.githubUrl else {
                    return
                }
                if let url = URL(string: giturl) {
                    UIApplication.shared.open(url)
                }
            })
            .disposed(by: self.disposeBag)
        
        
        
        // MARK: output
        
        output.repositoryInformation
            .drive(onNext: { [weak self] info in
                guard let self = self else { return }

                self.setUserImage(link: info.owner.avatarURL)
                self.setTextOnRepoMainTitle(info.name)
                self.setTextOnRepoDescription(info.welcomeDescription)
                self.starforkStack.setStackValues(star: info.stargazersCount,
                                                  fork: info.forksCount)
                self.starforkStack.setIcon(starIcon: "starIcon".image,
                                           forkIcon: "forkIcon".image,
                                           size: 15)
                self.starforkStack.setSize(fontSize: 13)
                self.topicsStack.makeTopicsViews(topics: info.topics)
            
                self.githubUrl = info.htmlURL
            })
            .disposed(by: disposeBag)
    }
}
