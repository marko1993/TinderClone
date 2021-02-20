//
//  Assembler+Extensions.swift
//  TinderClone
//
//  Created by Marko on 20.02.2021..
//  Copyright © 2021 Marko. All rights reserved.
//

import Foundation
import Swinject

extension Assembler {
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler([
            AppAssembly()
        ], container: container)
        return assembler
    }()
}
