//
//  TabBar.swift
//  SeSAC.Heritage
//
//  Created by Joonhwan Jeon on 2021/12/10.
//

import Foundation

struct TabBarVM: Equatable {
  let tabs: [String]
  let selectedTab: Int

  func shouldReload(from oldModel: Self?) -> Bool {
    return self.tabs != oldModel?.tabs || self.selectedTab != oldModel?.selectedTab
  }
}
