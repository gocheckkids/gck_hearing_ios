//
//  FirstCoordinator.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/13/24.
//

import UIKit
import SwiftUI

class FirstTabCoodinator: NSObject, Coordinator {
    
    var rootViewController: UINavigationController
    
    let loginVM = LoginViewModel()
    var multiLocationVM: MultiLocationViewModel?
    
    var patientListVM: PatientListViewModel?
    var detailVM: PatientDetailViewModel?
    var screeningVM: ScreeningViewModel?
    var resultVM: ResultDetailsViewModel?
    
    override init() {
        self.rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = false
        super.init()
        setupLoginNavigation()
        rootViewController.delegate = self
    }
    
    func start() {
        rootViewController.setViewControllers([firstLoginViewController], animated: false)
    }
    
    func setupLoginNavigation() {
        loginVM.loginAction = { [weak self] successful, multiLocationOn in
            if (successful && multiLocationOn) { self?.goToMultiLocationScreen() }
            else if (successful) {
                // skip multilocation screen
                self?.goToPatientList()
            }
            else {
                // handle error
            }
        }
    }
    
    func setupLocationListNavigation() {
        // Location List -> Patient List
        multiLocationVM?.locationTappedAction = { [weak self] in
            self?.goToPatientList()
        }
    }
    
    func setupPatientListNavigation() {
        // List -> Detail OR Screening
        patientListVM?.userTapAction = { [weak self] patient in
            self?.goToDetail(of: patient)
        }
        
        // Isolate into separate method?
        // List -> Add Patient
        patientListVM?.addPatientAction = { [weak self] in
            self?.goToAddPatient()
        }
        // Add Patient -> Back (List)
        patientListVM?.doneAddingPatientAction = { [weak self] in
//            self?.rootViewController.popViewController(animated: true)
            self?.rootViewController.dismiss(animated: true)
        }
        
        patientListVM?.screenTapAction = { [weak self] patient in
            self?.goToScreening(for: patient)
        }
        
        // Screening -> Result
        
    }
    
    func setupScreeningNavigation() {
        // Screening -> Result
        screeningVM?.screeningCompleteAction = { [weak self] patient, results in
            self?.goToResults(for: patient, with: results)
        }
        
        // Pause Menu
        screeningVM?.pauseTappedAction = { [weak self] in
//            let popAction = self?.rootViewController.popViewController(animated: true)
            
            let vc = UIHostingController(rootView: PauseMenu(exit: {
                self?.rootViewController.dismiss(animated: false)
                self?.rootViewController.popViewController(animated: true)
            }, resume: {
                self?.rootViewController.dismiss(animated: true)
            }))
            vc.modalPresentationStyle = .pageSheet
            vc.sheetPresentationController?.detents = [.medium()]
            vc.isModalInPresentation = true
            self?.rootViewController.present(vc, animated: true)
        }

    }
    
    func setupDetailNavigation() {
        // Go back
        detailVM?.backAction = { [weak self] in
            self?.rootViewController.popViewController(animated: true)
        }
        // Detail -> Visits OR Screening
        detailVM?.tapScreeningAction = { [weak self] patient in
            self?.goToScreening(for: patient)
        }
        detailVM?.tapResultAction = { [weak self] in
            print("Go to results")
        }
    }
    
    func setupResultsNavigation() {
        // Result -> Home
        resultVM?.doneAction = { [weak self] in
            self?.popToRoot()
        }
    }
    
    lazy var firstLoginViewController: UIViewController = {
        let vc = UIHostingController(rootView: LoginView(loginVM: loginVM).navigationBarHidden(true))
        
//        vc.rootView.viewModel.action1 = { [weak self] in
//            self?.goToAction1View()
//        }
//        vc.rootView.viewModel.action2 = { [weak self] num in
//            self?.goToAction2View(passing: num)
//        }
//        vc.rootView.viewModel.tapAction = { [weak self] num in
//            self?.goToDetail(of: String(num))
//        }
        
//        vc.title = "Patients"
//        vc.navigationItem.largeTitleDisplayMode = .never
        return vc
    }()
    
    func goToMultiLocationScreen() {
        let vm = MultiLocationViewModel(loader: LocalLocationListLoader())
        self.multiLocationVM = vm
        setupLocationListNavigation()
        let vc = UIHostingController(rootView: MultiLocationListView(locationVM: self.multiLocationVM ?? vm))
        rootViewController.pushViewController(vc, animated: true)
    }
    
    func goToPatientList() {
        let vm = PatientListViewModel(loader: LocalPatientListLoader())
        self.patientListVM = vm
        setupPatientListNavigation()
        let vc = UIHostingController(rootView: PatientListScreen(vm: self.patientListVM ?? vm))
        rootViewController.setViewControllers([vc], animated: true)
    }
    
    func goToDetail(of patient: Patient) {
        let vm = PatientDetailViewModel(patient: patient, loader: LocalPatientVisitsLoader())
        self.detailVM = vm
        setupDetailNavigation()
        let detailViewController = UIHostingController(rootView: PatientDetailView(detailVm: self.detailVM ?? vm))
        detailViewController.title = "Patient Profile"
        detailViewController.navigationItem.largeTitleDisplayMode = .never
        rootViewController.pushViewController(detailViewController, animated: true)
    }

    func goToScreening(for patient: Patient) {
        let vm = ScreeningViewModel(patient: patient)
        self.screeningVM = vm
        setupScreeningNavigation()
        let screeningViewController = UIHostingController(rootView: ScreeningView(screeningVm: self.screeningVM ?? vm))
        
        rootViewController.pushViewController(screeningViewController, animated: true)
    }
    
    func goToResults(for patient: Patient, with result: ResultDetails) {
        let vm = ResultDetailsViewModel(patient: patient, results: result)
        self.resultVM = vm
        setupResultsNavigation()
        let resultViewController = UIHostingController(rootView: ResultDetailsView(resultDetailVM: self.resultVM ?? vm))
        rootViewController.pushViewController(resultViewController, animated: true)
    }
    
    // MARK: Menu Actions
    func goToAddPatient() {
        let backupVM = PatientListViewModel(loader: LocalPatientListLoader())
        let addPatientView = AddPatientView(cancelAction: self.patientListVM!.doneAddingPatientAction ?? {}, submitAction: self.patientListVM!.addPatient)
        let addPatientVC = UIHostingController(rootView: addPatientView)
        addPatientVC.modalPresentationStyle = .fullScreen
        rootViewController.present(addPatientVC, animated: true)
//        rootViewController.pushViewController(addPatientVC, animated: true)
    }
    
    func popToRoot() {
        rootViewController.popToRootViewController(animated: false)
    }
    
}

extension FirstTabCoodinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
//        if viewController as? UIHostingController<FirstDetailView> != nil {
//            print("detail will be shown")
//        } else if viewController as? FirstViewController != nil {
//            print("first will be shown")
//        }
    }
}

