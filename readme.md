#OIM/OAM with WebTier/WebGate vagrant box

Oracle access & identity manager 11.1.2.3

##Todo
2.6.1 Registering the New Oracle HTTP Server 11g WebGate http://docs.oracle.com/cd/E40329_01/doc.1112/e49451/webgate_ohs.htm#autoId14


##Details
- OEL 6.6 vagrant box
- Puppet 3.8
- Vagrant >= 1.8
- Oracle Virtualbox >= 5.0 or VMware fusion >= 6

Add all the Oracle binaries to the vagrant folder or make links to these files inside this folder

Or pptional edit the Vagrantfile and add the software share plus update all puppet files ( change /vagrant to /software )
- oim1admin.vm.synced_folder "/Users/edwin/software", "/software"
- oimdb.vm.synced_folder "/Users/edwin/software", "/software"
- oimoud.vm.synced_folder "/Users/edwin/software", "/software"

Vagrant boxes
- vagrant up oimdb
- vagrant up oim1admin
- vagrant up oimoud

## Databases
- oimdb 10.10.10.9, 11.2.0.4 met OIM/OAM RCU

### software
- Oracle Database 11.2.0.4 Linux
- 1395582860 Aug 31 16:21 p13390677_112040_Linux-x86-64_1of7.zip
- 1151304589 Aug 31 16:22 p13390677_112040_Linux-x86-64_2of7.zip
- OPatch upgrade p6880880_112000_Linux-x86-64.zip
- RCU ofm_rcu_linux_11.1.1.9.0_64_disk1_1of1.zip

## OIM/OAM Middleware

##Uris
- oim1admin 10.10.10.61 port 7001 weblogic/weblogic1, WebLogic 10.3.6 with OIM,OAM,SOA Suite
- http://10.10.10.61:14000/oim/faces/faces/pages/Admin.jspx with xelsysadm/Welcome01
- http://10.10.10.61:14000/admin/faces/pages/Admin.jspx
- http://10.10.10.61:8001/soa-infra with weblogic/weblogic1
- http://10.10.10.61:8001/integration/worklistapp with weblogic/weblogic1
- http://10.10.10.61:7001/oamconsole
- http://10.10.10.61:9704/xmlpserver with xelsysadm/Welcome01

## Software

### JDK
- UnlimitedJCEPolicyJDK7.zip
- jdk-7u80-linux-x64.tar.gz

### WebLogic
- wls1036_generic.jar

#### BSU patch
- S8C2 p21984589_1036_Generic.zip

### FMW
- ofm_iam_generic_11.1.2.3.0_disk1_1of3.zip
- ofm_iam_generic_11.1.2.3.0_disk1_2of3.zip
- ofm_iam_generic_11.1.2.3.0_disk1_3of3.zip
- ofm_webtier_linux_11.1.1.9.0_64_disk1_1of1.zip
- ofm_webgates_generic_11.1.2.3.0_disk1_1of1.zip
- V75849-01_1of2.zip soa suite 11.1.1.9.0 from edelivery
- V75849-01_2of2.zip soa suite 11.1.1.9.0 from edelivery

## OUD Middleware Oracle Unified Directory

### url
- http://10.10.10.71:7001/odsm/faces/odsm.jspx
- Administration Connector 0.0.0.0 port 4444
- LDAP Connection Handler 0.0.0.0 port 1389
- LDAP Connection Handler 0.0.0.0 port 1636
- home /opt/oracle/middleware11g/Oracle_OUD1/

### WebLogic Server
- oimoud 10.10.10.71 port 7001 weblogic/weblogic1, WebLogic 10.3.6 with OUD

## Software

### JDK
- UnlimitedJCEPolicyJDK7.zip
- jdk-7u80-linux-x64.tar.gz

### WebLogic
- wls1036_generic.jar

### BSU patch
- p20181997_1036_Generic.zip

### FMW OUD
- V75962-01.zip Oracle Application Development Runtime 11g Patch Set 7 (11.1.1.9.0) from edelivery
- ofm_oud_generic_11.1.2.3.0_disk1_1of1.zip

