# GoPhish Launcher Script

This Bash script automates the download, installation, SSL configuration, and launch of [GoPhish](https://github.com/gophish/gophish), an open-source phishing toolkit.

## Features

- Downloads the latest GoPhish release.
- Creates SSL certificates for secure connections.
- Automatically edits the `config.json` with proper paths and email.
- Prepares GoPhish to be launched on `https://0.0.0.0:3333`.

## Requirements

- `bash`
- `wget`, `unzip`, `openssl`, `jq`
- `sudo` privileges

## Usage

```bash
chmod +x go_phish_launcher.sh
sudo ./go_phish_launcher.sh your_email@example.com
```

> Replace `your_email@example.com` with your actual contact email (required for SSL certificate and GoPhish config).

## What it Does

1. Creates a `~/go_phish` directory.
2. Downloads GoPhish ZIP and extracts it.
3. Installs required dependencies.
4. Generates a self-signed SSL certificate.
5. Modifies `config.json` with email and cert paths.
6. Starts the GoPhish server.

## Output

- Admin server: `https://0.0.0.0:3333`
- Config and certs stored in: `~/go_phish/`

## Notes

- Default GoPhish credentials are:  
  **Username:** `admin`  
  **Password:** (provided at first run or in `config.json`)
- Modify the script as needed to suit production environments or use official SSL certificates.

---

**Disclaimer:** Use GoPhish responsibly and only on systems you are authorized to test.
****
