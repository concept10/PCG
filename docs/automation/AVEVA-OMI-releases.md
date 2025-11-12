# Draft: AVEVA OMI Applications (enumeration)

This is a local draft enumerating common AVEVA OMI (Operations Management Interface) applications and components. This file is intentionally conservative — it lists commonly-deployed OMI applications and related components and uses placeholders for version numbers. If you want, I can fetch exact current release numbers and vendor SKUs and update each entry.

Notes:
- This is a draft; verify product names and version numbers against AVEVA's product pages or release notes before using for procurement or compatibility checks.
- Some items may be packaged together in AVEVA bundles or under different product family names depending on the release (System Platform integrations, InTouch, etc.).

Enumerated list (common OMI applications / components)

1. PLC Viewer
   - Purpose: Lightweight viewer for PLC tags and simple HMI visualizations; commonly used by engineers to inspect live PLC data without full runtime.
   - Typical install name: "PLC Viewer" or included as part of OMI Desktop tools.
   - Version: (placeholder — verify)

2. OMI Desktop / OMI Client (Viewer)
   - Purpose: Primary desktop client for viewing OMI displays and dashboards on operator/engineering workstations.
   - Notes: May appear as OMI Viewer, OMI Runtime, or OMI Desktop depending on packaging.
   - Version: (placeholder)

3. OMI Runtime / Runtime Engine
   - Purpose: Runtime component that executes displays, connects to data sources, and provides alarm/trend capabilities for deployed OMI displays.
   - Version: (placeholder)

4. OMI Web Client (HTML5/Browser client)
   - Purpose: Browser-based access to OMI displays (for remote operators, mobile, or thin clients).
   - Notes: May require a web server or gateway component.
   - Version: (placeholder)

5. OMI Server / Application Server
   - Purpose: Central server hosting display packages, user sessions, configuration distribution, and connection brokerage to back-end data sources.
   - Version: (placeholder)

6. OMI Trend / Trend Viewer
   - Purpose: Historic and real-time trending component (may be integrated or a separate viewer).
   - Version: (placeholder)

7. OMI Alarm & Events / Alarm Viewer
   - Purpose: Dedicated alarm viewing and acknowledgement interface; sometimes bundled with the Desktop or Web client.
   - Version: (placeholder)

8. OMI Connector / Data Adapters (e.g., Historian connector, OPC UA/DA connectors)
   - Purpose: Connectors and adapters used to integrate OMI with AVEVA Historian, OPC servers, PLCs, and other data sources.
   - Examples: OPC DA/UA adapter, Historian connector (product names vary by release).
   - Version: (placeholder)

9. OMI Development Tools / Designer
   - Purpose: Authoring environment used to create and edit OMI displays and visualization projects (may be called Designer, Studio, or similar).
   - Version: (placeholder)

10. OMI Mobile / Thin Client (if available)
    - Purpose: Mobile-specific or thin-client deployment packages for tablets/smartphones.
    - Version: (placeholder)

11. Installation & Deployment Utilities
    - Purpose: Installers, patch utilities, and packaging tools used to deploy OMI components across workstations and servers.
    - Version: (placeholder)

12. Licensing & License Server Components
    - Purpose: License management services relevant to OMI product activation and entitlement checks.
    - Version: (placeholder)

How to use this draft

- If you want a definitive, up-to-date enumeration with exact release numbers and build IDs, I can fetch the current information from AVEVA's website and release notes and replace the placeholders.
- If you prefer, tell me a specific subset to focus on (e.g., just desktop clients and PLC Viewer), and I'll expand those entries with notes about install paths, common file names, and typical compatibility constraints.

Next steps I can take (choose one):
- Fetch and populate current release/version numbers for each item from AVEVA's official site (I will add sources and release-note links).  
- Produce a printable checklist for installing/upgrading the enumerated components.  
- Keep this as a local draft and add additional AVEVA integrations (InTouch, System Platform) if relevant.
