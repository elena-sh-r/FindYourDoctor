//
//  ViewController.swift
//  FindYourDoctor
//
//  Created by Elena Sharipova on 07.05.2023.
//

import UIKit

enum Link {
    case doctorsAndCliniciansURL
    
    var url: URL {
        switch self {
        case .doctorsAndCliniciansURL:
            return URL(string: "https://data.cms.gov/provider-data/api/1/datastore/query/mj5m-pzi6/0")!
        }
    }
}

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDoctors()
    }

}

// MARK: - Networking
extension MainViewController {
    private func fetchDoctors() {
        URLSession.shared.dataTask(with: Link.doctorsAndCliniciansURL.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let doctors = try decoder.decode(DoctorsApiResponse.self, from: data).results
                print(doctors)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
