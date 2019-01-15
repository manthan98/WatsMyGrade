//
//  MainViewController.swift
//  WatsMyGrade
//
//  Created by Manthan Shah on 2018-03-18.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigation()
        setupLayout()
        setupNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CourseService.shared.getCourses()
        self.collectionView.reloadData()
        self.overallGradeLabel.text = "\(GradeHelper.shared.getOverallGrade()) %"
    }
    
    // MARK: - Private
    
    private func setup() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CourseCell.self, forCellWithReuseIdentifier: "CourseCell")
        
        CourseService.shared.delegate = self
        CourseService.shared.getCourses()
    }
    
    private func setupNavigation() {
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.barTintColor = .wmg_yellow
        self.navigationItem.title = "Courses"
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        plusButton.accessibilityIdentifier = "newCoursePlusButton"
        self.navigationItem.rightBarButtonItem = plusButton
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func setupLayout() {
        // Views
        stackView.addArrangedSubview(overallGradeNameLabel)
        stackView.addArrangedSubview(overallGradeLabel)
        containerView.addSubview(stackView)
        self.view.addSubview(containerView)
        self.view.addSubview(collectionView)
        
        // Constraints
        containerView.anchor(top: self.view.topAnchor,
                             leading: self.view.leadingAnchor,
                             bottom: nil,
                             trailing: self.view.trailingAnchor)

        stackView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                         leading: containerView.leadingAnchor,
                         bottom: containerView.bottomAnchor,
                         trailing: containerView.trailingAnchor,
                         padding: .init(top: 15, left: 0, bottom: 15, right: 0))
        
        collectionView.anchor(top: containerView.bottomAnchor,
                              leading: self.view.leadingAnchor,
                              bottom: self.view.bottomAnchor,
                              trailing: self.view.trailingAnchor)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didDelete(_:)), name: NSNotification.Name.init("deleteCourse"), object: nil)
    }
    
    @objc
    private func add() {
        let newCourseViewController = NewCourseViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(newCourseViewController, animated: true)
    }
    
    @objc
    private func didDelete(_ notif: Notification) {
        if let course = notif.userInfo?["course"] as? Course, let index = currentIndex {
            NetworkManager.shared.deleteCourse(networkID: course.networkID!)
            CourseService.shared.deleteCourse(index: index, course: course)
        }
    }
    
    private var currentIndex: Int?
    
    private let collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        cv.alwaysBounceVertical = true
        cv.backgroundColor = .wmg_lightGrey
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wmg_lightGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let overallGradeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        label.text = "Overall Grade"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overallGradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-UltraLight", size: 40)
        label.text = "\(GradeHelper.shared.getOverallGrade()) %"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

}

// MARK: - CourseServiceDelegate

extension MainViewController: CourseServiceDelegate {
    
    func coursesLoaded() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

// MARK: - UICollectionView

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CourseService.shared.courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseCell", for: indexPath) as? CourseCell {
            cell.configureCell(course: CourseService.shared.courses[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 20, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gradesViewController = GradesViewController(course: CourseService.shared.courses[indexPath.row])
        self.navigationController?.pushViewController(gradesViewController, animated: true)
        currentIndex = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
}

