import SwiftUI

struct AddRecipeView: View {
    @State private var images: [Image]
    @State private var recipeName: String
    @State private var instructions: String
    @State private var summary: String
    @State private var ingredients: [Ingredient]
    var friuts = ["apple", "banana", "orange", "kiwi"]
    @State private var selectedFruit: String = "banana"
    
    @Environment(\.dismiss) private var dismiss
    
    init(images: [Image] = [], recipeName: String = "", summary: String = "", ingredients: [Ingredient] = [], instructions: String = "") {
        self.images = images
        self.recipeName = recipeName
        self.summary = summary
        self.ingredients = ingredients
        self.instructions = instructions
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section() {
                    ImageSelectionView(images: $images)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .listRowInsets(EdgeInsets())
                .frame(height: images.isEmpty ? Constants.emptyImageSetHeight : Constants.imageSetHeight)
                
                Section {
                    TextField("Enter recipe name", text: $recipeName)
                        .font(.caption)
                } header: {
                    Text("NAME")
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                Section {
                    ZStack(alignment: .topLeading) {
                        if summary.isEmpty {
                            Text("Enter summary of the recipe here...")
                                .font(.caption)
                                .foregroundColor(.secondary.opacity(0.7))
                                .padding(8)
                        }
                        
                        TextEditor(text: $summary)
                            .font(.caption)
                            .disableAutocorrection(true)
                            .background(Color.clear)
                            .frame(minHeight: 50)
                    }
                } header: {
                    Text("SUMMARY")
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                Section {
                    Picker("Category", selection: $selectedFruit) {
                        ForEach(friuts, id: \.self) { fruit in
                            Text(fruit)
                        }
                    }.padding(.leading, 5)
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                Section {
                    // Serving and Time
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                Section {
                    if ingredients.isEmpty {
                        VStack {
                            ContentNotFoundView(labelText: "No Ingredients", descriptionText: "Ingredients you will add appear here", systemImageName: "list.clipboard")
                            Button {
                                
                            } label: {
                                HStack {
                                    Image(systemName: "plus.circle")
                                        .font(.title)
                                }
                            }.padding(.bottom, 5)
                        }
                    } else {
                        
                    }
                } header: {
                    Text("INGREDIENTS")
                        .font(.headline)
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
                Section {
                    ZStack(alignment: .topLeading) {
                        if instructions.isEmpty {
                            Text("Enter recipe instructions here...")
                                .font(.caption)
                                .foregroundColor(.secondary.opacity(0.7))
                                .padding(8)
                        }
                        
                        TextEditor(text: $instructions)
                            .font(.caption)
                            .disableAutocorrection(true)
                            .background(Color.clear)
                            .frame(minHeight: 50)
                    }
                } header: {
                    Text("INSTRUCTIONS")
                        .foregroundColor(.secondary)
                }.listRowInsets(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 15))
                
            }
            .navigationTitle("Add Recipe")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Save the recipe
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}

#Preview {
    AddRecipeView()
}