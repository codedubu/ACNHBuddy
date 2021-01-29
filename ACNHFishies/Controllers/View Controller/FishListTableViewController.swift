//
//  FishListTableViewController.swift
//  ACNHFishies
//
//  Created by River McCaine on 1/28/21.
//

import UIKit

class FishListTableViewController: UITableViewController {
    
    // MARK: - Properties

    var fishes: [Fish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFish()
    }
    
    // MARK: - Helper Methods
    func fetchFish() {
        FishController.fetchAllFish { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fishes):
                    self.fishes = fishes
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fishes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fishCell", for: indexPath)
        let fish = fishes[indexPath.row]
        
        cell.textLabel?.text = fish.name.nameUSEn
        cell.detailTextLabel?.text = fish.availability.rarity
        
        FishController.fetchFishSprite(for: fishes[indexPath.row]) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fishImage):
                    cell.imageView?.image = fishImage
                    tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    return cell
}

} // END OF CLASS
