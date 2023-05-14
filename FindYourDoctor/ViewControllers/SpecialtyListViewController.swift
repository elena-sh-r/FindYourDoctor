//
//  SpecialtyListViewController.swift
//  FindYourDoctor
//
//  Created by Elena Sharipova on 12.05.2023.
//

import UIKit

enum Specialty: CaseIterable {
    case hospitalist
    case physicianAssistant
    case optometry
    case emergencyMedicine
    case clinicalPsychologist
    case endocrinology
    case nephrology
    case familyPractice
    case pediatricMedicine
    case psychiatry
    case physicalTherapy
    case dentist
    case internalMedicine
    case anesthesiology
    case chiropractic
    case dermatology
    case otolaryngology
    case neurology
    case ophthalmology
    case pulmonaryDiseas
    case diagnosticRadiology
    
    var title: String {
        switch self {
        case .hospitalist:
            return "Hospitalist"
        case .physicianAssistant:
            return "Physician Assistant"
        case .optometry:
            return "Optometry"
        case .emergencyMedicine:
            return "Emergency Medicine"
        case .clinicalPsychologist:
            return "Clinical Psychologist"
        case .endocrinology:
            return "Endocrinology"
        case .nephrology:
            return "Nephrology"
        case .familyPractice:
            return "Family Practice"
        case .pediatricMedicine:
            return "Pediatric Medicine"
        case .psychiatry:
            return "Psychiatry"
        case .physicalTherapy:
            return "Physical Therapy"
        case .dentist:
            return "Dentist"
        case .internalMedicine:
            return "Internal Medicine"
        case .anesthesiology:
            return "Anesthesiology"
        case .chiropractic:
            return "Chiropractic"
        case .dermatology:
            return "Dermatology"
        case .otolaryngology:
            return "Otolaryngology"
        case .neurology:
            return "Neurology"
        case .ophthalmology:
            return "Ophthalmology"
        case .pulmonaryDiseas:
            return "Pulmonary Diseas"
        case .diagnosticRadiology:
            return "Diagnostic Radiology"
        }
    }
    
    var apiValue: String {
        switch self {
        case .hospitalist:
            return "HOSPITALIST"
        case .physicianAssistant:
            return "PHYSICIAN ASSISTANT"
        case .optometry:
            return "OPTOMETRY"
        case .emergencyMedicine:
            return "EMERGENCY MEDICINE"
        case .clinicalPsychologist:
            return "CLINICAL PSYCHOLOGIST"
        case .endocrinology:
            return "ENDOCRINOLOGY"
        case .nephrology:
            return "NEPHROLOGY"
        case .familyPractice:
            return "FAMILY PRACTICE"
        case .pediatricMedicine:
            return "PEDIATRIC MEDICINE"
        case .psychiatry:
            return "PSYCHIATRY"
        case .physicalTherapy:
            return "PHYSICAL THERAPY"
        case .dentist:
            return "DENTIST"
        case .internalMedicine:
            return "INTERNAL MEDICINE"
        case .anesthesiology:
            return "ANESTHESIOLOGY"
        case .chiropractic:
            return "CHIROPRACTIC"
        case .dermatology:
            return "DERMATOLOGY"
        case .otolaryngology:
            return "OTOLARYNGOLOGY"
        case .neurology:
            return "NEUROLOGY"
        case .ophthalmology:
            return "OPHTHALMOLOGY"
        case .pulmonaryDiseas:
            return "PULMONARY DISEASE"
        case .diagnosticRadiology:
            return "DIAGNOSTIC RADIOLOGY"
        }
        
    }
}

final class SpecialtyListViewController: UITableViewController {
    
    // MARK: Public Properties
    var state: State!
    
    //MARK: - Private properties
    private let specialties = Specialty.allCases
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Choose specialty"
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let specialty = specialties[indexPath.row]
        
        guard let doctorListVC = segue.destination as? DoctorListViewController else { return }
        doctorListVC.state = state
        doctorListVC.specialty = specialty
        doctorListVC.fetchDoctors()
    }
}

// MARK: - UITableViewViewDataSource
extension SpecialtyListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        specialties.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specialty", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = specialties[indexPath.row].title
        cell.contentConfiguration = content
        
        return cell
    }
}
