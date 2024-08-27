import CoreML

// Load the model
let model = try! YourModel(configuration: MLModelConfiguration())

// Make predictions
let input = YourModelInput(data: yourData)
let output = try! model.prediction(input: input)
