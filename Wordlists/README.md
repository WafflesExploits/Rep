# Wordlists

### bypass403.list
- A wordlist to bypass 403 using URL Encoded characters. This was based on Seclists' Unicode wordlist, but added single characters like %0A %00, instead of only having %00%001. This way there is a higher chance of bypassing 403
- Recommended use with Burp Intruder, fuzzing like this: `http://example/forbiddenFUZZHERE`

