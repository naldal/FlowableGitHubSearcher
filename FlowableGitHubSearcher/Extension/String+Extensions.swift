//
//  String+Extensions.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/18.
//

import Lottie
import UIKit

extension String {
    
    /// String으로 UIImage 불러오기
    var image: UIImage {
        return UIImage(named: self)?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    }
    
    /// String으로 Lottie Animation 불러오기
    var lottie: Animation {
        guard let lottieAnimation = Animation.named(self) else {
            fatalError("no Lottie file such as \(self)")
        }
        return lottieAnimation
    }
}
