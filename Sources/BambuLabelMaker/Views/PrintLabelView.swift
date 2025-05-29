import SwiftUI

struct PrintLabelView: View {
    let name: String
    let filamentBrand: String
    let filamentType: String
    let color: String
    let temperature: Int
    let bedTemperature: Int
    let weight: Double
    let scale: CGFloat
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPrinter: String = ""
    @State private var copies: Int = 1
    @State private var isShowingPrintDialog = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Print Preview")) {
                    LabelPreviewView(
                        name: name,
                        filamentBrand: filamentBrand,
                        filamentType: filamentType,
                        color: color,
                        temperature: temperature,
                        bedTemperature: bedTemperature,
                        weight: weight,
                        scale: scale
                    )
                    .frame(height: 200)
                }
                
                Section(header: Text("Print Settings")) {
                    Picker("Printer", selection: $selectedPrinter) {
                        Text("Default Printer").tag("")
                        // Add more printers here when discovered
                    }
                    
                    Stepper("Copies: \(copies)", value: $copies, in: 1...10)
                }
                
                Section {
                    Button("Print") {
                        isShowingPrintDialog = true
                    }
                }
            }
            .navigationTitle("Print Label")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .printDialog(isPresented: $isShowingPrintDialog) {
                LabelPreviewView(
                    name: name,
                    filamentBrand: filamentBrand,
                    filamentType: filamentType,
                    color: color,
                    temperature: temperature,
                    bedTemperature: bedTemperature,
                    weight: weight,
                    scale: scale
                )
            }
        }
    }
}

#Preview {
    PrintLabelView(
        name: "Sample Preset",
        filamentBrand: "Bambu Lab",
        filamentType: "PLA",
        color: "Galaxy Black",
        temperature: 200,
        bedTemperature: 60,
        weight: 1.0,
        scale: 1.0
    )
} 