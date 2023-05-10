//
//  DoctorInfoViewController.swift
//  FindYourDoctor
//
//  Created by Elena Sharipova on 10.05.2023.
//

import UIKit

final class DoctorInfoViewController: UIViewController {
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var schoolLabel: UILabel!
    @IBOutlet var specLabel: UILabel!
    @IBOutlet var orgLabel: UILabel!
    @IBOutlet var orgAddressLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    var doctor: Doctor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = doctor.completeName

        cityLabel.text = "\(doctor.city), \(doctor.state)"
        schoolLabel.text = "\(doctor.medicalSchoolName), \(doctor.graduationYear)"
        specLabel.text = doctor.primarySpecialty
            + (!doctor.allSecondarySpecialties.isEmpty ? ", \(doctor.allSecondarySpecialties)" : "")
        orgLabel.text = doctor.organizationLegalName
        orgAddressLabel.text = doctor.line1StreetAddress
            + (!doctor.line2StreetAddress.isEmpty ? ", \(doctor.line2StreetAddress)" : "")
            + ", \(doctor.zipCode)"
        phoneLabel.text = doctor.phoneNumber
    }

}
