//
//  HomeViewController.swift
//  GS_challenge
//
//  Created by kaushik on 21/03/22.
//

import Foundation
import ReactiveKit
import MBProgressHUD
import DatePicker

/// `UIViewController` show  the option to search  NASA for selected data.
class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// UIButton to search image for selected Data
    @IBOutlet weak var searchButton: UIButton!
    
    /// UITableView for pictureDetailTableView
    @IBOutlet weak var pictureDetailTableView: UITableView!
    
    //MARK: - Instance variables
    
    /// Refers to view model for HomeViewController
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindSearchButton()
        bindTableView()
        fetchPictureOfTheDay()
        pictureDetailTableView.rowHeight = UITableView.automaticDimension
        pictureDetailTableView.estimatedRowHeight = 300
    }
    
    // MARK: - IBAction methods
    
    /// Called when users tap the Search button
    /// - Parameter sender: represents UIButton
    @IBAction func onSearchButtonAction(_ sender: UIButton) {
        let minDate = DatePickerHelper.shared.dateFrom(day: 16, month: 06, year: 1995)!
        let maxDate = DatePickerHelper.shared.dateFrom(day: 22, month: 03, year: 2022)!
        let today = Date()
        // Create picker object
        let datePicker = DatePicker()
        // Setup
        datePicker.setup(beginWith: today, min: minDate, max: maxDate) { [weak self] (selected, date) in
            if selected, let selectedDate = date {
                DispatchQueue.main.async{ [weak self] in
                    self?.viewModel.currentDate.value = selectedDate.string()
                    self?.searchButton.setTitle(selectedDate.string(), for: .normal)
                    self?.fetchPictureForSelectedDay()                }
                
            } else {
                print("Cancelled")
            }
        }
        datePicker.show(in: self, on: sender)
    }
    
    
    /// Called when users tap the date button
    func fetchPictureForSelectedDay(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.viewModel.getPictureOfTheDayForSelectedDate { (response) in
            if (response.count > 0) {
                DispatchQueue.main.async{ [weak self] in
                    self?.pictureDetailTableView.reloadData()
                }
            }else{
                GSAlert.show(title: HomeConstant.AlertDetail.title, message: HomeConstant.AlertDetail.message, buttons: [HomeConstant.AlertDetail.buttonTitle], completion: nil)
            }
            self.hideIndicator()
        }
    }
    
    /// Called when view appear
    /// - Parameter sender: represents UIButton
    func fetchPictureOfTheDay() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.viewModel.getPictureOfTheDayForCurrentDate { (response) in
            if (response.count > 0) {
                DispatchQueue.main.async{ [weak self] in
                    self?.pictureDetailTableView.reloadData()
                }
            }else{
                GSAlert.show(title: HomeConstant.AlertDetail.title, message: HomeConstant.AlertDetail.message, buttons: [HomeConstant.AlertDetail.buttonTitle], completion: nil)
            }
            self.hideIndicator()
        }
    }
    
    /// Method to bind the search Picture result to `UITableView`
    func bindTableView() {
        viewModel.resultArray.bind(to: pictureDetailTableView) { dataSource, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeConstant.PictureDetailIdentifier.cellIdentifier
                                                     , for: indexPath) as! PictureDetailViewCell
            let pictureDetail = dataSource[indexPath.row]
            cell.dateLabel.text = pictureDetail.date
            cell.imageExplanation.text = pictureDetail.explanation
            cell.imageTitle.text = pictureDetail.title
            if let imageURLString = pictureDetail.url, let imageURL = URL(string: imageURLString) {
                cell.picOfTheDay.setImageWith(imageURL)
            }
            return cell
        }
    }
    
}

// MARK: - extension to bind acronym search Observable string to Textfield
extension HomeViewController {
    /// Method for bind userName data and validate username field text.
    private func bindSearchButton() {
        viewModel.currentDate.bind(to:self.searchButton.reactive.title)
    }
}


// MARK: - extension to hide Indicator
extension HomeViewController {
    func hideIndicator() {
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}
