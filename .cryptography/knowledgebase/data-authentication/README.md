
# Data authentication
- Parties:
  - proving party / (usually) sender of the data
  - verifying party / (usually) recipient of the data
  - third party
   
- Generic Explanation:
  - proving party uses cryptographic key to calculate a tag
  - verifying party uses received tag to check if data is authentic and the correct key is used

- Symmetric Scheme:
  - proving party + verifying party use same cryptographic key. Third party cannot verify who calculated the tag.

- Asymmetric Scheme:
  - private key is used for tag calculation and public key for verification



# MAC (Message Authentication Code)
Symmetric methods for data authentication based on block ciphers or hash functions.

Recommended methods:
 - CMAC
 - HMAC
 - GMAC