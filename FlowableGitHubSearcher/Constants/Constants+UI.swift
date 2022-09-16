//
//  Constants+UI.swift
//  FlowableGitHubSearcher
//
//  Created by 송하민 on 2022/09/16.
//

import UIKit

extension Constants {
    
    // MARK: - Device Screen
    
    struct DeviceScreen {
        static let SCREEN_SCALE: CGFloat = UIScreen.main.scale
        static let DEVICE_WIDTH: CGFloat = UIScreen.main.bounds.size.width
        static let DEVICE_HEIGHT: CGFloat = UIScreen.main.bounds.size.height
        static let DEVICE_SIZE: CGSize = CGSize(width: DEVICE_WIDTH, height: DEVICE_HEIGHT)
        static let SAFE_AREA_TOP: CGFloat = UIApplication.shared.windows[0].safeAreaInsets.top
        static let SAFE_AREA_BOTTOM: CGFloat = UIApplication.shared.windows[0].safeAreaInsets.bottom
    }
    
    
    // MARK: SafeArea

    enum SafeArea {
      /// 44.0 or 47 or 48
      public static let top: CGFloat = UIApplication.shared.windows
        .filter { $0.isKeyWindow }
        .first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0

      /// 34.0
      public static var bottom: CGFloat {
        let bottom = UIApplication.shared.windows
          .filter { $0.isKeyWindow }
          .first?.safeAreaInsets.bottom ?? 0.0

        if bottom.isZero {
          return 34.0
        }

        return bottom
      }
    }
}
