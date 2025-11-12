# PLC Viewer — Installation and Setup Guide (draft)

This document describes a general, practical setup procedure for the AVEVA/OMI "PLC Viewer" application used to view PLC data and simple HMI screens. The instructions are intentionally generic: adapt paths, installer names, and exact options to the PLC Viewer version you have from AVEVA.

Always verify installer names, supported OS versions, and licensing requirements with AVEVA documentation and your IT/security policy before deploying.

**Prerequisites**

- Windows 10/11 (or the supported Windows Server version) fully patched.
- Administrative privileges to install software and modify firewall rules.
- AVEVA account / entitlement to download the PLC Viewer installer (if required).
- Required runtimes (examples): .NET Framework or .NET Desktop Runtime, Visual C++ Redistributable — check your installer notes and install any prerequisites before proceeding.
- If PLC Viewer connects via OPC UA/DA or other middleware, ensure OPC Server or gateway is available and reachable.

**Files you will need**

- `PLCViewer.msi` or `PLCViewerSetup.exe` — official installer obtained from AVEVA or your software repository.
- License files or license server details if required.

1) Download and verify the installer

- Download the installer to a local folder such as `C:\Temp\plcviewer-install`.
- Verify checksums/signatures if provided by AVEVA.

2) Install the application (GUI)

- Right-click the installer and choose **Run as administrator**.
- Follow the installer prompts and choose the components you need (e.g., PLC Viewer, OPC adapter, runtime).
- Typical default install path: `C:\Program Files\AVEVA\PLC Viewer\` (your installer may differ).
- If the installer offers to install prerequisites (VC++ redistributables, .NET), allow it or install those packages first.

3) Install the application (silent / unattended)

- Many AVEVA/MSI-based installers support `msiexec`:

```powershell
msiexec /i "C:\Temp\plcviewer-install\PLCViewer.msi" /qn /norestart /l*v C:\Temp\plcviewer-install\install.log
```

- If the installer is a self-extracting EXE, check vendor documentation for silent switches (commonly `/S`, `/silent`, or `--silent`).

4) Licensing

- If PLC Viewer requires a license file or points to a license server, configure licensing now before first run.
- License server configuration may be via a configuration file, registry key, or a license manager UI. Consult your AVEVA license guide or local licensing server documentation.

5) Configure connectivity to PLC or data source

- PLC Viewer commonly reads live PLC data via one of these methods:
  - Direct vendor driver or gateway (e.g., Rockwell/Allen-Bradley driver)
  - OPC DA/UA server
  - AVEVA Historian connector or other adapters

- Example: create an OPC UA endpoint in PLC Viewer pointing at `opc.tcp://plc-host:4840` (replace with your OPC server URL).
- If using OPC DA, ensure a COM/DCOM configuration is set up for remote access and that user accounts have the needed DCOM permissions.

6) Firewall and network rules

- If PLC Viewer needs inbound or outbound network access to reach OPC servers, license servers, or gateways, add firewall rules.

Example PowerShell to allow the installed executable through Windows Firewall (adjust path):

```powershell
New-NetFirewallRule -DisplayName "PLC Viewer (allow)" -Direction Outbound -Program "C:\Program Files\AVEVA\PLC Viewer\plcviewer.exe" -Action Allow -Profile Domain,Private -Enabled True
New-NetFirewallRule -DisplayName "PLC Viewer (allow)" -Direction Inbound -Program "C:\Program Files\AVEVA\PLC Viewer\plcviewer.exe" -Action Allow -Profile Domain,Private -Enabled True
```

7) First run and verification

- Launch `PLC Viewer` from the Start Menu or the installed folder.
- Open or create a connection to your PLC/OPC server:
  - Check for a successful connection state or heartbeat indicator in the application UI.
  - Browse tag namespace and subscribe to a small set of tags to confirm data values update.
- If the application provides sample displays or test connections, use those first to validate functionality.

8) Common configuration items to check

- Tag polling/update rate — reduce polling frequency if performance is a concern.
- User accounts and permissions for reading/writing tags.
- Time synchronization between PLC, OPC server, and client machine (NTP).
- Logging location and log verbosity (enable detailed logs temporarily for troubleshooting).

9) Troubleshooting

- Cannot connect to PLC/OPC server:
  - Verify network connectivity (ping, Test-NetConnection for port).
  - Confirm OPC endpoint URL/port and credentials.
  - For OPC DA, check DCOM settings and firewall rules.

- Licensing errors:
  - Verify license file path or license server reachability.
  - Check event logs and vendor-supplied logs for license validation messages.

- Application crashes or fails to start:
  - Review `Event Viewer` > `Windows Logs` > `Application` for .NET or crash errors.
  - Check application log files in the install folder or `%LOCALAPPDATA%`.

10) Uninstall

- Use the standard Windows "Add or remove programs" control panel, or run:

```powershell
msiexec /x "C:\Temp\plcviewer-install\PLCViewer.msi" /qn
```

- Confirm that configuration files and logs were removed if you want a clean reinstall.

11) Deployment best practices

- Test the installer and configuration in a lab VM before wide deployment.
- Use silent install switches and a configuration template for mass deployments (automate with Group Policy, SCCM, or other management tools).
- Keep a copy of the working configuration (connection strings, DCOM settings, registry keys) for quick restores.

12) Security notes

- Run the viewer with least privilege required. Do not use domain admin credentials for normal operation.
- If using OPC UA, prefer secure endpoints with encryption and certificates.
- If the PLC Viewer is internet-exposed or used from untrusted networks, consult security teams for proper segmentation and monitoring.

13) Further customization and automation (examples)

- Copy a pre-configured settings file during install using a script or configuration management tool.
- Example PowerShell snippet to copy a config file after install (adjust paths):

```powershell
Copy-Item -Path "C:\Builds\PLCViewer\default-config.xml" -Destination "C:\ProgramData\AVEVA\PLCViewer\config.xml" -Force
```

14) Where to get vendor-specific instructions

- For detailed, version-specific install switches, VM compatibility, and exact file/registry names, consult AVEVA product documentation and release notes for your PLC Viewer version.

15) Appendix — checklist (quick)

- [ ] Downloaded installer and verified checksum
- [ ] Installed prerequisites (.NET/VC++ as required)
- [ ] Installed PLC Viewer as Administrator
- [ ] Configured license or license server
- [ ] Configured connection to OPC/PLC and verified data
- [ ] Added firewall rules if required
- [ ] Performed basic read tests and logged results

If you want, I can:

- update this draft with exact installer names, silent install switches, and registry keys for a specific PLC Viewer version, or
- create a silent-install script and Group Policy example for mass deployment.
