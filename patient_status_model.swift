# patient_status_model.py
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import coremltools as ct

# Simulate some patient data
data = {
    'age': [45, 67, 34, 78, 56, 23],
    'heart_rate': [80, 76, 90, 70, 68, 100],
    'blood_pressure': [120, 130, 110, 140, 135, 125],
    'position': ['upright', 'supine', 'upright', 'supine', 'upright', 'supine']
}

df = pd.DataFrame(data)

# Convert position to numerical
df['position'] = df['position'].map({'upright': 0, 'supine': 1})

# Split data
X = df.drop('position', axis=1)
y = df['position']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train a RandomForest model
model = RandomForestClassifier()
model.fit(X_train, y_train)

# Convert the model to Core ML
coreml_model = ct.converters.sklearn.convert(model, X.columns, "position")
coreml_model.save("PatientStatusModel.mlmodel")
