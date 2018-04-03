//#-hidden-code
import UIKit
//#-end-hidden-code

/*:
 # ARDrawing with Playground
 
 ---
 
 ***Alexandre Vassinievski Ribeiro***, *Mar 2018*
 
 
 The term "[Generative Art](https://en.wikipedia.org/wiki/Generative_art)" probably comes from "Generative Grammar", a linguistic theory created by Noam Chomsky and appears in his book *Aspects of the theory of syntax* (1965) to formulate rules that describes all languages.
 
 The algorithm will interact as you draw freely through the air.
 
 When you're done drawing, take a look at your creation to find a new perspective with the features of ARKit
 
 ---
 
 - Note: Touch, hold and move your iPad to Draw over the air

 ---

 - Experiment:
 Change parameters below and see the effects
 */
//#-hidden-code

import UIKit
import PlaygroundSupport

let settings = Settings()
var primaryLineWidth : CGFloat  = 12
var secondaryLineWidth : CGFloat  = 6
var primaryLineColor = UIColor.green
var secondaryLineColor = UIColor.green
var enableRainbowMode = true
var threshold: Double = 2
if #available(iOS 11.0, *){
  

let sketch = ArKitViewController()
//**************************************
//#-end-hidden-code
// Change line width
primaryLineWidth = /*#-editable-code*/12/*#-end-editable-code*/
secondaryLineWidth = /*#-editable-code*/6/*#-end-editable-code*/
// Change threshold to drawn procedural lines
threshold =  /*#-editable-code*/2/*#-end-editable-code*/
// Change line Color
primaryLineColor = /*#-editable-code*/#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)/*#-end-editable-code*/
secondaryLineColor = /*#-editable-code*/#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)/*#-end-editable-code*/
// Override Line colors and change colors dinamicaly
enableRainbowMode = /*#-editable-code*/true/*#-end-editable-code*/
//#-hidden-code
settings.primaryLineColor = primaryLineColor
settings.secondaryLineColor = secondaryLineColor
settings.primaryLineWidth = primaryLineWidth/100000
settings.secondaryLineWidth = secondaryLineWidth/100000
settings.rainbowEnabled = enableRainbowMode
settings.threshold = threshold/100
settings.maxOfPoints = 800
settings.alpha = 0.5

sketch.settings = settings

PlaygroundPage.current.liveView = sketch
PlaygroundPage.current.needsIndefiniteExecution = true
}
else {}
//#-end-hidden-code

