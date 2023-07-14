//
//  TaskTableViewCell.swift
//  To-Do List
//
//  Created by Lesha Mednikov on 12.07.2023.
//
import UIKit
import SnapKit
protocol TaskTableViewCellDelegate: AnyObject {
    func checkboxButtonTapped(at indexPath: IndexPath)
}
class TaskTableViewCell: UITableViewCell {
    weak var delegate: TaskTableViewCellDelegate?
    var indexPath: IndexPath?
    let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        let unselectedImage = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(systemName: "fill.circle")?.withRenderingMode(.alwaysTemplate)
        button.setImage(unselectedImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        return button
        }()
    let taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font =  UIFont(name: "Avenir Next Regular", size: 20)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    override func layoutSubviews() {
            super.layoutSubviews()
        checkboxButton.layer.cornerRadius = checkboxButton.frame.height / 2
        checkboxButton.clipsToBounds = true
        }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(taskLabel)
        contentView.addSubview(checkboxButton)
        checkboxButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(10)
            maker.centerY.equalToSuperview()
        }
        taskLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.left.equalTo(checkboxButton.snp.right).inset(-10)
        }
        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var checkboxAction: ((Bool) -> Void)?
    @objc func checkboxTapped() {
        checkboxButton.isSelected = !checkboxButton.isSelected
        checkboxAction?(checkboxButton.isSelected)
        if let indexPath = indexPath {
            delegate?.checkboxButtonTapped(at: indexPath)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }

}
