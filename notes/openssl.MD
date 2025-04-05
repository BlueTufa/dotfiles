# Open SSL and SSL notes

How to dump the certificate chain from any web site:

  ```bash
openssl s_client -connect go.integration.livongo.com:443 -showcerts
  ```

Generate a self-signed cert:

```bash
openssl genrsa -out key.pem 2048
openssl req -new -sha256 -key key.pem -out csr.csr
openssl req -x509 -sha256 -days 1825 -key key.pem -in csr.csr -out certificate.pem
openssl req -in csr.csr -text -noout | grep -i "Signature.*SHA256" && echo "All is well"
```

Add a trusted root cert on a Mac:

```bash
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain serviceca.crt
```

Verify the cert and key match:
```bash
openssl x509 -modulus -noout -in 6ef64fc7ef8ebcbb.crt | openssl sha256
```

```bash
openssl rsa -modulus -noout -in blah.me.key | openssl sha256
```

Convert a .crt to a .pem
```bash
openssl x509 -inform DER -in self-signed.crt -out self-signed.pem
```

Convert a PEM file to PKCS8
```bash
openssl pkcs8 -topk8 -nocrypt -in private.pem -inform pem -out private-pkcs8.key
```
