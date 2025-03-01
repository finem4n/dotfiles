# Genral
`df -h` - get available space
`du -hs /path/to/directory` - get size of a dir

## Trim
### Verifying trim support
`lsblk --discard`

And check the values of DISC-GRAN (discard granularity) and DISC-MAX (discard max bytes) columns. Non-zero values indicate TRIM support.

### Verifying if trim is enabled
#### Periodic trim 
##### Systemd
Check `fstrim.service` and  `fstrim.timer` systemd units
#### Continuous trim
in `/etc/fstab` check for `discard` mount option

### Sources:
- https://wiki.archlinux.org/title/Solid_state_drive
