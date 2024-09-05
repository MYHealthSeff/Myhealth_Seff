import React, { useState } from 'react';
import { View, TextInput, Button, Text, StyleSheet, Alert } from 'react-native';
import axios from 'axios';

// Example synthetic dataset
const syntheticDataset = [
  { username: 'maryhckymom7604@gmail.com', password: 'password1234' }, // Example entry
  // Add 49 more synthetic users
  // ...
];

const validateUsername = (username) => {
  const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailPattern.test(username) || (username.length >= 12 && /[a-zA-Z0-9]/.test(username));
};

const validatePassword = (password) => {
  return password.length >= 8;
};

const authenticateUser = (username, password) => {
  return syntheticDataset.find(user => user.username === username && user.password === password);
};

const sendConfirmationEmail = async (email) => {
  try {
    await axios.post('https://yourapi.com/api/sendEmail', {
      to: email,
      subject: 'Welcome to MyHealth.AI',
      text: 'This email confirms your registration with MyHealth.AI. Please click this link to sync your information and be sure to complete your custom profile and discover what personalized tools, abilities, and features we have for you!'
    });
  } catch (err) {
    console.error('Failed to send confirmation email:', err);
  }
};

const LoginPage = ({ navigation }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const handleLogin = async () => {
    if (!validateUsername(username)) {
      setError('Invalid username. Must be a valid email or at least 12 characters long.');
      return;
    }

    if (!validatePassword(password)) {
      setError('Password must be at least 8 characters long.');
      return;
    }

    const user = authenticateUser(username, password);

    if (user) {
      await sendConfirmationEmail(username);
      navigation.navigate('MySection_view'); // Navigate to MySection_view on successful login
    } else {
      setError('Login failed. Invalid username or password.');
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Login</Text>
      <TextInput
        style={styles.input}
        placeholder="Username (Email or 12+ chars)"
        value={username}
        onChangeText={setUsername}
      />
      <TextInput
        style={styles.input}
        placeholder="Password"
        secureTextEntry
        value={password}
        onChangeText={setPassword}
      />
      <Button title="Login" onPress={handleLogin} />
      {error ? <Text style={styles.error}>{error}</Text> : null}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    padding: 16,
  },
  title: {
    fontSize: 24,
    marginBottom: 20,
    textAlign: 'center',
  },
  input: {
    height: 40,
    borderColor: 'gray',
    borderWidth: 1,
    marginBottom: 12,
    paddingHorizontal: 8,
    borderRadius: 4,
  },
  error: {
    color: 'red',
    marginTop: 12,
    textAlign: 'center',
  },
});

export default LoginPage;
