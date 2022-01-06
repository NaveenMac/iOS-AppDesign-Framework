//
//  OverlayViewController.swift
//  UserNominees
//
//  Created by Naveen Chauhan on 06/01/22.
//

import UIKit

class OverlayViewController: UIViewController {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    // Constants
    let defaultHeight: CGFloat = 300
    let dismissibleHeight: CGFloat = 200
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    // keep current new height, initial is default height
    var currentContainerHeight: CGFloat = 300
    
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // tap gesture on dimmed view to dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        
        setupPanGesture()
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //animateShowDimmedView()
        animatePresentContainer()
    }
    

    private func setupView() {
         view.backgroundColor = .clear
        self.view.addSubview(dimmedView)
        dimmedView.anchor(
            top: self.view.topAnchor,
            left: self.view.leftAnchor,
            bottom: self.view.bottomAnchor,
            right: self.view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0   ,
            enableInsets:true)
        self.view.addSubview(containerView)
        containerView.anchor(
            top: nil,
            left: self.view.leftAnchor,
            bottom: nil,
            right: self.view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0   ,
            enableInsets:false)
         
         containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
         containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
         containerViewHeightConstraint?.isActive = true
         containerViewBottomConstraint?.isActive = true
         
     }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    
    // MARK: Present and dismiss animation
    func animatePresentContainer() {
        // update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerView.layer.cornerRadius = 0
            self.containerViewBottomConstraint?.constant = 0
            self.containerView.roundCorners(corners: [.topLeft, .topRight], radius: 16)
            
            
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        self.dimmedView.alpha = self.maxDimmedAlpha
    }
    
    func animateDismissView() {
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            NotificationCenter.default.removeObserver(self)
            // once done, dismiss without animation
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: false)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupPanGesture() {
         // add pan gesture recognizer to the view controller's view (the whole screen)
         let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
         // change to false to immediately listen on gesture movement
         panGesture.delaysTouchesBegan = false
         panGesture.delaysTouchesEnded = false
         view.addGestureRecognizer(panGesture)
     }
     
     // MARK: Pan gesture handler
     @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
         let translation = gesture.translation(in: view)
         // Drag to top will be minus value and vice versa
         print("Pan gesture y offset: \(translation.y)")
         
         // Get drag direction
         let isDraggingDown = translation.y > 0
         print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
         
         // New height is based on value of dragging plus current container height
         let newHeight = currentContainerHeight - translation.y
         
         // Handle based on gesture state
         switch gesture.state {
         case .changed:
             // This state will occur when user is dragging
             if newHeight < maximumContainerHeight {
                 // Keep updating the height constraint
                 containerViewHeightConstraint?.constant = newHeight
                 // refresh layout
                 view.layoutIfNeeded()
             }
         case .ended:
             // This happens when user stop drag,
             // so we will get the last height of container
             
             // Condition 1: If new height is below min, dismiss controller
             if newHeight < dismissibleHeight {
                 self.animateDismissView()
             }
             else if newHeight < defaultHeight {
                 // Condition 2: If new height is below default, animate back to default
                 animateContainerHeight(defaultHeight)
             }
             else if newHeight < maximumContainerHeight && isDraggingDown {
                 // Condition 3: If new height is below max and going down, set to default height
                 animateContainerHeight(defaultHeight)
             }
             else if newHeight > defaultHeight && !isDraggingDown {
                 // Condition 4: If new height is below max and going up, set to max height at top
                 animateContainerHeight(maximumContainerHeight)
             }
         default:
             break
         }
     }
    
    @objc internal func keyboardWillShow(_ notification : Notification?) -> Void {
        
        var _kbSize:CGSize!
        
        if let info = notification?.userInfo {

            let frameEndUserInfoKey = UIResponder.keyboardFrameEndUserInfoKey
            
            //  Getting UIKeyboardSize.
            if let kbFrame = info[frameEndUserInfoKey] as? CGRect {
                
                let screenSize = UIScreen.main.bounds
                
                //Calculating actual keyboard displayed size, keyboard frame may be different when hardware keyboard is attached (Bug ID: #469) (Bug ID: #381)
                let intersectRect = kbFrame.intersection(screenSize)
                
                if intersectRect.isNull {
                    _kbSize = CGSize(width: screenSize.size.width, height: 0)
                } else {
                    _kbSize = intersectRect.size
                }
                let newHeight = self.defaultHeight + _kbSize.height
                self.animateContainerHeight(newHeight)
            }
        }
    }
}
