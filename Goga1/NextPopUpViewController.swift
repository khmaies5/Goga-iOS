//
//  NextPopUpViewController.swift
//  Goga1
//
//  Created by Khmaies Hassen on 12/12/17.
//  Copyright © 2017 malek cheikh. All rights reserved.
//

import UIKit

class NextPopUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
   
    var pickedItem:String?
    
var pickerData: [String] = [String]()
     @IBOutlet weak var CategoryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Connect data:
      //  self.CategoryPicker.delegate = self
       // self.CategoryPicker.dataSource = self
        
        // Input data into the Array:
        pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        pickedItem = pickerData[row]
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
