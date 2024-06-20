# import jwt
# from cryptography.hazmat.primitives import serialization
# from cryptography.hazmat.primitives.asymmetric import rsa
# from cryptography.hazmat.primitives.asymmetric import padding
# from cryptography.hazmat.primitives import hashes
# from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
# from base64 import urlsafe_b64encode
# import os
#
# def generate_secret_key():
#     key = jwt.algorithms.HMACAlgorithm.prepare_key(os.urandom(32))
#     return urlsafe_b64encode(key).decode('utf-8')
#
# if __name__ == "__main__":
#     secret_key = generate_secret_key()
#     print(f"Generated Secret Key: {secret_key}")
