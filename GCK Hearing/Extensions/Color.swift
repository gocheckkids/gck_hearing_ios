//
//  Color.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = GreenColorTheme()
//    static let theme2 = ColorTheme()
    static let launch = LaunchTheme()
    static let blueTheme = BlueColorTheme()
    static let deepBlueTheme = DeepBlueColorTheme()
    
}

//struct ColorTheme {
//    let accent = Color("AccentColor")
//    let background = Color("BackgroundColor")
//    let green = Color("GreenColor")
//    let red = Color("RedColor")
//    let secondaryText = Color("SecondaryTextColor")
//}

struct GreenColorTheme {
    let accent = Color(#colorLiteral(red: 0.4, green: 0.831372549, blue: 0.7333333333, alpha: 1))
    let background = Color(#colorLiteral(red: 0, green: 0.431372549, blue: 0.3333333333, alpha: 1))
    
    let secondaryText = Color(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))
}

struct BlueColorTheme {
    let accent = Color(#colorLiteral(red: 0.6, green: 0.8549019608, blue: 0.8901960784, alpha: 1))
    let accentDark = Color(#colorLiteral(red: 0.4, green: 0.7803921569, blue: 0.831372549, alpha: 1))
    let background = Color(#colorLiteral(red: 0, green: 0.5725490196, blue: 0.6509803922, alpha: 1))
}

struct DeepBlueColorTheme {
    let accent = Color(#colorLiteral(red: 0.7019607843, green: 0.8078431373, blue: 0.8431372549, alpha: 1))
    let accentDark = Color(#colorLiteral(red: 0.5019607843, green: 0.6823529412, blue: 0.737254902, alpha: 1))
    let background = Color(#colorLiteral(red: 0, green: 0.3607843137, blue: 0.4705882353, alpha: 1))
}


struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
