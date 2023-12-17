import SwiftUI

struct ContentView: View {
    @State private var apiKey: String = "f14c3676a0e0f4534c2e404233c9d0b7"
    @ObservedObject private var weatherViewModel = WeatherViewModel()

    var body: some View {
        VStack {
            Text("Weather App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            TextField("Enter API Key", text: $apiKey)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .disabled(true)

            Spacer()

            Text("City: London")
                .font(.headline)
                .padding(.bottom)

            Text("Temperature: \(weatherViewModel.temperature)")
                .font(.title)
                .padding()

            Text("Forecast: \(weatherViewModel.forecast)")
                .font(.title)
                .padding()

            Spacer()

            Button("Get Weather") {
                weatherViewModel.getWeather(apiKey: apiKey, for: "London")
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.bottom)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
