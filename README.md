# aws-bootstrap
From the book "The Good Parts of AWS"

## Security Notice

This project currently uses pm2 version 6.0.8, which has a known low severity vulnerability (GHSA-x5gf-qvw8-r2rm / CVE-2025-5891).
This is a Regular Expression Denial of Service vulnerability with a CVSS score of 4.3.

There is currently no patched version available for this vulnerability. The vulnerability is being monitored,
and you can check for updates using the script `./check-pm2-vulnerability.sh`.

For more information about the vulnerability, see:
- https://github.com/advisories/GHSA-x5gf-qvw8-r2rm
- https://nvd.nist.gov/vuln/detail/CVE-2025-5891
