//  AVPlayerExtension.swift
//  JennyCraig
//  Created by Mobileprogrammingllc on 17/05/19.
//  Copyright © 2019 JennyCraig. All rights reserved.

import Foundation
import AVKit
import AVFoundation

extension AVPlayer {

    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
