//
//  RepositoryInformationCell.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import Kingfisher
import Then
import SnapKit
import RxSwift
import UIKit

final class RepositoryInformationCell: UITableViewCell {
    
    // MARK: - ViewModel Type
    
    var viewModel: MainViewModelType!
    
    // MARK: - Disposable
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - Components
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let thumbnailImage: UIImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private let repositoryTitleLabel = UILabel().then {
        $0.setLabelOptions(numberOfLines: 1,
                           color: UIColor.charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .bold,
                                                   size: 17)
        )
    }
    
    private let repositoryDesctiptionLabel = UILabel().then {
        $0.setLabelOptions(numberOfLines: 1,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .medium,
                                                   size: 14)
        )
    }
    
    private let starIcon = UIImageView().then {
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = .greenishGrey
    }
    
    private let startCountLabel = UILabel().then {
        $0.setLabelOptions(numberOfLines: 1,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .medium,
                                                   size: 11)
        )
    }
    
    private let watchIcon = UIImageView().then {
        $0.image = UIImage(systemName: "eye.fill")
        $0.tintColor = .greenishGrey
    }
    
    private let watchCountLabel = UILabel().then {
        $0.setLabelOptions(numberOfLines: 1,
                           color: .charcoal,
                           align: .left,
                           font: .appleSDGothicNeo(weight: .medium,
                                                   size: 11)
        )
    }
    
    
    // MARK: - Component Option
    
    private func downloadImageForThumbnail(link: String) {
        guard let thumbnailURL = URL(string: link) else {
            return
        }
        self.thumbnailImage.kf.setImage(with: thumbnailURL)
    }
    
    private func setTextRepositoryTitleLabel(_ repoTitle: String) {
        self.repositoryTitleLabel.text = repoTitle
    }
    
    private func setTextRepositoryDescriptionLabel(_ repoDesc: String?) {
        self.repositoryDesctiptionLabel.text = repoDesc
    }
    
    private func setTextStarCountLabel(_ starCount: Int) {
        self.startCountLabel.text = starCount.description
    }
    
    private func setTextWatchCountLabel(_ watchCount: Int) {
        self.watchCountLabel.text = watchCount.description
    }
    
    
    
    // MARK: - Layout
    
    func configureLayout() {
        self.contentView.addSubview(baseView)
        baseView.addSubviews([thumbnailImage,
                              repositoryTitleLabel,
                              repositoryDesctiptionLabel,
                              starIcon,
                              startCountLabel,
                              watchIcon,
                              watchCountLabel])
    }
    
    
    // MARK: - Constraint
    
    func setConstraint() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
            thumbnailImage.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(6)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(65)
            }
            
            repositoryTitleLabel.snp.makeConstraints { make in
                make.leading.equalTo(thumbnailImage.snp.trailing).offset(10)
                make.top.equalTo(thumbnailImage.snp.top)
                make.trailing.equalToSuperview()
            }
            
            repositoryDesctiptionLabel.snp.makeConstraints { make in
                make.top.equalTo(repositoryTitleLabel.snp.bottom).offset(5)
                make.leading.trailing.equalTo(repositoryTitleLabel)
            }
            
            starIcon.snp.makeConstraints { make in
                make.width.height.equalTo(13)
                make.bottom.equalTo(thumbnailImage)
                make.leading.equalTo(repositoryTitleLabel)
                
                startCountLabel.snp.makeConstraints { make in
                    make.height.equalTo(starIcon)
                    make.leading.equalTo(starIcon.snp.trailing).offset(3)
                    make.bottom.equalTo(starIcon)
                }
            }
            
            watchIcon.snp.makeConstraints { make in
                make.width.height.equalTo(13)
                make.bottom.equalTo(thumbnailImage)
                make.leading.equalTo(startCountLabel.snp.trailing).offset(8)

                watchCountLabel.snp.makeConstraints { make in
                    make.height.equalTo(watchIcon.snp.height)
                    make.leading.equalTo(watchIcon.snp.trailing).offset(3)
                    make.bottom.equalTo(watchIcon)
                }
            }
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    private func setupCell() {
        self.selectionStyle = .none
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    
    // MARK: - Bind
    
    public func bind(repositoryInfo: RepoInfo) {

        self.downloadImageForThumbnail(link: repositoryInfo.owner.avatarURL)
        self.setTextRepositoryTitleLabel(repositoryInfo.name)
        self.setTextRepositoryDescriptionLabel(repositoryInfo.itemDescription)
        self.setTextStarCountLabel(repositoryInfo.stargazersCount)
        self.setTextWatchCountLabel(repositoryInfo.watchersCount)
        self.configureLayout()
        self.setConstraint()
    }
    
}
