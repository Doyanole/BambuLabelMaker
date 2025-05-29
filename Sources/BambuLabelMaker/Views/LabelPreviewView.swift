import SwiftUI
import Kingfisher

struct LabelPreviewView: View {
    let name: String
    let filamentBrand: String
    let filamentType: String
    let color: String
    let temperature: Int
    let bedTemperature: Int
    let weight: Double
    let scale: CGFloat
    
    private let bambuLogoURL = URL(string: "https://raw.githubusercontent.com/SoCuul/Bambu-LabelGen/main/public/bambu-logo.png")!
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 4 * scale) {
                // Header with Bambu Logo
                HStack {
                    KFImage(bambuLogoURL)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40 * scale)
                    Spacer()
                }
                .padding(.horizontal, 8 * scale)
                
                // Filament Details
                VStack(alignment: .leading, spacing: 2 * scale) {
                    Text(filamentBrand)
                        .font(.system(size: 18 * scale, weight: .bold))
                    Text(filamentType)
                        .font(.system(size: 16 * scale))
                    Text(color)
                        .font(.system(size: 14 * scale))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8 * scale)
                
                // Temperature and Weight Info
                HStack {
                    VStack(alignment: .leading) {
                        Text("Nozzle: \(temperature)°C")
                            .font(.system(size: 14 * scale))
                        Text("Bed: \(bedTemperature)°C")
                            .font(.system(size: 14 * scale))
                    }
                    Spacer()
                    Text("\(String(format: "%.1f", weight))kg")
                        .font(.system(size: 16 * scale, weight: .bold))
                }
                .padding(.horizontal, 8 * scale)
            }
            .padding(8 * scale)
            .background(Color.white)
            .cornerRadius(8 * scale)
            .shadow(radius: 2 * scale)
            .frame(width: geometry.size.width * 0.9)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    LabelPreviewView(
        name: "Sample Preset",
        filamentBrand: "Bambu Lab",
        filamentType: "PLA",
        color: "Galaxy Black",
        temperature: 200,
        bedTemperature: 60,
        weight: 1.0,
        scale: 1.0
    )
    .frame(width: 300, height: 200)
    .padding()
    .background(Color.gray.opacity(0.1))
} 