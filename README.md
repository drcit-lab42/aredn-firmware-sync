# AREDN Firmware Sync Script

This script mirrors the [AREDN firmware repository](https://downloads.arednmesh.org/), patches the firmware site config to use a local mesh URL, and regenerates JSON indexes. See [Creating a Local AREDN® Software Server](https://docs.arednmesh.org/en/latest/arednHow-toGuides/local-software-source.html).
This script was designed for use by **Disaster Response Communications & Information Technology (DRCIT)** but is freely reusable by other hams/groups.

---

## 🚀 Quick Start

```bash
# 1. Clone this repo
git clone https://drcit.dev/DRCIT/aredn.git
cd aredn

# 2. Edit aredn_sync.sh variables for your node
nano aredn_sync.sh   # set ROOT, LOG, NEW_URL

# 3. Make it executable
install -m 755 aredn_sync.sh ~/.local/bin/

# 4. Test once manually (Below assumes you've installed the script in ~/.local/bin folder).
~/.local/bin/aredn_sync.sh

# 5. Add cron (this example is daily)
crontab -e
# add this line:
0 0 * * * ~/.local/bin/aredn_sync.sh >> ~/.local/logs/aredn.log 2>&1

# 6. Add logrotate rule
sudo tee /etc/logrotate.d/aredn-sync <<'EOF'
su <user> <group>
/<home path>/.local/logs/aredn.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 0640 <user> <group>
}
EOF
```

Done ✅ — your mirror will now stay up to date automatically. Replace `<user>` and `<group>` with actual user & group (usually `drcit` `drcit`), and replace any `<paths>` with the correct *absolute* path (e.g. `/home/drcit/.local/logs/aredn.log`)

---

## 🔧 How it works
1. **Sync**: runs `rsync` to mirror upstream firmware files into `$ROOT`.  
2. **Patch**: replaces the default firmware URL in `afs/www/config.js` with your local mesh URL (`$NEW_URL`).  
3. **Collect**: runs `afs/misc/collect.py` to regenerate JSON indexes.  
4. **Log**: everything is written to `~/.local/logs/aredn.log`.

---

## ⚙️ Variables to Edit
At the top of `aredn_sync.sh`, adjust these for your environment:

```bash
ROOT="$HOME/<path to root folder>/aredn"  # mirror root
AFS="$ROOT/afs"                                   # firmware site files
LOG="$HOME/.local/logs/aredn.log"                 # log path
UPSTREAM="downloads.arednmesh.org::aredn_firmware" # rsync source
NEW_URL="http://n2drc-ls1.local.mesh/"           # mesh URL to inject
```

Replace any `<paths>` with the correct path (e.g. '$HOME/docker/fileserver/files/aredn').

---

## 📅 Cron Job
To keep your mirror current, run the script daily:

```cron
0 0 * * * ~/.local/bin/aredn_sync.sh >> ~/.local/logs/aredn.log 2>&1
```

---

## 📂 Log Rotation
To prevent logs from growing indefinitely, add `/etc/logrotate.d/aredn-sync`:

```conf
su <user> <group>
/<home path>/.local/logs/aredn.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 0640 <user> <group>
}
```

This rotates logs daily, keeps 7 days, and compresses older logs. Replace `<user>` and `<group>` with actual user & group (usually `drcit` `drcit`), and replace any `<paths>` with the correct *absolute* path (e.g. `/home/drcit/.local/logs/aredn.log`). You can test your logrotate file with `sudo logrotate -f /etc/logrotate.d/aredn-sync` to ensure it’s valid.

---

## 📜 License
This project is licensed under the [MIT License](LICENSE).  
You are free to use, modify, and share this script. Attribution to **DRCIT** is appreciated.
