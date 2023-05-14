//
//  StatesListViewController.swift
//  FindYourDoctor
//
//  Created by Elena Sharipova on 12.05.2023.
//

import UIKit

class StatesListViewController: UITableViewController {
    
    // MARK: IB Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Private properties
    private var states: [State] = []
    private let networkManager = NetworkManager.shared

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        
        title = "Choose your state"
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let state = states[indexPath.row]
        
        guard let specialtyListVC = segue.destination as? SpecialtyListViewController else { return }
        specialtyListVC.state = state
    }

}

// MARK: - UITableViewDataSource
extension StatesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        states.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "state", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let state = states[indexPath.row]
        content.text = state.title
        networkManager.fetchData(from: state.flagUrl) { result in
            switch result {
            case .success(let imageData):
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            case .failure(let error):
                content.image = UIImage(named: "usFlag")
                cell.contentConfiguration = content
                print(error.localizedDescription)
            }
        }
        
        return cell
    }
}

// MARK: - Networking
extension StatesListViewController {
    func fetchStates(with country: String = "United States") {
        networkManager.fetchStates(from: Link.statesURL.url, with: StatesApiRequest(country: country)) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                self.states = data
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
