import jwt

# Example payload
payload = {"some": "payload"}

# Encode the payload using a secret key
encoded = jwt.encode(payload, "secret", algorithm="HS256")
print(f"Encoded JWT: {encoded}")

# Decode the JWT using the same secret key
decoded = jwt.decode(encoded, "secret", algorithms=["HS256"])
print(f"Decoded Payload: {decoded}")



