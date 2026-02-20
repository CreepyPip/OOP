//
//  leapyear.swift
//  dateClass
//
//  Created by Семён on 20.02.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

import Foundation

func leapyear(y:Int) -> Bool{
    return (y % 4 == 0 || y == 0)
}
