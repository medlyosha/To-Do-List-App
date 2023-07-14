//
//  MainView.swift
//  To-Do List
//
//  Created by Lesha Mednikov on 12.07.2023.
//
import UIKit
import SnapKit
protocol MainViewDelegate: AnyObject {
    func addButtonTapped()
}
class MainView: UIView {
    weak var delegate: MainViewDelegate?
    let addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: nil, action: nil)
        button.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return button
    }()
    let taskTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.rowHeight = 50
        tableView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        return tableView
    }()
    let checkboxButton: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        let Image = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)
        button.setImage(Image, for: .normal)
        return button
        }()
    let checkboxFillButton: UIButton = {
        let button = UIButton()
        button.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        let Image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        button.setImage(Image, for: .normal)
        return button
        }()
    let legendInProcessLabel: UILabel = {
        let label = UILabel()
        label.text = " - In process"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font =  UIFont(name: "Avenir Next Regular", size: 17)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
        }()
    let legendCompletedLabel: UILabel = {
        let label = UILabel()
        label.text = " - Completed"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font =  UIFont(name: "Avenir Next Regular", size: 17)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
        }()
    let legendView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return view
    }()
    func setupConstraints() {
        taskTableView.snp.makeConstraints { maker in
            maker.top.equalTo(super.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(legendView.snp.top)
            maker.left.equalTo(super.safeAreaLayoutGuide.snp.left)
            maker.right.equalTo(super.safeAreaLayoutGuide.snp.right)
        }
        legendView.snp.makeConstraints { maker in
            maker.height.equalTo(taskTableView.rowHeight)
            maker.bottom.equalTo(super.safeAreaLayoutGuide.snp.bottom)
            maker.left.equalTo(super.safeAreaLayoutGuide.snp.left)
            maker.right.equalTo(super.safeAreaLayoutGuide.snp.right)
        }
        legendView.addSubview(checkboxButton)
        legendView.addSubview(checkboxFillButton)
        legendView.addSubview(legendInProcessLabel)
        legendView.addSubview(legendCompletedLabel)
        checkboxButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.centerY.equalToSuperview()
        }
        checkboxFillButton.snp.makeConstraints { maker in
            maker.right.equalTo(legendCompletedLabel.snp.left).inset(-5)
            maker.centerY.equalToSuperview()
        }
        legendInProcessLabel.snp.makeConstraints { maker in
            maker.left.equalTo(checkboxButton.snp.right).inset(-5)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        legendCompletedLabel.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(10)
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    override func layoutSubviews() {
            super.layoutSubviews()
        checkboxButton.layer.cornerRadius = checkboxButton.frame.height / 2
        checkboxButton.clipsToBounds = true
        checkboxFillButton.layer.cornerRadius = checkboxButton.frame.height / 2
        checkboxFillButton.clipsToBounds = true
        
        }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.addSubview(taskTableView)
        self.addSubview(legendView)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

