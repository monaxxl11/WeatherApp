import Foundation

struct WeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}

class WeatherViewModel: ObservableObject {
    @Published var temperature: String = ""
    @Published var forecast: String = ""

    func getWeather(apiKey: String, for city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }

            do {
                let weatherData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.temperature = String(format: "%.1f", weatherData.main.temp - 273.15) + "°C"
                    self.forecast = weatherData.weather.first?.description ?? ""
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
