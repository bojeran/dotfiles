

# Symmetric Encryption

- As of 2022 the recommendation is still to use the following **symmetric encryption schemes**:
  - AES-128, AES-192, AES-256
  - See: https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/TechGuidelines/TG02102/BSI-TR-02102-1.html

- This standard only provides a **mechanism** for the encryption of plaintexts of a single fixed length! e.g.
  AES-128 defines how to encrypt 128 bit block, AES-192 defines how to encrypt a 192 bit block, ... (that's
  why AES is in the category block cipher).
  - That's why we also need a **cryptographically strong mode of operation** to encrypt plaintext of any length.
  - The mode of operation changes the strength of security here and there:
    - Added randomness can make the overall **encryption scheme** stronger than using the plain underlying
      block cipher.
    - Some modes of operations initially only handle plaintexts the length of which is a multiple of the 
      block size. In this case you need to add padding to the last plaintext block. Use an adequate
      **padding scheme** as padding can also allow some attacks.

- Recommended mode of operations:
  - CCM - Counter with Cipher Block Chaining Message Authentication - ADDITIONALLY provides 
    **secure data authentication** (if the tag length is sufficient?)
  - GCM - Galois/Counter Mode - ADDITIONALLY provides **secure data authentication** (if the tag length
    is sufficient?)
  - CBC - **needs padding** - Cipher Block Chaining
  - CTR - Counter Mode

- Note: No decryption or other processing should be performed for unauthenticated encrypted data. For CBC and CTR you
  need an additional mechanism for data authentication.

- Recommended Padding Schemes for CBC:
  - ISO Padding (ISO/IEC 9797-1-2011)
  - Cryptographic Message Syntax (CMS) (RFC 5652)
  - ESP padding (RFC 4303)

- Stream ciphers: There are currently no recommended stream ciphers! But AES CTR can be understood as Stream Cipher.
  This is sometimes taught wrong, so keep this in mind.
