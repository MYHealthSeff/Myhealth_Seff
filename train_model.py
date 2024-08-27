import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
import coremltools as ct

num_patients = 100
patients = pd.DataFrame({
    'PatientID': np.arange(1, num_patients+1),
    'Status': np.random.choice(['Critical', 'Stable', 'Discharged'], 
num_patients),
    'Mobility': np.random.choice(['Mobile', 'Immobile'], num_patients),
    'Priority': np.random.randint(1, 5, num_patients)
})

X = patients[['Mobility', 'Priority']]
y = patients['Status']

X = pd.get_dummies(X)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, 
random_state=42)

tree = DecisionTreeClassifier()
tree.fit(X_train, y_train)

forest = RandomForestClassifier()
forest.fit(X_train, y_train)

print("Decision Tree Accuracy:", tree.score(X_test, y_test))
print("Random Forest Accuracy:", forest.score(X_test, y_test))

coreml_model = ct.converters.sklearn.convert(tree, 
input_features=X.columns.tolist(), output_feature_names='Status')
coreml_model.save('PatientManagement.mlmodel')


print("Model saved as 'PatientManagement.mlmodel'")

