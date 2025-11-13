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

16) Document sources and references

- **AVEVA Product Documentation Center:** The primary source for installers, release notes, compatibility matrices, and step-by-step install guides. Search for "PLC Viewer" or "OMI" within AVEVA's documentation site or product pages. Example starting point: `https://www.aveva.com/`.
- **AVEVA Support / Knowledge Base:** Use the AVEVA support portal and knowledge base for hotfixes, KB articles, and product-specific guidance (license configuration, known issues, VM recommendations).
- **Release Notes & Installation Guides:** Always consult the release notes and the installation guide that comes with the exact installer you downloaded — these list prerequisites, supported OS versions, required runtimes, and documented silent-install switches.
- **Installer Readme / Package Contents:** Inspect the installer package (MSI or EXE) for an embedded README or PDF. Tools like 7-Zip (for EXE/NSIS wrappers) or `lessmsi` (for MSI contents) can reveal readme files and MSI tables.
- **MSI Tables / Orca:** For MSI-based installers, open the MSI with Orca (from the Windows SDK) or an MSI inspector to view public properties, custom actions, and supported command-line options.
- **Vendor Integration Docs (OPC / PLC vendors):** When configuring connectivity (OPC UA/DA, vendor drivers), consult the PLC vendor's documentation (Rockwell, Siemens, etc.) and your OPC server vendor for recommended settings and security guidance.
- **Internal Repositories / IT SOPs:** If your organization maintains an internal software repository or runbooks, match the AVEVA docs to your internal packaging notes (installer filenames, pre-installed redistributables, accepted configuration templates).
- **Community & Forums:** AVEVA community forums, user groups, and third-party operational technology (OT) forums can provide practical tips (DCOM settings, common pitfalls). Treat community advice as supplementary and verify with vendor docs.

Practical search tips

- Search the AVEVA site for the exact product name and the word "install" or "release notes" (for example: `"PLC Viewer" install guide release notes site:aveva.com`).
- Open downloaded installers in a VM first and capture the embedded readme or release-notes PDF before wide deployment.
- When you need silent install switches, look for an MSI in the EXE (7-Zip) or inspect product documentation — many vendors list `/qn`, `/quiet`, or `/S` options, but exact options are product-specific.

Where I'll look if you want me to fetch specifics

- AVEVA product pages and support portal for the PLC Viewer installer and release notes.
- Installer package contents (MSI/EXE) to extract readme files and confirm silent install options.
- AVEVA Knowledge Base for any PLC Viewer-specific KB articles about licensing, connectivity, and known issues.

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
