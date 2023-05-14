//
//  ViewController.swift
//  FindYourDoctor
//
//  Created by Elena Sharipova on 07.05.2023.
//

import UIKit

enum UserChoise: CaseIterable {
    case chooseState
    
    var title: String {
        switch self {
        case .chooseState:
            return "Find a doctor in your state"
        }
    }
}

final class MainViewController: UIViewController {
    
    //MARK: Private properties
    private let userChoises = UserChoise.allCases
    private let networkManager = NetworkManager.shared
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let statesVC = segue.destination as? StatesListViewController else  { return }
        statesVC.fetchStates()
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userChoises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userСhoice", for: indexPath)
        guard let cell = cell as? UserChoiseCell else { return UICollectionViewCell() }
        cell.userChoiseLabel.text = userChoises[indexPath.item].title
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userChoise = userChoises[indexPath.item]
        
        switch userChoise {
        case .chooseState: performSegue(withIdentifier: "chooseState", sender: nil)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 40, height: 65)
    }
}
