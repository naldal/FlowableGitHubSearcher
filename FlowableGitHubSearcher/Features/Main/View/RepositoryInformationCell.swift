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
    
    public let thumbnailImage: UIImageView = UIImageView().then {
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
    
    private let starForkView = StarAndForkView()
    
    
    // MARK: - Component Option
    
    private func downloadImageForThumbnail(link: String) {
        self.thumbnailImage.setImage(with: link)
    }
    
    private func setTextRepositoryTitleLabel(_ repoTitle: String) {
        self.repositoryTitleLabel.text = repoTitle
    }
    
    private func setTextRepositoryDescriptionLabel(_ repoDesc: String?) {
        self.repositoryDesctiptionLabel.text = repoDesc
    }
 
    
    
    // MARK: - Layout
    
    func configureLayout() {
        self.contentView.addSubview(baseView)
        baseView.addSubviews([thumbnailImage,
                              repositoryTitleLabel,
                              repositoryDesctiptionLabel,
                              starForkView])
    }
    
    
    // MARK: - Constraint
    
    func setConstraint() {
        baseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
            thumbnailImage.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.height.equalTo(65)
            }
            
            repositoryTitleLabel.snp.makeConstraints { make in
                make.leading.equalTo(thumbnailImage.snp.trailing).offset(14)
                make.top.equalTo(thumbnailImage.snp.top)
                make.trailing.equalToSuperview()
            }
            
            repositoryDesctiptionLabel.snp.makeConstraints { make in
                make.top.equalTo(repositoryTitleLabel.snp.bottom).offset(5)
                make.leading.trailing.equalTo(repositoryTitleLabel)
            }
            
            starForkView.snp.makeConstraints { make in
                make.lastBaseline.equalTo(thumbnailImage)
                make.leading.equalTo(repositoryTitleLabel.snp.leading)
                make.height.equalTo(13)
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
        self.setTextRepositoryTitleLabel(repositoryInfo.fullName)
        self.setTextRepositoryDescriptionLabel(repositoryInfo.itemDescription)

        self.starForkView.setStackValues(star: repositoryInfo.stargazersCount,
                                         fork: repositoryInfo.forksCount)
        
        self.configureLayout()
        self.setConstraint()
    }
    
}
