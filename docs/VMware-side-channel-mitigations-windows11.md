# Correcting the "Side channel mitigations enabled" hint for Windows 11 VMs (VMware Workstation)

This document explains how to stop the VMware Workstation hint shown in the screenshot and how to change the side-channel mitigation setting for a Windows 11 virtual machine. The message warns that side-channel mitigations are enabled (better security, lower performance) and points to VMware KB article 79832: https://kb.vmware.com/s/article/79832

**Summary:** if you want the VM to run faster and you accept the reduced protection against side-channel attacks, disable the virtual machine's side-channel mitigations in the VM advanced settings. If you prefer to keep the mitigations, you can make the diagnostic hint stop appearing by checking the dialog's "Do not show this hint again" box.

**Important:** Disabling mitigations reduces protection against speculative execution / side-channel attacks. Only disable them if you understand and accept the security tradeoffs for this VM and the workload running inside it.

**Supported versions:** Instructions below assume VMware Workstation (desktop) UI. If you use VMware Player, ESXi, or an older/newer Workstation release and the GUI options are different, consult the VMware KB article linked above for the exact steps.

**Quick steps (GUI) — recommended**

1. Power off the Windows 11 virtual machine (do not suspend).
2. In VMware Workstation, select the virtual machine in the library.
3. Click `VM` -> `Settings` (or right-click the VM and choose `Settings`).
4. In the Settings window, switch to the **Options** tab and look for an **Advanced** or **Advanced Options** section. (In some Workstation versions the advanced controls are in a separate `Advanced` tab.)
5. Find the setting labeled `Side Channel Mitigations` (or similar). Change the option from `Enabled` (or `Automatic`) to `Disabled`.
6. Click `OK` to save settings.
7. Start the VM and confirm the hint no longer appears. Optionally run a short workload to confirm improved performance.

If your Workstation UI does not show the `Side Channel Mitigations` option, consult the VMware KB article (see link above) — some versions require editing the VM configuration file manually or use a different setting name.

**Alternative: Disable the hint only**

- When the dialog appears in the VM guest or in VMware Workstation, check `Do not show this hint again` then click `OK`. This will prevent the hint from popping up in future, while leaving mitigations enabled.

**Advanced: Edit the VMX file (manual, use caution)**

1. Power off the VM.
2. Make a backup copy of the VM's directory (important) and a copy of the `.vmx` file.
3. Open the VM's `.vmx` file with a text editor (Notepad, VS Code).
4. Follow the instructions in VMware KB 79832 for the exact VMX parameter to set to disable side-channel mitigations for your Workstation version. (Different VMware releases may use different VMX keys.)
5. Save the `.vmx`, then start the VM.

Note: I did not include a specific VMX key here because VMware documents the correct key/value per product version in KB 79832 — use that official source to avoid using unsupported keys.

**How to verify**

- After changing the setting and powering on the VM, observe whether the hint appears.
- In the guest (Windows 11) you can run a few workloads and check Task Manager / resource usage; many users see an uplift in CPU-bound benchmarks when mitigations are disabled.

**How to revert**

- Re-open the VM Settings > Advanced and set `Side Channel Mitigations` back to `Enabled` (or remove the manual VMX key you added), then power cycle the VM.

**Security considerations and checklist**

- Do not disable mitigations for VMs that handle untrusted code or that host multi-tenant workloads where side-channel protection is needed.
- Consider applying mitigations selectively: disable them for isolated lab/testing VMs where performance matters and the guest runs trusted code.
- Keep host and guest OS patched. If you disable VMware-level mitigations, ensure other mitigations and OS updates are still present.

**References**

- VMware KB article referenced in the hint: https://kb.vmware.com/s/article/79832

---

If you want, I can:

- add a specific VMX example after checking the KB for your Workstation version, or
- create a small checklist you can print and follow while changing multiple VMs.
