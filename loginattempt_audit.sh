grep -E '^\s*deny\s*=\s*[1-5]\b' /etc/security/faillock.conf


grep -E '^\s*unlock_time\s*=\s*(0|9[0-9][0-9]|[1-9][0-9][0-9][0-9]+)\b' /etc/security/faillock.conf
