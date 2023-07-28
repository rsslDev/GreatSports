//
//  UiViewExtension.swift
//  GreatSports
//
//  Created by Russel Dev on 25/07/23.
//

import UIKit

extension UIView{
    
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let window = UIApplication.shared.windows.last!
        let backgroundView = UIView(frame: window.bounds)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = activityColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        window.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        let window = UIApplication.shared.windows.last!
        if let background = window.viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}

extension UIView{
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 20)
            layer.shadowOpacity = 0.2
            layer.shadowRadius = newValue
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
            
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
           get {
               return layer.shadowOpacity
           }
           set {
               layer.shadowOpacity = newValue
           }
       }
    
    @IBInspectable var shadowOffset: CGPoint {
          get {
              return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
          }
          set {
              layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
          }

       }

    @IBInspectable var shadowBlur: CGFloat {
           get {
               return layer.shadowRadius
           }
           set {
               layer.shadowRadius = newValue / 2.0
           }
       }

//       @IBInspectable var shadowSpread: CGFloat = 0 {
//           didSet {
//               if shadowSpread == 0 {
//                   layer.shadowPath = nil
//               } else {
//                   let dx = -shadowSpread
//                   let rect = bounds.insetBy(dx: dx, dy: dx)
//                   layer.shadowPath = UIBezierPath(rect: rect).cgPath
//               }
//           }
//       }
    
    func roundedView(){
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
       
        self.clipsToBounds = true
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
       // layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.masksToBounds = false
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func cardShadow(color: UIColor, opacity: Float = 1, offSet: CGSize = CGSize(width: 2, height: 4), radius: CGFloat = 10, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    @IBInspectable
    var topCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
    }
    
    @IBInspectable
    var bottomCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        
    }
    
    @IBInspectable
    var topRightCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMaxXMinYCorner]
        }
        
    }
   
    
    
    
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    func applyGradient(colors: [Any]?, locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .topToBottom) -> CAGradientLayer {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        return gradientLayer
    }
    
//    func setCornerRadiusWithDropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true,cornerRadius: CGFloat) {
//        let shadowLayer: CAShapeLayer = CAShapeLayer()
//        layer.cornerRadius = cornerRadius
//        shadowLayer.path = UIBezierPath(roundedRect: self.bounds,
//                                        cornerRadius: 8).cgPath
//        shadowLayer.shadowColor = color.cgColor
//        shadowLayer.fillColor = backgroundColor?.cgColor
//        shadowLayer.shadowPath = shadowLayer.path
//        shadowLayer.shadowOffset = offSet
//        shadowLayer.shadowOpacity = opacity
//        shadowLayer.shadowRadius = radius
//        shadowLayer.position = self.center
//        layer.insertSublayer(shadowLayer, at: 0)
//    }
    
    func setPatternImage(_ image : UIImage){
        UIGraphicsBeginImageContext(self.frame.size)
        image.draw(in: self.bounds)

        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.backgroundColor = UIColor.init(patternImage: image);
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
         }

    }
    
}


