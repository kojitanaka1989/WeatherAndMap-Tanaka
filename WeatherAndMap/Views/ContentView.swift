//
//  ContentView.swift
//  WeatherAndMap
//
//  Created by 田中康志 on 2025/02/15.
//

import SwiftUI


struct ContentView: View {
    //APIへリクエスト、レスポンスの値を保持するオブジェクト
    @StateObject private var weatherVM = WeatherViewModel()
    @StateObject var locationManager = LocationManager() // 位置情報管理のオブジェクト
    
    // 八幡平市大更の緯度・経度
    var lat: Double = 50//39.91167
    var lon: Double = 100//141.093459
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20){
                    DailyWeatherView(weatherVM: weatherVM, locationManager: locationManager)
                    HourlyWeatherView(weatherVM: weatherVM)
                }
                .padding()
                
            }
            .navigationTitle("現在地: \(locationManager.address)")
            .navigationBarTitleDisplayMode(.inline)//タイトルの書式
            
            // マップ画面へのボタンをナビゲーションバーに追加
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        MyLocationView(locationManager: locationManager)
                    } label: {
                        Image(systemName: "map")
                    }
                }
            }
            
            // スクロールビューを下に引っ張って実行
            .refreshable {
                getWeatherForecast()
            }
            
        }
        .padding()
        .onAppear{
            getWeatherForecast()
        }
    }
    // 現在地の天気予報取得、順番に処理したいのでDispatchQueue.main.async使用
    func getWeatherForecast() {
        DispatchQueue.main.async {
            if let location = locationManager.location {
                let latitude = location.coordinate.latitude     // 緯度
                let longitude = location.coordinate.longitude   // 軽度
                weatherVM.request3DaysForecast(lat: latitude, lon: longitude) // 天気リクエスト
                print("LAT:", latitude, "LON:", longitude)
            } else {
                print("getting weather is failed")
            }
        }
    }
}

#Preview {
    ContentView()
}
