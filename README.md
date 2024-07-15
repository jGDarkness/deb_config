# My repo for configuring Debian 12 the way I like after a clean installation.

## This repo assumes you have just installed Debian Bookworm via .iso file on a USB stick, and have configured nothing else.

### Manual Setup Steps before running automated setup script.

<ol> Add Repos
	<li>"Option" key</li>
	<li>In Overview, type "Settings" and press "Enter"</li>
	<li>Scroll down and click on "About" on the navigation bar.</li>
	<li>Scroll down and click on "Software Updates"</li>
	<li>Software app will load. Click on the hamburger menu.</li>
	<li>select software repositories.</li>
	<li>On the "Debian Software" tab, check all checkboxes.</li>
	<li>on the "Developer Options" tab, check "Proposed updates"</li>
	<li>On the "Other Software" tab, delete the entry that contains a reference to the Debian installation CD.</li>
	<li>click "Close"</li>
	<li>You may be prompted to run software updates. If so, click 'Yes' or 'Allow' to run the update.</li>
</ol>
<BR></BR>
<ol>Add user 'jeremy' to sudoers file.
    <li>su root</li>
	<li>enter password</li>
	<li>cd /etc</li>
	<li>sudo nano sudoers</li>
	<li>add: "jeremy" with matching parameters under "root" near the end of the file.</li>
	<li>CTRL + X to exit</li>
	<li>'y' to safe buffer</li>
	<li>Enter to exit to terminal</li>
    <li>exit</li>
</ol>
<BR></BR>

### Run the following scripts in sequence and follow any instructions.

**There is a mandatory reboot at the end of this script. It must happen before running the next script**

<ul>Scripts
	<li>01_dependencies.sh</LI>
	<li>02_core_apps.sh</li>
</ul>

**There is a mandatory reboot at the end of this script. It must happen before running the next script**

# WARNING

There is no error checking in this script as of today.