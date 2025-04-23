# Forensic-level recovery process for newer Time Machine backups which use APFS
You may need to use this in some recovery situations for retrieving snapshot contents.
It will also allow you to `rsync` the full user and application configuration over an existing MacOS installation.  Full `rsync` of a MacOS instance is not supported, however.

`sudo` command can be assumed for all operations.

## List all disks on machine
Locate the synthesized external disk you are targeting.  In this example, `/dev/disk5s1`.
```bash
diskutil list
```

## Unlock the drive, if encrypted.
If you don't have the secret, you will not be able to proceed.
```bash
diskutil apfs unlockVolume /dev/disk5s1
```

## List all apfs snapshots on the disks
Review and identify the snapshot of interest.  In this example, the friendly name of the drive is simply `Backups`.
```bash
diskutil apfs listSnapshots /Volumes/Backups/
```

## Mount the volume at a new location
The snapshot will be mounted as read-only.
```bash
sudo mkdir -p /Volumes/RestoreFrom
sudo mount_apfs -s com.apple.TimeMachine.2023-08-03-142853.backup -o ro /Volumes/Backups/ /Volumes/RestoreFrom/
```

## Copy from mounted snapshot
```bash
sudo rsync -aHAXx --progress /Volumes/RestoreFrom/ /Volumes/BackupClone/SnapshotCopy/
```
