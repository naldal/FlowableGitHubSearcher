//
//  LottieManager.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/19.
//

import Lottie
import UIKit

final class LottieManager {
    
    static let shared = LottieManager()
    private init() { }
    
    private(set) var managedLottieAnimation: AnimationView = AnimationView(frame: CGRect.zero)
    
    public func setLottie(animation: Animation, mode: LottieLoopMode = .playOnce) {
        self.managedLottieAnimation.animation = animation
        self.managedLottieAnimation.loopMode = mode
    }
    
    public func startLottie() {
        self.managedLottieAnimation.play()
    }
    
    public func stopLottie() {
        self.managedLottieAnimation.stop()
        self.managedLottieAnimation.removeFromSuperview()
    }
    
}
