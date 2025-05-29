import SwiftUI

struct PresetsListView: View {
    @ObservedObject var viewModel: LabelPresetsViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.presets) { preset in
                    PresetRowView(preset: preset)
                        .contextMenu {
                            Button(role: .destructive) {
                                viewModel.deletePreset(preset)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .onTapGesture {
                            viewModel.currentPreset = preset
                            dismiss()
                        }
                }
            }
            .navigationTitle("Saved Presets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct PresetRowView: View {
    let preset: LabelPreset
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(preset.name)
                .font(.headline)
            
            HStack {
                Text(preset.filamentBrand)
                    .font(.subheadline)
                Text("•")
                Text(preset.filamentType)
                    .font(.subheadline)
                Text("•")
                Text(preset.color)
                    .font(.subheadline)
            }
            .foregroundColor(.secondary)
            
            HStack {
                Text("Nozzle: \(preset.temperature)°C")
                Text("•")
                Text("Bed: \(preset.bedTemperature)°C")
                Text("•")
                Text("\(String(format: "%.1f", preset.weight))kg")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    PresetsListView(viewModel: LabelPresetsViewModel())
} 