//
//  TwittsListCell.swift
//  TwittsApp
//
//  Created by Mohammad Eslami on 3/9/22.
//

import UIKit

class TwittsListCell: UITableViewCell, ReuseIdentifyingProtocol {
    // MARK: Properties
    private let avatarHeight: CGFloat = 48
    private let offset = 10

    private lazy var stackViewHorizontal: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .top
        stack.spacing = 5.0
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    private lazy var stackViewVertical: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.spacing = 5.0
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    private lazy var stackViewHeader: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .bottom
        stack.spacing = 10.0
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    private lazy var avatarView: AvatarView = {
        let avatarView = AvatarView()
        return avatarView
    }()
    private lazy var displayNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline,
                                    compatibleWith: UITraitCollection(legibilityWeight: UILegibilityWeight.bold))
        label.textColor = .darkText
        return label
    }()
    private lazy var identifierLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .darkText.withAlphaComponent(0.7)
        return label
    }()
    private lazy var twittTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkText.withAlphaComponent(0.85)
        return label
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .darkText.withAlphaComponent(0.7)
        return label
    }()

    // MARK: Life cycle methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: Private methods
private extension TwittsListCell {
    func setupViews() {
        backgroundColor = .lightText.withAlphaComponent(0.8)
        setupStackViewHorizontal()
        setupAvatarImage()
        setupStackViewHeader()
        setupStackViewVertical()
    }

    func setupStackViewHorizontal() {
        contentView.addSubview(stackViewHorizontal)
        stackViewHorizontal.snp.makeConstraints { snp in
            snp.top.leading.equalToSuperview().offset(offset)
            snp.bottom.trailing.equalToSuperview().offset(-offset)
        }
        stackViewHorizontal.addArrangedSubview(avatarView)
        stackViewHorizontal.addArrangedSubview(stackViewVertical)
    }

    func setupAvatarImage() {
        avatarView.snp.makeConstraints { snp in
            snp.width.height.equalTo(avatarHeight)
        }
    }

    func setupStackViewVertical() {
        stackViewVertical.addArrangedSubview(stackViewHeader)
        stackViewVertical.addArrangedSubview(twittTextLabel)
    }

    func setupStackViewHeader() {
        stackViewHeader.addArrangedSubview(displayNameLabel)
        stackViewHeader.addArrangedSubview(identifierLabel)
        stackViewHeader.addArrangedSubview(timeLabel)
    }

}

// MARK: Public methods
extension TwittsListCell {
    func resetCell() {
        displayNameLabel.text?.removeAll()
        identifierLabel.text?.removeAll()
        twittTextLabel.text?.removeAll()
        timeLabel.text?.removeAll()
        avatarView.cancelImageLoad()
    }

    func setCellData(twitt: TwittResponse) {
        twittTextLabel.text = twitt.data?.text
        displayNameLabel.text = twitt.includes?.users[safe: 0]?.name
        identifierLabel.text = twitt.includes?.users[safe: 0]?.username
        avatarView.setImage(urlString: twitt.includes?.users[safe: 0]?.profile_image_url)
        setTime(twitt.data?.created_at ?? "")
    }

    func setTime(_ timeString: String) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        if let dateTime = formatter.date(from: timeString) {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .abbreviated
            let relativeDate = formatter.localizedString(for: dateTime, relativeTo: Date())
            timeLabel.text = relativeDate
        }

    }
}
