//
//  FishViewController.swift
//  ACNHFishies
//
//  Created by River McCaine on 1/27/21.
//

import UIKit

class FishViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var fishSearchBar: UISearchBar!
    @IBOutlet weak var fishNameLabel: UILabel!
    @IBOutlet weak var fishImageImageView: UIImageView!
    @IBOutlet weak var catchPhraseLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var rarityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var chatBubbleImageImageView: UIImageView!
    @IBOutlet weak var backgroundDirtImageView: UIImageView!
    @IBOutlet weak var goFishingButton: UIButton!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fishSearchBar.delegate = self
        hideKeyboardWhenTappedAround()
        
        backgroundDirtImageView.layer.masksToBounds = true
        backgroundDirtImageView.layer.cornerRadius = 16.8
        backgroundDirtImageView.layer.cornerCurve = .continuous
        goFishingButton.layer.cornerRadius = 15.8
        goFishingButton.layer.cornerCurve = .continuous
        
    }
    
    // MARK: - Actions
    @IBAction func fishingButtonTapped(_ sender: Any) {
        
        let randomFish = Int.random(in: 1...80)
        FishController.fetchFish(id: "\(randomFish)") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fish):
                    self.fetchImageAndUpdateViews(for: fish)
                case .failure(let error):
                    print(error)
                }
            }
        }
        chatBubbleImageImageView.image = UIImage(named: "chatbubble")
    }
    
    // MARK: - Helper Functions
    func fetchImageAndUpdateViews(for fish: Fish) {
        
        FishController.fetchFishSprite(for: fish) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fishImage):
                    self.fishImageImageView.image = fishImage
                    self.fishNameLabel.text = "\(fish.name.nameUSEn.capitalized)"
                    self.catchPhraseLabel.text = "\(fish.catchPhrase)"
                    self.locationLabel.text = " Location: \n \(fish.availability.location)"
                    self.rarityLabel.text = " Rarity: \n \(fish.availability.rarity)"
                    self.priceLabel.text = " Price: \(fish.price.withCommas()) bells"
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        chatBubbleImageImageView.image = UIImage(named: "chatbubble")
    }
} // END OF CLASS

extension FishViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        let formattedSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "_")
        FishController.fetchFish(id: formattedSearchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let fish):
                    self.fetchImageAndUpdateViews(for: fish)
                    self.fishSearchBar.endEditing(true)
                    self.fishSearchBar.text = ""
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
