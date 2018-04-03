import Foundation
import PlaygroundSupport
import UIKit

open class Settings {
  
  //Line Settings
  public var primaryLineColor = UIColor.orange
  public var secondaryLineColor = UIColor.orange
  public var primaryLineWidth : CGFloat = 0.0006
  public var secondaryLineWidth: CGFloat = 0.0003
  public var alpha : CGFloat = 0.6
  public var rainbowEnabled = false
  public var threshold: Double = 0.02
  public var maxOfPoints = 800
  //***************************
  
  // For Rainbow mode Settings
  var colorHue : CGFloat = 0.01
  var colorSaturation : CGFloat = 0.5
  var colorBrightness : CGFloat = 0.8
  //************
  
  
  public init(){}
  
  
  open func getNextColorHUE() -> UIColor {
    colorHue += 0.005
    if (colorHue > 1) {
      colorHue = 0
    }
    return UIColor(hue: colorHue, saturation: colorSaturation, brightness: colorBrightness, alpha: 1.0)
  }

}


