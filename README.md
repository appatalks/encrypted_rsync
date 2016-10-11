# encrypted_rsync
Rsync to LUKS

Simplistic script to Rsync from Local Machine to Target Host's LUKS Volume.

1) Send Key
2) Mount and Decrypt LUKS Volume
3) Delete Key
4) Sync
5) Umount / Encrypt LUKS Volume

No error checking at this time. Should be easy to impliment.
