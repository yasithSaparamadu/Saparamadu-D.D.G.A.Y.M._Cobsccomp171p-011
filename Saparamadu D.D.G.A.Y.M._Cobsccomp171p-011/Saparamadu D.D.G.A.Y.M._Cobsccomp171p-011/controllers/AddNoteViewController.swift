//
//  AddNoteViewController.swift
//  Saparamadu D.D.G.A.Y.M._Cobsccomp171p-011
//
//  Created by Yasith Maheshka Saparamadu on 5/26/2562 BE.
//  Copyright © 2562 BE Yasith Maheshka Saparamadu. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var noteView: UITextView!
    
    var text: String = ""
    var homeWorkView: HomeworkViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noteView.text = text
        // Do any additional setup after loading the view.
    }
    
    func setText(t: String){
        text = t
        if isViewLoaded{
            noteView.text = t
            
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        homeWorkView.newRow = noteView.text!
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
