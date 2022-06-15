//
//  DailyTableViewCell.swift
//  Weather
//
//  Created by MacOne-YJ4KBJ on 13/06/2022.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    var data : ListD?
    @IBOutlet weak var imgStatD: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTemP: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTemP.font = UIFont.systemFont(ofSize: 16)
        lblTemP.textColor = .white
        lblDate.textColor = .white
        lblDate.font = .boldSystemFont(ofSize: 17)
        print(data)
        guard let data = data else{
            return
        }
        lblDate.text = data.dt.formatDay()
        let min = data.temp.min.formatTempC()
        let max = data.temp.max.formatTempC()
        lblTemP.text = "\(min)°/\(max)°"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
