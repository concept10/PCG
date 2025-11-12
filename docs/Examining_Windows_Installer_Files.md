# Examining Windows Installer Files (.exe)

This guide helps you inspect and analyze Windows `.exe` installer files, including those made with Inno Setup, NSIS, or wrapped MSI files.

---

## 1. Identify the Installer Type

Before extracting, identify what type of installer you're dealing with.

### Use `trid`
```bash
trid installer.exe
```

### Use `PEiD` or `Detect It Easy (DIE)`
- [PEiD](https://www.aldeid.com/wiki/PEiD) — Detects packers/installers.
- [DIE](https://ntinfo.biz) — Modern alternative for file type detection.

---

## 2. Extract the Installer Contents

Once identified, extract contents using the right tools:

### Inno Setup
```bash
innounp -x installer.exe
```
- Tool: [InnoUnp](https://github.com/dscharrer/innoextract)

### NSIS (Nullsoft)
```bash
7z x installer.exe
```
- Tool: [NSIS](https://nsis.sourceforge.io/)
- `7-Zip` often works for extraction.

### MSI-Wrapped EXE
Try:
```bash
installer.exe /extract <path>
```

Or use:
- [lessmsi](https://lessmsi.activescott.com/)

---

## 3. Use Reverse Engineering Tools (Advanced)

If the installer is obfuscated or custom-built:

- **[PE Explorer](https://www.heaventools.com/overview.htm)** or **CFF Explorer**: Inspect PE headers and resources.
- **[Resource Hacker](http://www.angusj.com/resourcehacker/)**: View and modify GUI/dialogs/resources.
- **[IDA Free](https://hex-rays.com/ida-free/)** / **[Ghidra](https://ghidra-sre.org/)**: Binary disassembly.
- **[Process Monitor (ProcMon)](https://docs.microsoft.com/en-us/sysinternals/downloads/procmon)**: Track file/registry activity.

---

## 4. Run Safely in a Virtual Environment

If unsure about behavior:

- Use **Windows Sandbox**, **VM**, or **[Cuckoo Sandbox](https://cuckoosandbox.org/)**.
- Monitor with:
  - `Process Monitor`
  - `Process Explorer`

---

## 5. Extract Embedded Strings and Metadata

Use the `strings` utility:
```bash
strings installer.exe | more
```

---

## Summary Table

| Tool                | Use Case                                 |
|---------------------|-------------------------------------------|
| `trid`              | Detect file type                          |
| `innounp`           | Extract Inno Setup installer              |
| `7-Zip`             | Extract NSIS or MSI                       |
| `Resource Hacker`   | View/edit resources in the `.exe`         |
| `Process Monitor`   | Monitor file/registry activity            |
| `strings`           | Get embedded text                         |
| `Ghidra` / `IDA`    | Reverse engineering (deep dive)           |

---

## Need Help?
If you have a specific `.exe` file, I can help walk through it step-by-step.
