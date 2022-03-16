# SNMP Trap ( Simple Network Management Protocol )
 - Trap OID
   - [Linux Standerd Trap](#anchor1a)
   - [Cisco Trap](#anchor1b)
   - [FortiOS Trap](#anchor1c)
   - [FortiAP Trap](#anchor1d)
   - [Soliton NetAttestEPS](#anchor1e)

## Trap OID
 - [FortiGate](https://bestmonitoringtools.com/mibdb/mibdb_search.php?mib=FORTINET-FORTIGATE-MIB)
 - [FortiOS](https://www.oidview.com/mibs/12356/FORTINET-FORTIGATE-MIB.html)

<a id="anchor1a"></a>

### Linux Standerd Trap
 - SNMPv2-MIB ( 1.3.6.1.6 ) RFC 1157

|OID Name|OID|Description|
|---|---|---|
|coldStart|.1.3.6.1.6.3.1.1.5.1|エージェント起動|
|warmStart|.1.3.6.1.6.3.1.1.5.2|再起動コマンドによる再起動|
|SNMPLinkDown|.1.3.6.1.6.3.1.1.5.3|インターフェースが Down 状態に変化|
|SNMPLinkUp|.1.3.6.1.6.3.1.1.5.4|インターフェースが Up 状態に変化|
|authenticationFailure|.1.3.6.1.6.3.1.1.5.5|不正なコミュニティ名の SNMP ポーリングを受信|
|nsNotifyShutdown|.1.3.6.1.4.1.8072.4.0.2|エージェント停止|

<a id="anchor1b"></a>

### Cisco Trap
 - ISR , Catalyst
 - SNMPv2-MIB ( 1.3.6.1.6 )
 - MIB-2 ( 1.3.6.1.2.1 )

|OID Name|OID|Description|
|---|---|---|
|ciscoEnvMonVoltageNotification|.1.3.6.1.4.1.9.9.13.3.0.2|電圧異常|
|ciscoEnvMonTemperatureNotification|.1.3.6.1.4.1.9.9.13.3.0.3|温度異常|
|ciscoEnvMonFanNotification|.1.3.6.1.4.1.9.9.13.3.0.4|ファン異常|
|ciscoEnvMonRedundantSupplyNotification|.1.3.6.1.4.1.9.9.13.3.0.5|冗長電源ユニット異常|
|cHsrpStateChange|1.3.6.1.4.1.9.9.106.2.0.1|HSRP 状態変化|
|cswStackPortChange|1.3.6.1.4.1.9.9.500.0.0.1|スタックポートの状態変化|
|cswStackPowerPortLinkStatusChanged|1.3.6.1.4.1.9.9.500.0.0.7|スタック電源ポートの状態変化|

<a id="anchor1c"></a>

### FortiOS Trap

|OID Name|OID|Description|
|---|---|---|
|fgTrapVpnTunUp fgTrapVpnTunUp|1.3.6.1.4.1.12356.101.2.0.301|Indicates that the specified VPN tunnel has been brought up.|
|fgTrapVpnTunDown|1.3.6.1.4.1.12356.101.2.0.302|The specified VPN tunnel has been brought down.|
|fgTrapHaSwitch|1.3.6.1.4.1.12356.101.2.0.401|The specified cluster member has transitioned from a slave role to a master role.|
|fgTrapHaStateChange|1.3.6.1.4.1.12356.101.2.0.402|Trap being sent when the HA cluster member changes its state.|
|fgTrapHaHBFail|1.3.6.1.4.1.12356.101.2.0.403|The heartbeat device failure count has exceeded the configured threshold.|
|fgTrapHaMemberDown|1.3.6.1.4.1.12356.101.2.0.404|The specified device (by serial number) is moving to a down state.|
|fgTrapHaMemberUp|1.3.6.1.4.1.12356.101.2.0.405|A new cluster member has joined the cluster.|
|fgTrapIpsSignature|1.3.6.1.4.1.12356.101.2.0.503|An IPS signature has been triggered.|
|fgTrapIpsAnomaly|1.3.6.1.4.1.12356.101.2.0.504|An IPS anomaly has been detected.|
|fgTrapIpsPkgUpdate|1.3.6.1.4.1.12356.101.2.0.505|The IPS signature database has been updated.|
|fgTrapIpsFailOpen|1.3.6.1.4.1.12356.101.2.0.506|The IPS network buffer is full.|
|fgTrapAvVirus|1.3.6.1.4.1.12356.101.2.0.601|A virus has been detected by the antivirus engine.|
|fgTrapAvOversize|1.3.6.1.4.1.12356.101.2.0.602|An oversized file has been detected by the antivirus engine.|
|fgTrapAvPattern|1.3.6.1.4.1.12356.101.2.0.603|The antivirus engine has blocked a file because it matched a configured pattern.|
|fgTrapAvFragmented|1.3.6.1.4.1.12356.101.2.0.604|The antivirus engine has detected a fragmented file.|
|fgTrapAvEnterConserve|1.3.6.1.4.1.12356.101.2.0.605|The antivirus engine has entered conservation mode due to low memory conditions.|
|fgTrapAvBypass|1.3.6.1.4.1.12356.101.2.0.606|The antivirus engine has been bypassed due to conservation mode.|
|fgTrapAvOversizePass|1.3.6.1.4.1.12356.101.2.0.607|An oversized file has been detected, but has been passed due to configuration.|
|fgTrapAvOversizeBlock|1.3.6.1.4.1.12356.101.2.0.608|An oversized file has been detected and has been blocked.|
|fgTrapFazDisconnect|1.3.6.1.4.1.12356.101.2.0.701|The device has been disconnected from the FortiAnalyzer.|
|fgTrapWcApUp|1.3.6.1.4.1.12356.101.2.0.801|Indicates that the specified AP is up.|
|fgTrapWcApDown|1.3.6.1.4.1.12356.101.2.0.802|Indicates that the specified AP is down.|
|fgTrapFcSwUp|1.3.6.1.4.1.12356.101.2.0.901|Indicates that the specified switch controller session is up.|
|fgTrapFcSwDown|1.3.6.1.4.1.12356.101.2.0.902|Indicates that the specified switch controller session is down.|
|fgTrapServerLoadBalance RealServerDown|.1.3.6.1.4.1.12356.101.2.0.1101|One of servers in a Server Load Balance group goes down.|
|fgTrapDeviceNew|.1.3.6.1.4.1.12356.101.2.0.1201|A new device is found.|

<a id="anchor1d"></a>

### FortiAP Trap

|OID Name|OID|Description|
|---|---|---|
|fapDevUp|.1.3.6.1.4.1.12356.120.0.1|The specified FortiAP device is up.|
|fapCpuOverload|.1.3.6.1.4.1.12356.120.0.2|The CPU usage of the specified FortiAP has exceeded the configured threshold.|
|fapMemOverload|.1.3.6.1.4.1.12356.120.0.3|The memory usage of the specified FortiAP has exceeded the configured threshold.|
|fapDevDown|.1.3.6.1.4.1.12356.120.0.4|The specified FortiAP device is down.|
|fapAcConnected|.1.3.6.1.4.1.12356.120.0.5|FortiAP has connected to the specified AP controller ( AC ).|

<a id="anchor1e"></a>

### Soliton NetAttestEPS

|OID Name|OID|Description|
|---|---|---|
|snaHwMonTempThOverTrap|.1.3.6.1.4.1.990.2.2.0.2|A temperature sensor on the device has exceeded its threshold. |
|snaHwMonFanThUnderTrap|.1.3.6.1.4.1.990.2.2.0.3|A fan sensor on the device has exceeded its threshold.|
|snaHwMonRPowerFailTrap|.1.3.6.1.4.1.990.2.2.0.4|Power supply failure detected.|
