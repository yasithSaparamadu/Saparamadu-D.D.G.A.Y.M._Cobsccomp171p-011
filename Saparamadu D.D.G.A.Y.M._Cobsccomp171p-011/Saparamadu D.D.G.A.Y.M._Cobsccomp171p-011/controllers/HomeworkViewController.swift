//
//  HomeworkViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/26/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit


class HomeworkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
   
    var data:[String] = []
    var selectedRow:Int = -1
    var newRow: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.title = "Home Work"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        load()
        // Do any additional setup after loading the view.
    }
    
    @objc func addNote(){
        
        if tableView.isEditing{
            return
        }
        let noteName:String = ""
        data.insert(noteName, at: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "homeWork", sender: nil)
    }
    
    func save(){
        
        UserDefaults.standard.set(data, forKey: "wk")
        
    }
    
    func load(){
        
        if let loadedData = UserDefaults.standard.value(forKey: "wk") as? [String] {
            
            data = loadedData
            tableView.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notedetails")!
        cell.textLabel?.text = data[indexPath.row]
        print("DATA :\(data[indexPath.row])")
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "homeWork", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addnoteView: AddNoteViewController = segue.destination as! AddNoteViewController
        selectedRow = tableView.indexPathForSelectedRow!.row
        addnoteView.homeWorkView = self
        addnoteView.setText(t: data[selectedRow])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if selectedRow == -1{
            return
        }
        
        if newRow.isEmpty{
            return
        }
        
        data[selectedRow] = newRow
        
        if newRow == ""{
            data.remove(at: selectedRow)
        }
        
        tableView.reloadData()
        save()
        
        
    }
    
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
