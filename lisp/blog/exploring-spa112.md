#The Problem

I have been using the
[Cisco SPA112](http://www.cisco.com/c/en/us/products/unified-communications/spa112-2-port-phone-adapter/index.html)
for a while now, and it works great for my uses. I just want to connect existing
phone systems to an Asterisk install as peers and be done with it. This has worked great, up until
recently when I was having connectivity issues from the Cisco SPA. Well I went digging
for the usual tools ping and traceroute, but they couldn't be found! The
manual [claimed](http://www.cisco.com/c/en/us/td/docs/voice_ip_comm/csbpvga/spa100-200/admin_guide_SPA100/spa100_ag/administration.html#wp1078504)
they were in the web interface, but as you can see below nothing existed for me.

I tried exploring the DOM a little bit to see if the links had just been hidden,
but couldn't find anything in the HTML/CSS/JS. There was a lot of raw DOM manip, so I
wouldn not be suprised if it just get lost in an off-by-one error or something of the sort.
The following was the Admin tab as I saw it.

<img class="centered-image" src="../img/blog/exploring-spa112/missing-diagnostics.png" />

#Finding all the ASP scripts

I noticed that every page was a dedicated .ASP script in the form of `http://HOST/FILE.asp;session_id=X`

So I decided to try my hand at a little exploring, and got really lucky! I usually
run things through strings then binwalk and then give up :), so for my first step I download
the latest firmware, ran it through strings and grepped for '.asp' with the command being
`strings Payton_1.3.5_004p_102814_1321_pfmwr_bootldr.bin | grep .asp` and got the following output

<pre>
  <code style="height: 15em; overflow: scroll;">
Alg.asp>^
    <br /> BT.asp^^
    <br /> Backup.asp~^
    <br /> Bonjour_set.asp
    <br /> Bridge_Enable.asp
    <br /> Check_ID.asp
    <br /> Cysaja.asp
    <br /> DHCP_Table_Select.asp>_
    <br /> DMZ.asp^_
    <br /> DMZSummary.asp~_
    <br /> DMZ_setting.asp
    <br /> DMZconfig.asp
    <br /> DNS_tab1.asp
    <br /> DNS_tab2.asp
    <br /> Detecthost.asp
    <br /> Detecthost_wait.asp>@
    <br /> Diagnostics2.asp^@
    <br /> Diagnostics_tab1.asp~@
    <br /> Diagnostics_tab2.asp
    <br /> Factory_Defaults.asp
    <br /> Factory_Defaults_run.asp
    <br /> Fail.asp
    <br /> Fail_Busy.asp
    <br /> Fail_general.asp>A
    <br /> Fail_r_s.asp^A
    <br /> Fail_u_s.asp~A~
    <br /> Fail_vlan.asp
    <br /> Failmsg_head.asp
    <br /> Firewall_qs.asp
    <br /> Forward_tab1.asp
    <br /> Forward_tab2.asp
    <br /> Guestnet_setting.asp>B
    <br /> Guestnet_summary.asp^B
    <br /> IGMP.asp~B
    <br /> Internet_Status.asp
    <br /> Log.asp
    <br /> Log_Module.asp
    <br /> Log_Setting.asp
    <br /> Log_View.asp
    <br /> Management.asp>C
    <br /> Management2.asp^C
    <br /> Management_u.asp~C
    <br /> Memory_Information.asp
    <br /> Network_Service.asp
    <br /> Ping.asp
    <br /> Ping1.asp
    <br /> Policy_Routing_tab1.asp
    <br /> Policy_Routing_tab2.asp>D
    <br /> QoS_Diff.asp^D
    <br /> QoS_Tos.asp~D
    <br /> QoS_WL.asp
    <br /> QoS_ata.asp
    <br /> QoS_tab1.asp
    <br /> QoS_tab2.asp
    <br /> RIP.asp
    <br /> RIP_Setting.asp>E
    <br /> RIP_Summary.asp^E
    <br /> RTSP.asp~E
    <br /> Radius.asp
    <br /> Reboot.asp
    <br /> Remote_access.asp
    <br /> Remote_access_edit.asp
    <br /> Reset_button.asp
    <br /> Restore.asp>F
    <br /> Routing_tab1.asp^F
    <br /> Routing_tab2.asp~F
    <br /> Routing_tab2_qs.asp
    <br /> Routing_tab3.asp
    <br /> Routing_tab4.asp
    <br /> SES_Status.asp
    <br /> SNMP.asp
    <br /> SingleForward_tab1.asp>G
    <br /> SingleForward_tab2.asp^G
    <br /> Status_Firewall.asp
    <br /> Status_Iface.asp
    <br /> Status_Lan.asp
    <br /> Status_QoS.asp
    <br /> Status_Router.asp>H
    <br /> Status_WAN_INFO.asp^H
    <br /> Status_arp.asp~H
    <br /> Status_dhcppool.asp
    <br /> Status_igmp.asp
    <br /> Status_mibs.asp
    <br /> Status_rip.asp
    <br /> Status_route.asp
    <br /> Success.asp>I
    <br /> Success_lic.asp^I
    <br /> Success_r_s.asp~I
    <br /> Success_s.asp
    <br /> Success_u.asp
    <br /> Success_u_s.asp
    <br /> TAIL.asp
    <br /> TAIL_voice.asp>J
    <br /> TR.asp^J
    <br /> TR_qs.asp~J
    <br /> Traceroute.asp
    <br /> Triggering.asp
    <br /> Triggering_tab1.asp
    <br /> Triggering_tab2.asp
    <br /> Upgrade.asp
    <br /> Upgrade_run.asp>K
    <br /> User.asp^K
    <br /> User_Level.asp~K
    <br /> User_summary.asp
    <br /> VPN.asp
    <br /> WanMAC.asp
    <br /> about.asp
    <br /> access_deny.asp
    <br /> cdp_lldp.asp^L
    <br /> config_mng.asp
    <br /> dhcp_pool.asp^M
    <br /> dhcp_pool_edit.asp~M
    <br /> dhcp_pool_edit_qs.asp
    <br /> dhcp_pool_edit_u.asp
    <br /> dmz_soft_setting.asp
    <br /> dmz_soft_summary.asp
    <br /> donothing_vlan.asp^1
    <br /> filelink.asp
    <br /> filelink_iframe.asp
    <br /> fortest.asp
    <br /> get_act_wan.asp
    <br /> get_arp_info.asp:R
    <br /> get_cpu_memory_info.aspZR
    <br /> get_dhcppool_info.aspzR
    <br /> get_firewall_info.asp
    <br /> get_iface_info.asp
    <br /> get_log_record.asp
    <br /> get_log_record_ajax.asp
    <br /> get_qos_info.asp
    <br /> get_tftp_status.asp:S
    <br /> getconnect.aspZS
    <br /> getconnst.aspzS
    <br /> header_TOP.asp
    <br /> header_TOP_voice.asp
    <br /> index.asp
    <br /> index_dhcp.asp
    <br /> index_pppoe.asp
    <br /> index_pptp.asp
    <br /> index_static.asp6\
    <br /> index_tab3.aspV\
    <br /> lan_phy_setting.asp
    <br /> license.asp
    <br /> license_credential.asp
    <br /> license_install.asp
    <br /> license_resend.asp6]
    <br /> license_user.aspV]
    <br /> login.aspv]
    <br /> logout.asp
    <br /> mac_address_clone.asp
    <br /> mac_clone.asp
    <br /> menu_linksys.asp
    <br /> menu_unlink.asp6^
    <br /> mibs_obj.asp#
    <br /> phy_setting.asp
    <br /> ping_continue.asp
    <br /> ping_log.asp
    <br /> port_setting.asp
    <br /> position_url.aspRA
    <br /> privilegectl.asprA
    <br /> quick_setup.asp
    <br /> quicksetup.asp
    <br /> quicksetupst.asp
    <br /> setupwizard.asp
    <br /> status_Guestnet.asp
    <br /> status_wireless.asp
    <br /> tftp.aspv]
    <br /> traceroute_continue.asp
    <br /> traceroute_log.asp
    <br /> tree.asp
    <br /> tree_tab.asp
    <br /> voice.asp6^
    <br /> voice_qs.aspV^
    <br /> voicest.aspv^
    <br /> wan_option.asp
    <br /> wan_sub.asp
    <br /> wan_sub_qs.asp
    <br /> wan_sub_u.asp
    <br /> wan_vlan.asp
  </code>
</pre>

I noticed `Diagnostics_tab1.asp and Diagnostics_tab2.asp` right away! And luckily enought that is our ticket.
They give us a working traceroute+ping. You just access them like
`http://HOST/Diagnostics_tab1.asp;session_id=X`

##Diagnostics_tab1.asp
<img class="centered-image" src="../img/blog/exploring-spa112/diagnostics1.png" />

##Diagnostics_tab2.asp
<img class="centered-image" src="../img/blog/exploring-spa112/diagnostics2.png" />


#Digging Even Further

So I have solved the problem at hand, but let us see if we can dig even further. I would really like to get
a shell! binwalk says there are some squashfs images in the bin, I am going to see if I can build my own firmware with
shell access.

So using binwalk, I was able to extract the firmware running

`binwalk -eM Payton_1.3.5_004p_102814_1321_pfmwr_bootldr.bin`

and I found a squashfs image that is 8410145 bytes, this looks promising! However I ran into some trouble extracting it.
I noticed that the 'magic number' for the file was `shsq` and after some googling I found this [patch](http://sourceforge.net/p/squashfs/patches/20/)

I am currently using an OSX desktop and pulled it in via Homebrew, with the following [recipe](https://gist.github.com/Sean-Der/455a329c6c5b6d4f112e) that includes
the linked patch. I am looking through the dump right now to see if I can find something that already evals input etc..
