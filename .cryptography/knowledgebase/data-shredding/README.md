# Shredding

- On Linux read `man shred`. This will give you a brief overview on what to expect.
- If only shred is installed you can delete a folder through following command:

      find . -type f -print0 | xargs -0 shred -fuzv

- You might also want to look into
  - `srm`
  - `wipe`
  - `rm -p ...`