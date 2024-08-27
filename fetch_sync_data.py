
import requests
import json

def fetch_data():
    response = requests.get('https://api.hospitaldata.com/patients')
    if response.status_code == 200:
        data = response.json()
        with open('patient_data.json', 'w') as file:
            json.dump(data, file)
        print('Data fetched and saved locally.')
    else:
        print('Failed to fetch data.')

if __name__ == '__main__':
    fetch_data()

