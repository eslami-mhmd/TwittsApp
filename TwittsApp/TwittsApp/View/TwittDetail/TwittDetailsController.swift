//
//  TwittDetailsController.swift
//  DraftTwitts
//
//  Created by Mohammad Eslami on 3/11/22.
//

import Combine
import UIKit

class TwittDetailsController: UIViewController {
    // MARK: Properties
    private(set) var viewModel: TwittDetailsViewModel
    var anyCancel: Set<AnyCancellable> = []
    private let offset = 10
    private let stackViewHeight: CGFloat = 48

    private let scrollView = UIScrollView()
    private lazy var stackViewFooter: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .top
        stack.spacing = 10.0
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    private lazy var stackViewVertical: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .top
        stack.spacing = 10.0
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    private lazy var stackViewHeader: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.spacing = 5.0
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    private lazy var stackViewHeaderTitles: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.spacing = 5.0
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        return stack
    }()
    private lazy var stackViewTime: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
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
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .darkText.withAlphaComponent(0.7)
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .darkText.withAlphaComponent(0.7)
        return label
    }()
    private lazy var retweetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    private lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()

    // MARK: Life cycle methods
    init(viewModel: TwittDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private methods
private extension TwittDetailsController {
    func setupViews() {
        navigationItem.title = Constants.StringLabels.twittLabel
        view.backgroundColor = .systemGray6
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackViewVertical)
        scrollView.snp.makeConstraints { snp in
            snp.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(offset)
            snp.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-offset)
            snp.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(offset)
            snp.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-offset)
        }
        stackViewVertical.snp.makeConstraints { snp in
            snp.edges.equalToSuperview()
            snp.width.equalTo(scrollView.snp.width)
        }
        
        stackViewVertical.addArrangedSubview(stackViewHeader)
        stackViewVertical.addArrangedSubview(twittTextLabel)
        stackViewVertical.addArrangedSubview(stackViewTime)
        stackViewVertical.addArrangedSubview(stackViewFooter)

        stackViewHeader.addArrangedSubview(avatarView)
        stackViewHeader.addArrangedSubview(stackViewHeaderTitles)
        
        stackViewHeaderTitles.addArrangedSubview(displayNameLabel)
        stackViewHeaderTitles.addArrangedSubview(identifierLabel)

        stackViewTime.addArrangedSubview(timeLabel)
        stackViewTime.addArrangedSubview(dateLabel)

        stackViewFooter.addArrangedSubview(retweetLabel)
        stackViewFooter.addArrangedSubview(quoteLabel)
        stackViewFooter.addArrangedSubview(likeLabel)
        
        stackViewHeader.snp.makeConstraints { snp in
            snp.height.equalTo(stackViewHeight)
        }
        stackViewTime.snp.makeConstraints { snp in
            snp.height.equalTo(stackViewHeight)
        }
        stackViewFooter.snp.makeConstraints { snp in
            snp.height.equalTo(stackViewHeight)
        }
    }
    
    func bind() {
        viewModel.$twitt
            .receive(on: DispatchQueue.main)
            .sink { [weak self] twitt in
                self?.setData(twitt)
            }.store(in: &anyCancel)
    }
    
    func setData(_ twitt: TwittResponse) {
        twittTextLabel.text = twitt.data?.text
        displayNameLabel.text = twitt.includes?.users[safe: 0]?.name
        identifierLabel.text = twitt.includes?.users[safe: 0]?.username
        avatarView.setImage(urlString: twitt.includes?.users[safe: 0]?.profile_image_url)
        setDateTime(dateTimeString: twitt.data?.created_at ?? "")
        setFooterDate(twitt)
    }
    
    func setDateTime(dateTimeString: String) {
        if !dateTimeString.isEmpty {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
            if let dateTime = formatter.date(from: dateTimeString) {
                let dateFormatterDate = DateFormatter()
                dateFormatterDate.dateFormat = "yyyy-MM-dd"
                dateLabel.text = dateFormatterDate.string(from: dateTime)

                let dateFormatterTime = DateFormatter()
                dateFormatterTime.dateFormat = "HH:mm"
                timeLabel.text = dateFormatterTime.string(from: dateTime)
            }
        }
    }
    
    func setFooterDate(_ twitt: TwittResponse) {
        func hideLabels() {
            retweetLabel.isHidden = true
            likeLabel.isHidden = true
            quoteLabel.isHidden = true
        }
        guard let publicMetrics = twitt.data?.public_metrics else {
            hideLabels()
            return
        }
        retweetLabel.text = "\(publicMetrics.retweet_count) \(Constants.StringLabels.retweetsLabel)"
        retweetLabel.isHidden = publicMetrics.retweet_count > 0 ? false : true

        likeLabel.text = "\(publicMetrics.like_count) \(Constants.StringLabels.likesLabel)"
        likeLabel.isHidden = publicMetrics.like_count > 0 ? false : true

        quoteLabel.text = "\(publicMetrics.quote_count) \(Constants.StringLabels.quotesLabel)"
        quoteLabel.isHidden = publicMetrics.quote_count > 0 ? false : true
    }
    
}
