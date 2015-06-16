#OIM/OAM with WebTier/WebGate vagrant box

##Todo
2.6.1 Registering the New Oracle HTTP Server 11g WebGate http://docs.oracle.com/cd/E40329_01/doc.1112/e49451/webgate_ohs.htm#autoId14


##Details
- OEL 6.6 vagrant box
- Puppet 3.7.4
- Vagrant >= 1.72
- Oracle Virtualbox >= 4.3.20 or VMware fusion >= 6

Add the all the Oracle binaries to the vagrant folder or make links inside this folder

edit Vagrantfile and update the software share
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

## Middleware

### WebLogic Server
- oim1admin 10.10.10.61, WebLogic 10.3.6 met OIM,OAM,SOA Suite

## Software

### JDK
- UnlimitedJCEPolicyJDK7.zip
- jdk-7u80-linux-x64.tar.gz

### WebLogic
- wls1036_generic.jar

### BSU patch
- p20181997_1036_Generic.zip

### FMW
- ofm_iam_generic_11.1.2.3.0_disk1_1of3.zip
- ofm_iam_generic_11.1.2.3.0_disk1_2of3.zip
- ofm_iam_generic_11.1.2.3.0_disk1_3of3.zip
- ofm_webtier_linux_11.1.1.9.0_64_disk1_1of1.zip
- ofm_webgates_generic_11.1.2.3.0_disk1_1of1.zip
- V75849-01_1of2.zip soa suite 11.1.1.9.0 from edelivery
- V75849-01_2of2.zip soa suite 11.1.1.9.0 from edelivery

### FMW OUD
- V75962-01.zip Oracle Application Development Runtime 11g Patch Set 7 (11.1.1.9.0) from edelivery
- ofm_oud_generic_11.1.2.3.0_disk1_1of1.zip

