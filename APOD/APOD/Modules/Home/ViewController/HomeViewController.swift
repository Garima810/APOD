//
//  HomeViewController.swift
//  APOD
//
//  Created by Garima Ashish Bisht on 05/02/22.
//

import UIKit

class HomeViewController: UIViewController {

    private var viewModel = HomeViewModel()
    private var tableView: UITableView = UITableView()
    private var pickerContainerView = UIView()
    private var datePicker = UIDatePicker()
    private var apodResponse: APODResponseModel?
    private var dataManager: APODDataManaging = APODDataManager()
    let favouriteButton = UIButton(type: .custom)

    lazy var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.contentMode = .scaleToFill
      view.color = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      view.hidesWhenStopped = true
      return view
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        fetchImageDetailsforSelectedDate()
        refreshScreenTitle()
        configureNavigationBar()
        configureTableView()
        setupViews()
        setupDatePicker()
        // Do any additional setup after loading the view.
    }
    
    private func refreshScreenTitle() {
        title = viewModel.screenTitle
    }
    
    private func setupViews() {
        self.view.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
          ])
    }
    
    private func configureNavigationBar() {
        // Create the navigation bar
        navigationItem.title = viewModel.screenTitle
        
        // Create left and right button for navigation item
        let calendarButton = UIButton(type: .custom)
        calendarButton.setImage(UIImage(named: "calendar"), for: .normal)
        calendarButton.addTarget(self, action: #selector(selectDates), for: .touchUpInside)
        let leftBarButton =  UIBarButtonItem(customView: calendarButton)
        
        favouriteButton.setImage(UIImage(named: "ic_unlike"), for: .normal)
        favouriteButton.setImage(UIImage(named: "ic_like"), for: .selected)
        favouriteButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: favouriteButton)

        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton

    }
    
    @objc private func selectDates() {
        pickerContainerView.isHidden = false
        datePicker.isHidden = false
        
    }
    
    private func setupDatePicker() {
        let size = self.view.frame.size
        pickerContainerView.frame = CGRect(x: 0.0, y: size.height - 263, width: size.width, height: 263)
        pickerContainerView.backgroundColor = UIColor.white
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.blue, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        doneButton.frame = CGRect(x: 350.0, y: 0.0, width: 70.0, height: 30.0)
        pickerContainerView.addSubview(doneButton)
        
        datePicker.frame = CGRect(x: 50.0, y: 30.0, width: self.view.frame.width, height: 216.0)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        pickerContainerView.addSubview(datePicker)
        datePicker.isHidden = true
        self.view.addSubview(pickerContainerView)
        pickerContainerView.isHidden = true
        
    }
    
    @objc private func doneButtonClick() {
        datePicker.isHidden = true
        pickerContainerView.isHidden = true
        fetchImageDetailsforSelectedDate()
        
    }
    
    private func fetchImageDetailsforSelectedDate() {
        guard Reachability.isConnectedToNetwork() else {
            viewModel.getInitialData()
            refreshScreenTitle()
            tableView.reloadData()
            return
        }
        
        self.indicatorView.startAnimating()
        viewModel.fetchImageDetailsforSelectedDate { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success( _):
                DispatchQueue.main.async {
                self.indicatorView.hidesWhenStopped = true
                self.indicatorView.stopAnimating()
                self.refreshScreenTitle()
                self.tableView.reloadData()
                self.favouriteButton.isSelected = self.viewModel.isAlreadyAddedToFavourites()
                }
            default:
                DispatchQueue.main.async {
                 self.indicatorView.hidesWhenStopped = true
                 self.indicatorView.stopAnimating()
                 self.showAlert()
                }
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "It looks like something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    @objc private func datePickerValueChanged(sender:UIDatePicker) {
        viewModel.selectedDate =  datePicker.date
     
    }
    
    @objc private func addToFavorites() {
        viewModel.configureCoreDataEntity(shouldDeleteFromFavourites: favouriteButton.isSelected)
        CoreDataHelper.sharedInstance().saveContext()
        favouriteButton.isSelected = !favouriteButton.isSelected
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0),
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 175.0
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "PhotoGridCell", bundle: nil), forCellReuseIdentifier: "PhotoGridCellIdentifier")
        tableView.register(UINib(nibName: "SingleLabelCell", bundle: nil), forCellReuseIdentifier: "CellIdentifier")
    
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellTypeAt(indexPath: indexPath)
        switch cellType {
        case .header:
            return headerImageCell(tableView, indexPath: indexPath)
        case .title:
            return titleCell(tableView, indexPath: indexPath)
        case .detail:
            return descriptionCell(tableView, indexPath: indexPath)
        }
    }
    
    private func headerImageCell(_ tableView: UITableView, indexPath:IndexPath) -> UITableViewCell {
        let cell: PhotoGridCell = tableView.dequeueReusableCell(withIdentifier: "PhotoGridCellIdentifier", for: indexPath)  as! PhotoGridCell
        cell.configureCellWithImage(image: viewModel.headerImage)
        return cell
        
    }
    
    private func titleCell(_ tableView: UITableView, indexPath:IndexPath) -> UITableViewCell {
        let cell: SingleLabelCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)  as! SingleLabelCell
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.titleLabel.textColor = UIColor.black
        cell.configureCellWith(data: viewModel.title)
        return cell
    }
    
    private func descriptionCell(_ tableView: UITableView, indexPath:IndexPath) -> UITableViewCell {
        let cell: SingleLabelCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)  as! SingleLabelCell
        cell.titleLabel.textColor = UIColor.darkGray
        cell.titleLabel.font = UIFont.systemFont(ofSize: 14.0)
        cell.configureCellWith(data: viewModel.detail)
        return cell
    }

}

extension HomeViewController: UITableViewDelegate {
    
}
