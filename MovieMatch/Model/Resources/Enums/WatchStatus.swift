//
//  WatchStatus.swift
//  MovieMatch
//
//  Created by Cameron Slash on 14/2/22.
//

import Foundation

enum WatchStatus: Int32, CaseIterable {
    case watched = 0, want = 1
}

extension WatchStatus {
    public var displayName: String {
        switch self {
        case .watched:
            return "Watched"
        case .want:
            return "Want To Watch"
        }
    }
}
