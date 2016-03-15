node 'oimdb.example.com'  {
  include oradb_os
  include oradb_11g
}

# operating settings for Database & Middleware
class oradb_os {

  class { 'swap_file':
    swapfile     => '/var/swap.1',
    swapfilesize => '8192000000'
  }

  # set the tmpfs
  mount { '/dev/shm':
    ensure      => present,
    atboot      => true,
    device      => 'tmpfs',
    fstype      => 'tmpfs',
    options     => 'size=2000m',
  }

  $host_instances = hiera('hosts', {})
  create_resources('host',$host_instances)

  service { iptables:
    enable    => false,
    ensure    => false,
    hasstatus => true,
  }

  $groups = ['oinstall','dba' ,'oper' ]

  group { $groups :
    ensure      => present,
  }

  user { 'oracle' :
    ensure      => present,
    uid         => 500,
    gid         => 'oinstall',
    groups      => $groups,
    shell       => '/bin/bash',
    password    => '$1$DSJ51vh6$4XzzwyIOk6Bi/54kglGk3.',
    home        => "/home/oracle",
    comment     => "This user oracle was created by Puppet",
    require     => Group[$groups],
    managehome  => true,
  }


  $install = [ 'binutils.x86_64', 'compat-libstdc++-33.x86_64', 'glibc.x86_64','ksh.x86_64','libaio.x86_64',
               'libgcc.x86_64', 'libstdc++.x86_64', 'make.x86_64','compat-libcap1.x86_64', 'gcc.x86_64',
               'gcc-c++.x86_64','glibc-devel.x86_64','libaio-devel.x86_64','libstdc++-devel.x86_64',
               'sysstat.x86_64','unixODBC-devel','glibc.i686','libXext.x86_64','libXtst.x86_64']


  package { $install:
    ensure  => present,
  }

  class { 'limits':
     config => {
                '*'       => { 'nofile'  => { soft => '2048'   , hard => '8192',   },},
                'oracle'  => { 'nofile'  => { soft => '65536'  , hard => '65536',  },
                                'nproc'  => { soft => '2048'   , hard => '16384',  },
                                'stack'  => { soft => '10240'  ,},},
                },
     use_hiera => false,
  }

  sysctl { 'kernel.msgmnb':                 ensure => 'present', permanent => 'yes', value => '65536',}
  sysctl { 'kernel.msgmax':                 ensure => 'present', permanent => 'yes', value => '65536',}
  sysctl { 'kernel.shmmax':                 ensure => 'present', permanent => 'yes', value => '2588483584',}
  sysctl { 'kernel.shmall':                 ensure => 'present', permanent => 'yes', value => '2097152',}
  sysctl { 'fs.file-max':                   ensure => 'present', permanent => 'yes', value => '6815744',}
  sysctl { 'net.ipv4.tcp_keepalive_time':   ensure => 'present', permanent => 'yes', value => '1800',}
  sysctl { 'net.ipv4.tcp_keepalive_intvl':  ensure => 'present', permanent => 'yes', value => '30',}
  sysctl { 'net.ipv4.tcp_keepalive_probes': ensure => 'present', permanent => 'yes', value => '5',}
  sysctl { 'net.ipv4.tcp_fin_timeout':      ensure => 'present', permanent => 'yes', value => '30',}
  sysctl { 'kernel.shmmni':                 ensure => 'present', permanent => 'yes', value => '4096', }
  sysctl { 'fs.aio-max-nr':                 ensure => 'present', permanent => 'yes', value => '1048576',}
  sysctl { 'kernel.sem':                    ensure => 'present', permanent => 'yes', value => '250 32000 100 128',}
  sysctl { 'net.ipv4.ip_local_port_range':  ensure => 'present', permanent => 'yes', value => '9000 65500',}
  sysctl { 'net.core.rmem_default':         ensure => 'present', permanent => 'yes', value => '262144',}
  sysctl { 'net.core.rmem_max':             ensure => 'present', permanent => 'yes', value => '4194304', }
  sysctl { 'net.core.wmem_default':         ensure => 'present', permanent => 'yes', value => '262144',}
  sysctl { 'net.core.wmem_max':             ensure => 'present', permanent => 'yes', value => '1048576',}
}

class oradb_11g {
  require oradb_os

    oradb::installdb{ '11.2_linux-x64':
      version                   => '11.2.0.4',
      file                      => 'p13390677_112040_Linux-x86-64',
      database_type             => 'EE',
      oracle_base               => hiera('oracle_base_dir'),
      oracle_home               => hiera('oracle_home_dir'),
      user_base_dir             => '/home',
      user                      => hiera('oracle_os_user'),
      group                     => 'dba',
      group_install             => 'oinstall',
      group_oper                => 'oper',
      download_dir              => hiera('oracle_download_dir'),
      remote_file               => false,
      puppet_download_mnt_point => hiera('oracle_source'),
    }

    oradb::opatchupgrade{'112000_opatch_upgrade':
        oracle_home               => hiera('oracle_home_dir'),
        patch_file                => 'p6880880_112000_Linux-x86-64.zip',
        csi_number                => undef,
        support_id                => undef,
        opversion                 => '11.2.0.3.6',
        user                      => hiera('oracle_os_user'),
        group                     => hiera('oracle_os_group'),
        download_dir              => hiera('oracle_download_dir'),
        puppet_download_mnt_point => hiera('oracle_source'),
        require                   => Oradb::Installdb['11.2_linux-x64'],
    }

    oradb::net{ 'config net8':
      oracle_home   => hiera('oracle_home_dir'),
      version      => '11.2',
      user         => hiera('oracle_os_user'),
      group        => hiera('oracle_os_group'),
      download_dir  => hiera('oracle_download_dir'),
      require                => Oradb::Opatchupgrade['112000_opatch_upgrade'],
    }

    oradb::listener{'start listener':
      oracle_base   => hiera('oracle_base_dir'),
      oracle_home   => hiera('oracle_home_dir'),
      user         => hiera('oracle_os_user'),
      group        => hiera('oracle_os_group'),
      action       => 'start',
      require      => Oradb::Net['config net8'],
    }

    oradb::database{ 'oraDb':
      oracle_base              => hiera('oracle_base_dir'),
      oracle_home              => hiera('oracle_home_dir'),
      version                  => '11.2',
      user                     => hiera('oracle_os_user'),
      group                    => hiera('oracle_os_group'),
      download_dir             => hiera('oracle_download_dir'),
      action                   => 'create',
      db_name                  => hiera('oracle_database_name'),
      db_domain                => hiera('oracle_database_domain_name'),
      sys_password             => hiera('oracle_database_sys_password'),
      system_password          => hiera('oracle_database_system_password'),
      data_file_destination     => "/oracle/oradata",
      recovery_area_destination => "/oracle/flash_recovery_area",
      character_set            => "AL32UTF8",
      nationalcharacter_set    => "UTF8",
      init_params              => "open_cursors=1000,processes=600,job_queue_processes=4",
      sample_schema            => 'FALSE',
      memory_percentage        => "40",
      memory_total             => "800",
      database_type            => "MULTIPURPOSE",
      require                  => Oradb::Listener['start listener'],
    }

    oradb::dbactions{ 'start oraDb':
      oracle_home              => hiera('oracle_home_dir'),
      user                     => hiera('oracle_os_user'),
      group                    => hiera('oracle_os_group'),
      action                   => 'start',
      db_name                  => hiera('oracle_database_name'),
      require                  => Oradb::Database['oraDb'],
    }

    oradb::autostartdatabase{ 'autostart oracle':
      oracle_home              => hiera('oracle_home_dir'),
      user                     => hiera('oracle_os_user'),
      db_name                  => hiera('oracle_database_name'),
      require                  => Oradb::Dbactions['start oraDb'],
    }

    oradb::rcu{  'DEV_RCU':
      rcu_file                  => 'ofm_rcu_linux_11.1.1.9.0_64_disk1_1of1.zip',
      product                   => hiera('repository_type'),
      version                   => '11.1.1.9',
      user                      => hiera('oracle_os_user'),
      group                     => hiera('oracle_os_group'),
      download_dir              => hiera('oracle_download_dir'),
      action                    => 'create',
      oracle_home               => hiera('oracle_home_dir'),
      db_server                 => hiera('oracle_database_host'),
      db_service                => hiera('oracle_database_service_name'),
      sys_password              => hiera('oracle_database_sys_password'),
      schema_prefix             => hiera('repository_prefix'),
      repos_password            => hiera('repository_password'),
      temp_tablespace           => 'TEMP',
      puppet_download_mnt_point => hiera('oracle_source'),
      remote_file               => true,
      logoutput                 => true,
      require                   => Oradb::Dbactions['start oraDb'],
    }
}

