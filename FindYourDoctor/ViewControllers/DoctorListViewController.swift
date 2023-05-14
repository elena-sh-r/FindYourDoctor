//
//  DoctorListViewController.swift
//  FindYourDoctor
//
//  Created by Elena Sharipova on 10.05.2023.
//

import UIKit

final class DoctorListViewController: UITableViewController {
    
    // MARK: IB Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public Properties
    var state: State!
    var specialty: Specialty!
    
    // MARK: - Private Properties
    private var doctors: [Doctor] = []
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = specialty.title
        tableView.rowHeight = 80
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let doctor = doctors[indexPath.row]
        
        guard let doctorInfoVC = segue.destination as? DoctorInfoViewController else { return }
        doctorInfoVC.doctor = doctor
    }
}

// MARK: - UITableViewDataSource
extension DoctorListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        doctors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doctorCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let doctor = doctors[indexPath.row]
        content.text = doctor.completeName
        content.secondaryText = doctor.city
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - Networking
extension DoctorListViewController {
    func fetchDoctors() {
        let parameters: [String: Any] = [
            "limit" : 20,
            "conditions": [
                [
                    "property" : "pri_spec",
                    "value": specialty.apiValue,
                    "compareOperator" : "="
                ],
                [
                    "property" : "st",
                    "value": state.code,
                    "compareOperator" : "="
                ]
            ]
        ]
        
        networkManager.fetchDoctors(from: Link.doctorsAndCliniciansURL.url, with: parameters) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let doctorsFromApi):
                self.doctors = doctorsFromApi
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
