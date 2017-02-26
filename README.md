# shell-imap-notify

This is a shell script that can be used to trigger commands on IMAP IDLE events. I use it to trigger mbsync when new mail is received or a message is removed from the server. It keeps connections open by sending a NOOP command every 10 minutes. When the server closes the connection the script ends. For optimal performance I use a wrapper script (see example_use.sh) that fetches my passwords from a gpg encrypted file and opens the connections in an endless loop, thus restarting the IMAP connections when the computer wakes up from a long sleep or the internet connection is interrupted.
