//
//  ViewController.swift
//  todoListApp
//
//  Created by Gurpal Bhoot on 11/5/18.
//  Copyright © 2018 Gurpal Bhoot. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var todoListTableView: UITableView!
    
    // Variables
    var missions : [Mission]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        setupTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        missions = DataService.instance.returnMissions()
        todoListTableView.reloadData()
    }
    
    func setupTable() {
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
    }
    
    // IB-Actions
    @IBAction func addMissionBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: ID_SEGUE_TO_MISSION_VC, sender: self)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mish = missions else { return 0 }
        return mish.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ID_REUSE_MISSION_CELL, for: indexPath) as? MissionCell else { return UITableViewCell() }
        
        guard let mish = missions else { return UITableViewCell() }
        let mission = mish[indexPath.row]
        guard let t = mission.title, let dd = mission.dueDate, let n = mission.notes else {
            print("Something went wrong")
            return UITableViewCell()
        }
        cell.configureCell(title: t, dueDate: dd, notes: n, completed: mission.completed)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MissionCell else { return }

        DataService.instance.updateMission(index: indexPath.row)
        cell.missionCompleted()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataService.instance.removeMission(index: indexPath.row)
        missions = DataService.instance.returnMissions()
        todoListTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
