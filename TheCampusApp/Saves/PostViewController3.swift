////
////  PostViewController.swift
////  TheCampusApp
////
////  Created by Yogesh Kumar on 27/09/19.
////  Copyright © 2019 Harsh Motwani. All rights reserved.
////
//
//import UIKit
//import Photos
//
//class PostViewController: ColorThemeObservingViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate{
//    
//    var selectedColor = selectedAccentColor.primaryColor
//    var unselectedColor = selectedTheme.primaryTextColor
//    
//    // MARK:- Overriden Members
//    override var inputAccessoryView:UIView{
//        get{ return self.toolbar }
//    }
//    
////    override var canBecomeFirstResponder: Bool{
////        return true
////    }
////
//    // MARK:- Main Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        setupThemeColors()
//        setupAccentColors()
//        setupText()
//        
//        // Add Notification Observers for keyboard events
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.view.endEditing(true)
//        UIView.animate(withDuration: 0.1) {
//            self.toolbar.alpha = 0
//        }
//    }
//    
//    let cancelButton: UIButton = {
//        let button = UIButton()
//        let size = CGSize(width: 30, height: 30)
//        let image = UIImage(named: "Cancel")?.resizeImage(size: size).withRenderingMode(.alwaysTemplate)
//        button.setImage(image, for: .normal)
//        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
//        return button
//    }()
//    let askButton: UIButton = {
//        let button = UIButton()
//        let size = CGSize(width: 30, height: 30)
//        button.setTitle("Ask", for: .normal)
//        button.tintColor = .white
//        button.layer.cornerRadius = 10;
//        button.backgroundColor = selectedAccentColor.secondaryColor
//        button.addTarget(self, action: #selector(handleAsk), for: .touchUpInside)
//        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
//        button.isEnabled = false
//        return button
//    }()
//    
//    override func setupNavigationBar(){
//        super.setupNavigationBar()
//        navigationItem.title = "Ask A Question"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: askButton)
//    
//        guard let navBar = navigationController?.navigationBar else{return}
//        if #available(iOS 11.0, *) {
//            // BUG:- Title doesn't return to being large when scrolled upto top
//            // Setting large title causes some issues in handling scrollview offset with keyboard events
//             navBar.prefersLargeTitles = false
//        }
//        
//    }
//    
//    func setupThemeColors() {
//        view.backgroundColor = selectedTheme.primaryColor
//        unselectedColor = selectedTheme.primaryTextColor
//        
//        margin.backgroundColor = .gray
//        toolbar.backgroundColor = selectedTheme.toolbarColor
//
//        questionHeading.keyboardAppearance = selectedTheme.keyboardStyle
//        questionHeading.textColor = selectedTheme.primaryTextColor
//        
//        questionDescription.keyboardAppearance = selectedTheme.keyboardStyle
//        questionDescription.textColor = selectedTheme.primaryTextColor
//        
//        addImageButton.tintColor = self.unselectedColor
//        addLinkButton.tintColor = self.unselectedColor
//        textOptionsButton.tintColor = self.unselectedColor
//        textOptionsView.setupColors(self.unselectedColor)
//    }
//    
//    func setupAccentColors(){
//        selectedColor = selectedAccentColor.primaryColor
//        cancelButton.tintColor = selectedAccentColor.primaryColor
//        askButton.backgroundColor = selectedAccentColor.secondaryColor
//        doneButton.backgroundColor = selectedAccentColor.primaryColor
//    }
//    
//    func setupText(){
//        tipsView.attributedText = tipAttributedString()
//        questionHeading.attributedPlaceholder = questionHeadingPlaceholderText()
//        questionDescription.attributedPlaceholder = questionDescriptionPlaceholderText()
//    }
//    
//    override func updateTheme(){
//        setupThemeColors()
//        setupText()
//    }
//    
//    override func updateAccentColor(){
//        setupAccentColors()
//        tipsView.attributedText = tipAttributedString()
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//    
//    @objc func dismissVC(){
//        dismiss(animated: true, completion: nil)
//    }
//    
//    // MARK:- UI Elements
//    let scrollView: UIScrollView = {
//        let view = UIScrollView()
//        view.backgroundColor = .clear
//        view.bounces = true
//        return view
//    }()
//    
//    let tipsView: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    func questionHeadingPlaceholderText() -> NSAttributedString{
//        let placeholder = "Start your question with \"What\", \"How\", \"Why\", etc"
//        return NSAttributedString(string: placeholder, attributes: [
//            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
//            .foregroundColor: selectedTheme.secondaryPlaceholderColor
//        ])
//    }
//    
//    func questionDescriptionPlaceholderText() -> NSAttributedString {
//        let placeholder = "Optional : Provide some extra details, add images or links"
//        return NSAttributedString(string: placeholder, attributes: [
//            .font: UIFont.systemFont(ofSize: 18, weight: .medium),
//            .foregroundColor: selectedTheme.secondaryPlaceholderColor
//        ])
//    }
//    
//    lazy var questionHeading: PlaceholderTextView = {
//        let textView = PlaceholderTextView()
//        scrollView.addSubview(textView)
//        textView.attributedPlaceholder = questionHeadingPlaceholderText()
//        textView.textContainerInset.bottom += 24
//        textView.font = .systemFont(ofSize: 20, weight: .bold)
//        textView.isScrollEnabled = false
//        textView.becomeFirstResponder()
//        textView.backgroundColor = .clear
//        return textView
//    }()
//    
//    lazy var questionDescription: PlaceholderTextView = {
//        let textView = PlaceholderTextView()
//        scrollView.addSubview(textView)
//        textView.attributedPlaceholder = questionDescriptionPlaceholderText()
////        textView.constrainRight(to: self.view)
//        textView.textContainerInset.bottom += 24
//        textView.font = .systemFont(ofSize: 16)
//        textView.isScrollEnabled = false
//        textView.backgroundColor = .clear
//        return textView
//    }()
//    
//    let margin = UIView()
//    
//    // This fixes an issue of scrollView offset with keyboard
//    let bottomMargin: UIView = {
//        let view = UIView()
//        view.backgroundColor = .clear
//        return view
//    }()
//    
//    // MARK:- Tool Bar
//    lazy var toolbar: CustomToolBar = {
//        let bar = CustomToolBar()
//        bar.autoresizingMask = .flexibleHeight
//        bar.toolSpacing = 35
//        bar.edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        bar.leftItems = [addImageButton, addLinkButton, textOptionsButton]
//        bar.rightItems = [doneButton]
//        bar.layout()
//        return bar
//    }()
//    
//    lazy var leftOffset: CGFloat = {
//        let offset: CGFloat = 2 * ((toolbar.toolSpacing ?? 0) + 30) - 10
//        return offset
//    }()
//    
//    // Right Toolbar Buttons
//    let doneButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Done", for: .normal)
//        button.tintColor = .white
//        button.layer.cornerRadius = 5;
//        button.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
//        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
//        return button
//    }()
//    
//    // Left Toolbar Buttons
//    let addImageButton: ToolBarButton = {
//        let button = ToolBarButton(imageName: "AddImage")
//        button.tag = 0
//        button.addTarget(self, action: #selector(handleButtonColor), for: .touchUpInside)
//        button.addTarget(self, action: #selector(handleImageSelection), for: .touchUpInside)
//        return button
//    }()
//    var imagePickerVC: UIImagePickerController = {
//        let picker = UIImagePickerController()
//        picker.sourceType = .photoLibrary
//        picker.allowsEditing = false
//        return picker
//    }()
//    
//    let addLinkButton: ToolBarButton = {
//        let button = ToolBarButton(imageName: "Link")
//        button.tag = 1
//        button.addTarget(self, action: #selector(handleButtonColor), for: .touchUpInside)
//        return button
//    }()
//    
//    let textOptionsButton: ToolBarButton = {
//        let button = ToolBarButton(imageName: "Paragraph")
//        button.tag = 2
//        button.addTarget(self, action: #selector(handleButtonColor), for: .touchUpInside)
//        button.addTarget(self, action: #selector(handleTextOptions), for: .touchUpInside)
//        return button
//    }()
//    
//    // Text Options
//    lazy var textOptionsView: TextFormatOptionsView = {
//        let view = TextFormatOptionsView()
//        view.backgroundColor = .clear
//        view.initialise(self.unselectedColor)
//        return view
//    }()
//    
//    func setupUI(){
//        // Add Subviews
//        view.addSubview(scrollView)
//        scrollView.addSubview(tipsView)
//        scrollView.addSubview(margin)
//        scrollView.addSubview(bottomMargin)
//        toolbar.insertSubview(textOptionsView, belowSubview: doneButton)
//        
//        // Setup Delegates
//        questionHeading.delegate = self
//        questionDescription.delegate = self
//        imagePickerVC.delegate = self
//        textOptionsView.dataSource = questionDescription
//        
//        addConstraints()
//    }
//    
//    // Add Constraints
//    fileprivate func addConstraints() {
//        // Scroll View
//        scrollView.anchor(top: view.topAnchor, left: view.leadingAnchor)
//        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
//        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
//        
//        // Tips View
//        tipsView.anchor(top: scrollView.topAnchor, left: scrollView.leadingAnchor, right: view.trailingAnchor, paddingLeft: 10, paddingRight: 10)
//        
//        // Question Heading
//        questionHeading.anchor(top: tipsView.bottomAnchor, left: scrollView.leadingAnchor, right: view.trailingAnchor)
//        questionHeading.sizeToFit()
//        questionHeading.setContentOffset(CGPoint.zero, animated: false)
//        
//        // Question Description
//        questionDescription.anchor(top: margin.bottomAnchor, left: scrollView.leadingAnchor, right: view.trailingAnchor)
//        questionDescription.sizeToFit()
//        questionDescription.setContentOffset(CGPoint.zero, animated: false)
//        
//        // Margins
//        margin.anchor(top: questionHeading.bottomAnchor, left: scrollView.leadingAnchor, right: view.trailingAnchor, height: 1)
//        bottomMargin.anchor(top: questionDescription.bottomAnchor, bottom: scrollView.bottomAnchor, left: scrollView.leadingAnchor, right: view.trailingAnchor, height: 1)
//        
//        // Toolbar
//        textOptionsView.anchor(top: toolbar.topAnchor, bottom: toolbar.layoutMarginsGuide.bottomAnchor, left: toolbar.leftItems.last!.trailingAnchor ,paddingTop: 10, paddingBottom: 10, paddingLeft: 10)
//        
//        textOptionsViewRightConstraintCollapsed = textOptionsView.trailingAnchor.constraint(equalTo: textOptionsView.leadingAnchor, constant: 0)
//        textOptionsViewRightConstraintExpanded = textOptionsView.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor, constant: -10)
//        textOptionsViewRightConstraintCollapsed.isActive = true
//    }
//    
//    lazy var toolbarHideConstraint = toolbar.heightAnchor.constraint(equalToConstant: 0)
//    
//    var textOptionsViewRightConstraintExpanded: NSLayoutConstraint! = nil
//    var textOptionsViewRightConstraintCollapsed: NSLayoutConstraint! = nil
//    
//    @objc func handleImageSelection(){
//        checkPermission()
//    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        
//        guard let image = info[.originalImage] as? UIImage,
//            let scaledImage = image.resized(toWidth: self.questionDescription.frame.size.width - 10),
//            let encodedString = scaledImage.jpegData(compressionQuality: 0.5)?.base64EncodedString(),
//            let attributedString = NSAttributedString(base64EndodedImageString: encodedString) else {return}
//
//        questionDescription.textStorage.insert(attributedString, at: questionDescription.selectedRange.location)
//        questionDescription.textStorage.insert(NSAttributedString(string: "\n"), at: questionDescription.selectedRange.location + 1)
//        handlePlaceholder(questionDescription, 1)
//        questionDescription.font = .systemFont(ofSize: 16)
//        dismiss(picker: picker)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
//        dismiss(picker: picker)
//    }
//    
//    func dismiss(picker: UIImagePickerController){
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        let finalFrame = view.bounds.offsetBy(dx: 0, dy: UIScreen.main.bounds.size.height)
////        toolbarHideConstraint.isActive = false
//        self.toolbar.isHidden = false
//        self.toolbar.isUserInteractionEnabled = true
//        
//        UIView.animate(withDuration: 0.35, delay: 0, options: .curveLinear, animations: {
//            self.imagePickerVC.view.frame = finalFrame
//            self.toolbar.superview?.layoutIfNeeded()
//            self.tipsView.alpha = 1
//            self.toolbar.alpha = 1
//        }, completion: { _ in
//            picker.willMove(toParent: nil)
//            picker.view.removeFromSuperview()
//            picker.removeFromParent()
//            self.becomeFirstResponder()
//        })
//    }
//    func showImagePicker(){
//        self.view.endEditing(true)
////        if(self.isFirstResponder){
////            toolbar.frame = toolbar.frame.offsetBy(dx: 0, dy: -40)
////        }
//        addChild(imagePickerVC)
//        view.addSubview(imagePickerVC.view)
//        imagePickerVC.didMove(toParent: self)
//        imagePickerVC.view.frame = view.bounds.offsetBy(dx: 0, dy: UIScreen.main.bounds.size.height)
//        let finalFrame = self.view.bounds
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
////        toolbarHideConstraint.isActive = true
//        UIView.animate(withDuration: 0.35, delay: 0, options: .curveLinear, animations: {
//            self.imagePickerVC.view.frame = finalFrame
//            self.tipsView.alpha = 0
//            self.toolbar.alpha = 0
//            self.toolbar.superview?.layoutIfNeeded()
//        }, completion: { _ in
//            self.toolbar.isHidden = true
//            self.toolbar.isUserInteractionEnabled = false
//        })
//    }
//    
//    func checkPermission() {
//        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
//        switch photoAuthorizationStatus {
//        case .authorized:
//            showImagePicker()
//        case .notDetermined:
//            PHPhotoLibrary.requestAuthorization({ newStatus in
//                if newStatus == PHAuthorizationStatus.authorized {
//                    DispatchQueue.main.async {
//                        self.showImagePicker()
//                    }
//                }
//            })
//        case .restricted:
//            print("User do not have access to photo album.")
//        case .denied:
//            print("User has denied the permission.")
//        @unknown default: break
//        }
//        
//    }
//}
