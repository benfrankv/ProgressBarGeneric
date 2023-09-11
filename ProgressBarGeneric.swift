//
//  ProgressBarGeneric.swift
//
//  Created by Ben Frank V. on 04/09/23 based in anwser by Dravidian in the next post: https://stackoverflow.com/questions/39215050/how-to-make-a-custom-progress-bar-in-swift-ios
//

import UIKit

class ProgressBarGeneric {
    
    private var borderLayer : CAShapeLayer = CAShapeLayer()
    private let progressLayer : CAShapeLayer = CAShapeLayer()
    private var progressValue: Float = .zero
    private var totalValue: Int = .zero
    private var progressBarColor: UIColor = .white
    private var fillBarColor: UIColor = .blue
    private var viewCornerRadius : CGFloat = .zero
    private var interBorder: CGFloat = .zero
    private var baseView: UIView = UIView()
    
    func setData(progressValue: Int, totalValue: Int, progressBarColor: UIColor = .white, fillBarColor: UIColor = .blue, cornerRadius: CGFloat = .zero, internBorder: CGFloat = .zero, targetView: UIView){
        self.progressValue = adjustAdvance(progressValue: progressValue, totalValue: totalValue, viewWidht: targetView.frame.width)
        self.totalValue = totalValue
        self.progressBarColor = progressBarColor
        self.fillBarColor = fillBarColor
        self.viewCornerRadius = cornerRadius
        self.interBorder = internBorder
        self.baseView = targetView
        self.drawProgressLayer()
        self.rectProgress()
        
    }
    
    func adjustAdvance(progressValue: Int, totalValue: Int, viewWidht: CGFloat) -> Float{
        let progress: Float = Float(progressValue)
        let total: Float = Float(totalValue)
        let widht: Float = Float(viewWidht)
        return ((progress * widht)/total)
        
    }
    
    func drawProgressLayer(){
        let bezierPath = UIBezierPath(roundedRect: baseView.bounds, cornerRadius: viewCornerRadius)
        bezierPath.close()
        borderLayer.path = bezierPath.cgPath
        borderLayer.fillColor = progressBarColor.cgColor
        borderLayer.strokeEnd = .zero
        baseView.layer.addSublayer(borderLayer)
        
    }
    
    //Make sure the value that you want in the function `rectProgress` that is going to define
    //the width of your progress bar must be in the range of
    // 0 <--> viewProg.bounds.width - 10 , reason why to keep the layer inside the view with some border left spare.
    //if you are receiving your progress values in 0.00 -- 1.00 range , just multiply your progress values to viewProg.bounds.width - 10 and send them as *incremented:* parameter in this func
    
    func rectProgress(){
        let cgProgress = CGFloat(progressValue)
        if cgProgress <= baseView.bounds.width - (2 * interBorder){
            progressLayer.removeFromSuperlayer()
            let bezierPathProg = UIBezierPath(roundedRect: CGRectMake(interBorder, interBorder, cgProgress, baseView.bounds.height - (2 * interBorder)), cornerRadius: viewCornerRadius)
            bezierPathProg.close()
            progressLayer.path = bezierPathProg.cgPath
            progressLayer.fillColor = fillBarColor.cgColor
            borderLayer.addSublayer(progressLayer)
        }
        
    }
}


