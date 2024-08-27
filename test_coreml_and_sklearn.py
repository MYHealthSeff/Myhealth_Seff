import coremltools as ct
from sklearn.tree import DecisionTreeClassifier
import pandas as pd
import numpy as np

# Sample data
X = pd.DataFrame({'Mobility': [0, 1], 'Priority': [1, 2]})
y = pd.Series(['Critical', 'Stable'])

# Train a sample model
model = DecisionTreeClassifier()
model.fit(X, y)

# Define input types
input_features = [('Mobility', ct.TensorType(shape=(2,))), 
                  ('Priority', ct.TensorType(shape=(2,)))]

# Test conversion
try:
    coreml_model = ct.convert(model, inputs=input_features)
    print('Conversion successful!')
except Exception as e:
    print(f'Conversion failed: {e}')

