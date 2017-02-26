#!/usr/bin/env bash
set -eo pipefail

# Connection is kept alive with NOOP calls by imap-notify but when the computer sleeps
# the connection is closed by the server after +- 15 min.
# Because the connection is gone, the imap-notify scripts are killed and the 'wait' command
# is free to continue, triggering another loop and restarting the imap-notify scripts.

function gpg-password {
  gpg2 -q --for-your-eyes-only --no-tty -d ~/mail_passwords.gpg | grep "imap $1" | cut -d" " -f3-
}

while [ 1 ]; do
  ~/Mail/bin/imap-notify imap_username1 "$(gpg-password user@domain1.com)" server1.com:993 "mbsync account1" &
  ~/Mail/bin/imap-notify imap_username2 "$(gpg-password user@domain2.com)" server2.com:993 "mbsync account2" &

  # Kill whole processgroup, also killing descendants
  trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

  wait
done
