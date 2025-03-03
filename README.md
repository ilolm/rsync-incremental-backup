
# Rsync Incremental Backup Script with Rotation

A simple and efficient **incremental backup script** using `rsync` with **automatic rotation**. Keeps only the latest **N backups**, deleting the oldest one when a new backup is created.

---

## 🚀 **Features**
- **Incremental backups**: Uses `rsync --link-dest` to hard-link unchanged files, saving space.
- **Automatic rotation**: Keeps the last **N** backups and removes the oldest one.
- **Efficient storage**: Only new/modified files take up space, thanks to hard links.
- **Fully automated**: Can be scheduled via `cron` for daily backups.

---

## 🛠 **Usage**

### **1. Clone the Repository**
```sh
git clone https://github.com/ilolm/rsync-incremental-backup.git
cd rsync-incremental-backup
```

### **2. Edit Backup Paths and Max Backups Count**
Modify `SRC` (source folder), `DEST` (backup folder) and `MAX_BACKUPS` (max Backups Count) in the script:
```sh
nano backup-script.sh
```
Example:
```sh
SRC="/path/to/your/data"
DEST="/path/to/backup/location"
MAX_BACKUPS=7
```

### **3. Make the Script Executable**
```sh
chmod +x backup-script.sh
```

### **4. Run the Backup Manually**
```sh
./backup-script.sh
```

### **5. Automate with Cron (Daily Backup at 3 AM)**
```sh
crontab -e
```
Add this line:
```sh
0 3 * * * /path/to/backup-script.sh
```

---

## 🔄 **How It Works**
1. **Creates a timestamped backup** using `rsync --link-dest` (incremental).
2. **Deletes only the oldest backup** when there are more than **N backups**.
3. **Files that haven’t changed** are hard-linked, that saves disk space.

---

## 📂 **Example Backup Structure**
```
/backup-folder/
 ├── backup-2025-03-03_03-00-00/
 ├── backup-2025-03-04_03-00-00/
 ├── backup-2025-03-05_03-00-00/
 ├── backup-2025-03-06_03-00-00/
 ├── backup-2025-03-07_03-00-00/
 ├── backup-2025-03-08_03-00-00/
 ├── backup-2025-03-09_03-00-00/  <-- (New backup)
```
When a new backup is created, the **oldest folder is deleted**.

---

## 📝 **License**
This script is **open-source** under the MIT License.
