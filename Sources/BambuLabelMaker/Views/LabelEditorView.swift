import SwiftUI
import RealmSwift

struct LabelEditorView: View {
    @StateObject private var viewModel = LabelPresetsViewModel()
    @State private var isShowingPresetSheet = false
    @State private var isShowingPrintSheet = false
    @State private var labelScale: CGFloat = 1.0
    
    // Form fields
    @State private var name = ""
    @State private var filamentBrand = ""
    @State private var filamentType = ""
    @State private var color = ""
    @State private var temperature = 200
    @State private var bedTemperature = 60
    @State private var weight = 1.0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Label Preview")) {
                    LabelPreviewView(
                        name: name,
                        filamentBrand: filamentBrand,
                        filamentType: filamentType,
                        color: color,
                        temperature: temperature,
                        bedTemperature: bedTemperature,
                        weight: weight,
                        scale: labelScale
                    )
                    .frame(height: 200)
                    
                    Slider(value: $labelScale, in: 0.5...2.0, step: 0.1) {
                        Text("Label Size")
                    }
                }
                
                Section(header: Text("Filament Details")) {
                    TextField("Preset Name", text: $name)
                    TextField("Brand", text: $filamentBrand)
                    TextField("Type", text: $filamentType)
                    TextField("Color", text: $color)
                    
                    Stepper("Nozzle Temperature: \(temperature)°C", value: $temperature, in: 150...300)
                    Stepper("Bed Temperature: \(bedTemperature)°C", value: $bedTemperature, in: 0...120)
                    
                    HStack {
                        Text("Weight")
                        Spacer()
                        TextField("Weight", value: $weight, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                        Text("kg")
                    }
                }
                
                Section {
                    Button("Save as Preset") {
                        let preset = viewModel.createNewPreset(
                            name: name,
                            filamentBrand: filamentBrand,
                            filamentType: filamentType,
                            color: color,
                            temperature: temperature,
                            bedTemperature: bedTemperature,
                            weight: weight
                        )
                        viewModel.currentPreset = preset
                    }
                    
                    Button("Print Label") {
                        isShowingPrintSheet = true
                    }
                }
            }
            .navigationTitle("Bambu Label Maker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Presets") {
                        isShowingPresetSheet = true
                    }
                }
            }
            .sheet(isPresented: $isShowingPresetSheet) {
                PresetsListView(viewModel: viewModel)
            }
            .sheet(isPresented: $isShowingPrintSheet) {
                PrintLabelView(
                    name: name,
                    filamentBrand: filamentBrand,
                    filamentType: filamentType,
                    color: color,
                    temperature: temperature,
                    bedTemperature: bedTemperature,
                    weight: weight,
                    scale: labelScale
                )
            }
        }
    }
}

#Preview {
    LabelEditorView()
} 