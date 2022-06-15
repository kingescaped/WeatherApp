//
//  ViewController.swift
//  Weather
//
//  Created by Lionel Vinh Quang on 13/06/2022.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
//outlets
    var scrollView = UIScrollView()
    var contentView = UIView()
    var uiView_Top = UIView()
    var uiView_Top_Bar = UIView()
    var bt_add = UIButton()
    var bt_menu = UIButton()
    var lbl_location = UILabel()
    var stackView = UIStackView()
    var img_statS = UIImageView()
    var lbl_statS = UILabel()
    var lbl_dateS = UILabel()
    var lbl_tempS = UILabel()
    var view_lbl = UIView()
    var view_stats = UIView()
    var scrollBool = true
    var lineV = UIView()
    
    var lbl_pressure = UILabel()
    var lbl_pressure1 = UILabel()
    var lbl_humidity = UILabel()
    var lbl_humidity1 = UILabel()
    var lbl_wind = UILabel()
    var lbl_wind1 = UILabel()
    var img_pressure = UIImageView()
    var img_humidity = UIImageView()
    var img_wind = UIImageView()
    
    var width_stat1 = NSLayoutConstraint()
    var height_stat1 = NSLayoutConstraint()
    var width_stat2 = NSLayoutConstraint()
    var height_stat2 = NSLayoutConstraint()
    
    
    let my_latitude = 21.0351049
    let my_longitude = 105.8988653
    let your_language = "vi" //tieng viet
    // 2 số này la vĩ độ và kinh độ địa điểm, sau này có apy lấy vị trí tự động từ google thì thay đổi sau
    var cnt = 7 // day la so ngay ma ban muon hienj thi tu 1 - 16
    var urlApiCurrent : String = ""
    var urlApiDaily : String = ""
    var dataCurrent : CurrentWeather?
    var dataDaily = [ListD]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        configUiTop()
        urlApiCurrent = "https://api.openweathermap.org/data/2.5/weather?lat=\(my_latitude)&lon=\(my_longitude)&lang=\(your_language)&appid=\(AppDelegate.myKeyApi)"
        urlApiDaily = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(my_latitude)&lon=\(my_longitude)&lang=\(your_language)&cnt=\(cnt)&appid=\(AppDelegate.myKeyApi)"
        loadJson()
    }
    
    func configUiTop(){
        view.addSubview(uiView_Top)
        uiView_Top.translatesAutoresizingMaskIntoConstraints = false
        uiView_Top.layer.cornerRadius = 10
        uiView_Top.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0).isActive = true
        uiView_Top.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        uiView_Top.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        uiView_Top.addSubview(uiView_Top_Bar)
        uiView_Top_Bar.translatesAutoresizingMaskIntoConstraints = false
        uiView_Top_Bar.topAnchor.constraint(equalTo: uiView_Top.topAnchor, constant: 10).isActive = true
        uiView_Top_Bar.leadingAnchor.constraint(equalTo: uiView_Top.leadingAnchor, constant: 0).isActive = true
        uiView_Top_Bar.trailingAnchor.constraint(equalTo: uiView_Top.trailingAnchor, constant: 0).isActive = true
        
        uiView_Top_Bar.addSubview(bt_add)
        uiView_Top_Bar.addSubview(lbl_location)
        uiView_Top_Bar.addSubview(bt_menu)
        bt_add.translatesAutoresizingMaskIntoConstraints = false
        lbl_location.translatesAutoresizingMaskIntoConstraints = false
        bt_menu.translatesAutoresizingMaskIntoConstraints = false
        
        bt_add.leadingAnchor.constraint(equalTo: uiView_Top_Bar.leadingAnchor,constant: 0).isActive = true
        bt_add.topAnchor.constraint(equalTo: uiView_Top_Bar.topAnchor,constant: 0).isActive = true
        bt_add.widthAnchor.constraint(equalToConstant: 30).isActive = true
        bt_add.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bt_add.setBackgroundImage(UIImage(named: "add"), for: .normal)
        
        lbl_location.topAnchor.constraint(equalTo: uiView_Top_Bar.topAnchor,constant: 0).isActive = true
        lbl_location.centerXAnchor.constraint(equalTo: uiView_Top_Bar.centerXAnchor, constant: 0).isActive = true
        lbl_location.bottomAnchor.constraint(equalTo: uiView_Top_Bar.bottomAnchor, constant: 0).isActive = true
        lbl_location.text = "Ha Noi"
        lbl_location.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lbl_location.textColor = .white
        lbl_location.font = .boldSystemFont(ofSize: 30)
        
        bt_menu.trailingAnchor.constraint(equalTo: uiView_Top_Bar.trailingAnchor,constant: 0).isActive = true
        bt_menu.topAnchor.constraint(equalTo: uiView_Top_Bar.topAnchor,constant: 0).isActive = true
        bt_menu.widthAnchor.constraint(equalToConstant: 30).isActive = true
        bt_menu.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bt_menu.setBackgroundImage(UIImage(named: "menu"), for: .normal)
        bt_menu.addTarget(self, action: #selector(animateView), for: .touchUpInside)
        
        uiView_Top.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
      
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: uiView_Top_Bar.bottomAnchor,constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: uiView_Top.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: uiView_Top.trailingAnchor, constant: 0).isActive = true
        stackView.addArrangedSubview(img_statS)
        
        img_statS.translatesAutoresizingMaskIntoConstraints = false
        img_statS.contentMode = .scaleAspectFit
        img_statS.image = UIImage(named: "01d")
        height_stat1 = img_statS.heightAnchor.constraint(equalToConstant:  self.view.bounds.width - 140)
        height_stat1.isActive = true

        stackView.addArrangedSubview(view_lbl)
        view_lbl.translatesAutoresizingMaskIntoConstraints = false
        view_lbl.heightAnchor.constraint(equalToConstant: 140).isActive = true

        view_lbl.addSubview(lbl_dateS)
        lbl_dateS.translatesAutoresizingMaskIntoConstraints = false
        lbl_dateS.topAnchor.constraint(equalTo: view_lbl.topAnchor, constant: 0).isActive = true
        lbl_dateS.centerXAnchor.constraint(equalTo: view_lbl.centerXAnchor, constant: 0).isActive = true
        lbl_dateS.text = "none"
        lbl_dateS.textAlignment = .center
        lbl_dateS.textColor = .white
        lbl_dateS.font = .boldSystemFont(ofSize: 17)
        
        view_lbl.addSubview(lbl_tempS)
        lbl_tempS.translatesAutoresizingMaskIntoConstraints = false
        lbl_tempS.topAnchor.constraint(equalTo: lbl_dateS.bottomAnchor, constant: 0).isActive = true
        lbl_tempS.centerXAnchor.constraint(equalTo: view_lbl.centerXAnchor, constant: 0).isActive = true
        lbl_tempS.text = "none"
        lbl_tempS.textColor = .white
        lbl_tempS.font = .boldSystemFont(ofSize: 80)
        
        view_lbl.addSubview(lbl_statS)
        lbl_statS.translatesAutoresizingMaskIntoConstraints = false
        lbl_statS.topAnchor.constraint(equalTo: lbl_tempS.bottomAnchor, constant: 0).isActive = true
        lbl_statS.centerXAnchor.constraint(equalTo: view_lbl.centerXAnchor, constant: 0).isActive = true
        lbl_statS.bottomAnchor.constraint(equalTo: view_lbl.bottomAnchor, constant: 0).isActive = true
        lbl_statS.text = "none"
        lbl_statS.textColor = .white
        lbl_statS.font = .boldSystemFont(ofSize: 17)
        
        uiView_Top.addSubview(lineV)
        lineV.translatesAutoresizingMaskIntoConstraints = false
        lineV.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineV.backgroundColor = .white
        lineV.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        lineV.leadingAnchor.constraint(equalTo: uiView_Top.leadingAnchor, constant: 0).isActive = true
        lineV.trailingAnchor.constraint(equalTo: uiView_Top.trailingAnchor, constant: 0).isActive = true
        
        uiView_Top.addSubview(view_stats)
        view_stats.translatesAutoresizingMaskIntoConstraints = false
        view_stats.topAnchor.constraint(equalTo: lineV.bottomAnchor, constant: 10).isActive = true
        view_stats.bottomAnchor.constraint(equalTo: uiView_Top.bottomAnchor, constant: -10).isActive = true
        view_stats.centerXAnchor.constraint(equalTo: uiView_Top.centerXAnchor, constant: 0).isActive = true
        
        view_stats.addSubview(img_wind)
        img_wind.translatesAutoresizingMaskIntoConstraints = false
        img_wind.widthAnchor.constraint(equalToConstant: 36).isActive = true
        img_wind.heightAnchor.constraint(equalToConstant: 36).isActive = true
        img_wind.topAnchor.constraint(equalTo: view_stats.topAnchor, constant: 0).isActive = true
        img_wind.leadingAnchor.constraint(equalTo: view_stats.leadingAnchor, constant: 20).isActive = true
        img_wind.bottomAnchor.constraint(equalTo: view_stats.bottomAnchor, constant: 0).isActive = true
        img_wind.image = UIImage(named: "wind")
        
        view_stats.addSubview(lbl_wind)
        lbl_wind.translatesAutoresizingMaskIntoConstraints = false
        lbl_wind.topAnchor.constraint(equalTo: view_stats.topAnchor, constant: 0).isActive = true
        lbl_wind.leadingAnchor.constraint(equalTo: img_wind.trailingAnchor, constant: 5).isActive = true
        lbl_wind.text = "none"
        lbl_wind.textColor = .white
        lbl_wind.font = UIFont.systemFont(ofSize: 14)
        
        view_stats.addSubview(lbl_wind1)
        lbl_wind1.translatesAutoresizingMaskIntoConstraints = false
        lbl_wind1.topAnchor.constraint(equalTo: lbl_wind.bottomAnchor, constant: 0).isActive = true
        lbl_wind1.leadingAnchor.constraint(equalTo: img_wind.trailingAnchor, constant: 5).isActive = true
        lbl_wind1.text = "Gió"
        lbl_wind1.textColor = .white
        lbl_wind1.font = UIFont.systemFont(ofSize: 14)
        
        view_stats.addSubview(img_pressure)
        img_pressure.translatesAutoresizingMaskIntoConstraints = false
        img_pressure.widthAnchor.constraint(equalToConstant: 36).isActive = true
        img_pressure.heightAnchor.constraint(equalToConstant: 36).isActive = true
        img_pressure.topAnchor.constraint(equalTo: view_stats.topAnchor, constant: 0).isActive = true
        img_pressure.leadingAnchor.constraint(equalTo: img_wind.trailingAnchor, constant: 70).isActive = true
        img_pressure.image = UIImage(named: "pressure")
        
        view_stats.addSubview(lbl_pressure)
        lbl_pressure.translatesAutoresizingMaskIntoConstraints = false
        lbl_pressure.topAnchor.constraint(equalTo: view_stats.topAnchor, constant: 0).isActive = true
        lbl_pressure.leadingAnchor.constraint(equalTo: img_pressure.trailingAnchor, constant: 5).isActive = true
        lbl_pressure.text = "none"
        lbl_pressure.textColor = .white
        lbl_pressure.font = UIFont.systemFont(ofSize: 14)
        
        view_stats.addSubview(lbl_pressure1)
        lbl_pressure1.translatesAutoresizingMaskIntoConstraints = false
        lbl_pressure1.topAnchor.constraint(equalTo: lbl_pressure.bottomAnchor, constant: 0).isActive = true
        lbl_pressure1.leadingAnchor.constraint(equalTo: img_pressure.trailingAnchor, constant: 5).isActive = true
        lbl_pressure1.text = "Áp suất"
        lbl_pressure1.textColor = .white
        lbl_pressure1.font = UIFont.systemFont(ofSize: 14)
        
        view_stats.addSubview(img_humidity)
        img_humidity.translatesAutoresizingMaskIntoConstraints = false
        img_humidity.widthAnchor.constraint(equalToConstant: 36).isActive = true
        img_humidity.heightAnchor.constraint(equalToConstant: 36).isActive = true
        img_humidity.topAnchor.constraint(equalTo: view_stats.topAnchor, constant: 0).isActive = true
        img_humidity.leadingAnchor.constraint(equalTo: img_pressure.trailingAnchor, constant: 70).isActive = true
        img_humidity.trailingAnchor.constraint(equalTo: view_stats.trailingAnchor, constant: -70).isActive = true
        img_humidity.image = UIImage(named: "humidity")
        
        view_stats.addSubview(lbl_humidity)
        lbl_humidity.translatesAutoresizingMaskIntoConstraints = false
        lbl_humidity.topAnchor.constraint(equalTo: view_stats.topAnchor, constant: 0).isActive = true
        lbl_humidity.leadingAnchor.constraint(equalTo: img_humidity.trailingAnchor, constant: 5).isActive = true
        lbl_humidity.text = "none"
        lbl_humidity.textColor = .white
        lbl_humidity.font = UIFont.systemFont(ofSize: 14)
        
        view_stats.addSubview(lbl_humidity1)
        lbl_humidity1.translatesAutoresizingMaskIntoConstraints = false
        lbl_humidity1.topAnchor.constraint(equalTo: lbl_humidity.bottomAnchor, constant: 0).isActive = true
        lbl_humidity1.leadingAnchor.constraint(equalTo: img_humidity.trailingAnchor, constant: 5).isActive = true
        lbl_humidity1.text = "Độ ẩm"
        lbl_humidity1.textColor = .white
        lbl_humidity1.font = UIFont.systemFont(ofSize: 14)
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: uiView_Top.bottomAnchor,constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.delegate = self
        scrollView.addSubview(contentView)
        scrollView.bounces = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 900).isActive = true
    }
    @objc func animateView(){
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 && scrollBool {
            scrollBool = !scrollBool
            UIView.animate(withDuration: 1) {
                self.stackView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.stackView.axis = .horizontal
                self.stackView.distribution = .fillEqually
                
            }
        }
        else{
            if scrollView.contentOffset.y == 0{
                scrollBool = !scrollBool
                UIView.animate(withDuration: 1, delay: 0) {
                    self.stackView.transform = .identity
                    self.stackView.axis = .vertical
                    self.stackView.distribution = .fillProportionally
                    self.height_stat1.isActive = true
                }
            }
        }
    }

    func loadJson(){
//        URLSession.shared.dataTask(with: URL(string: urlApiDaily)!) { data, response, errors in
//            do{
//                let dataD = try JSONDecoder().decode(DailyWeather.self, from: data!)
//
//                DispatchQueue.main.async {
//                    for i in 0..<dataD.list.count{
//                        self.dataDaily.append(dataD.list[i])
//                    }
//                    print(self.dataDaily)
//                }
//            }catch{
//                print(errors)
//            }
//        }.resume()
        
        URLSession.shared.dataTask(with: URL(string: urlApiCurrent)!) { data, response, errors in
            do{
                let dataC = try JSONDecoder().decode(CurrentWeather.self, from: data!)
                
                DispatchQueue.main.async {
                    self.dataCurrent = dataC
                    self.configUI()
                }
            }catch{
                print(errors)
            }
        }.resume()
    }
    
    func configUI(){
        guard let data = dataCurrent else{
            return
        }
        img_statS.image = UIImage(named: data.weather[0].icon)
        lbl_dateS.text = data.dt.formatDate()
        lbl_tempS.text = data.main.temp.formatTempC()
        lbl_statS.text = data.weather[0].weatherDescription.capitalized
        lbl_wind.text = data.wind.speed.formatWindMilh()
        lbl_humidity.text = data.main.humidity.formatHumidity()
    }
}

