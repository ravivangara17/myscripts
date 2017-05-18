include_pack "base"

name "stream_splitter"
description "stream_splitter"
type "Platform"
category "Data Transport"

resource "user-app",
         :cookbook => "user",
         :design => true,
         :requires => {"constraint" => "1..1"},
         :attributes => {
             "username" => "app",
             "description" => "App User",
             "home_directory" => "/app",
             "system_account" => true,
             "sudoer" => true
         }

resource "java",
         :cookbook => "java",
         :design => true,
         :requires => {
             :constraint => "1..1",
             :services => "mirror",
             :help => "Java Programming Language Environment"
         },
         :attributes => {
             :install_dir => "/usr/lib/jvm",
             :flavor => "oracle",
             :jrejdk => "server-jre",
             :version => "8",
             :uversion => "",
             :binpath => "",
             :sysdefault => "true"
         }

resource "secgroup",
         :cookbook => "secgroup",
         :design => true,
         :attributes => {
             "inbound" => '[ "22 22 tcp 0.0.0.0/0", "8080 8080 tcp 0.0.0.0/0", "8009 8009 tcp 0.0.0.0/0", "8443 8443 tcp 0.0.0.0/0" ]'
         },
         :requires => {
             :constraint => "1..1",
             :services => "compute"
         }

resource "volume-log",
         :cookbook => "volume",
         :design => true,
         :requires => {"constraint" => "1..1", "services" => "compute"},
         :attributes => {"mount_point" => '/log',
                         "size" => '100%FREE',
                         "device" => '',
                         "fstype" => 'ext4',
                         "options" => ''
         },
         :monitors => {
             'usage' => {'description' => 'Usage',
                         'chart' => {'min' => 0, 'unit' => 'Percent used'},
                         'cmd' => 'check_disk_use!:::node.workorder.rfcCi.ciAttributes.mount_point:::',
                         'cmd_line' => '/opt/nagios/libexec/check_disk_use.sh $ARG1$',
                         'metrics' => {'space_used' => metric(:unit => '%', :description => 'Disk Space Percent Used'),
                                       'inode_used' => metric(:unit => '%', :description => 'Disk Inode Percent Used')},
                         :thresholds => {
                          'LowDiskSpaceCritical' => threshold('1m', 'avg', 'space_used', trigger('>=', 90, 5, 2), reset('<', 85, 5, 1)),
                          'LowDiskInodeCritical' => threshold('1m', 'avg', 'inode_used', trigger('>=', 90, 5, 2), reset('<', 85, 5, 1))
                      },  
             },
         }

resource "volume-app",
         :cookbook => "volume",
         :design => true,
         :requires => {"constraint" => "1..1", "services" => "compute"},
         :attributes => {"mount_point" => '/app',
                         "size" => '10G',
                         "device" => '',
                         "fstype" => 'ext4',
                         "options" => ''
         },
         :monitors => {
             'usage' => {'description' => 'Usage',
                         'chart' => {'min' => 0, 'unit' => 'Percent used'},
                         'cmd' => 'check_disk_use!:::node.workorder.rfcCi.ciAttributes.mount_point:::',
                         'cmd_line' => '/opt/nagios/libexec/check_disk_use.sh $ARG1$',
                         'metrics' => {'space_used' => metric(:unit => '%', :description => 'Disk Space Percent Used'),
                                       'inode_used' => metric(:unit => '%', :description => 'Disk Inode Percent Used')},
                          :thresholds => {
                              'LowDiskSpaceCritical' => threshold('1m', 'avg', 'space_used', trigger('>=', 90, 5, 2), reset('<', 85, 5, 1)),
                              'LowDiskInodeCritical' => threshold('1m', 'avg', 'inode_used', trigger('>=', 90, 5, 2), reset('<', 85, 5, 1))
                            },  
             }
         }

resource "stream_splitter",
         :cookbook => "stream_splitter",
         :source => Chef::Config[:register],
         :design => true,
         :requires => {"constraint" => "1..1"},
         :attributes => {
		"version" => "0.1"
         }

resource "artifact",
  :cookbook => "artifact",
  :design => true,
  :requires => { "constraint" => "0..*" },
  :attributes => {

  }

resource "build",
  :cookbook => "build",
  :design => true,
  :requires => { "constraint" => "0..*" },
  :attributes => {
    "install_dir"   => '/usr/local/build',
    "repository"    => "",
    "remote"        => 'origin',
    "revision"      => 'HEAD',
    "depth"         => 1,
    "submodules"    => 'false',
    "environment"   => '{}',
    "persist"       => '[]',
    "migration_command" => '',
    "restart_command"   => ''
  }

# depends_on
[
  {:from => 'volume-log', :to => 'compute'},
  {:from => 'volume-app', :to => 'compute'},
 {:from => 'user-app',      :to => 'compute'},
{:from => 'user',      :to => 'compute'},
 {:from => 'download-java', :to => 'compute'},
 {:from => 'java', :to => 'download-java'},
 {:from => 'volume-log', :to => 'volume-app'},
 {:from => 'stream_splitter', :to => 'user-app'},
 {:from => 'stream_splitter', :to => 'compute'},
 {:from => 'stream_splitter', :to => 'volume-log'},
 {:from => 'stream_splitter', :to => 'volume-app'},
 {:from => 'stream_splitter', :to => 'java'  },
 {:from => 'build',         :to => 'stream_splitter'},
 {:from => 'artifact',      :to => 'stream_splitter'}].each do |link|
  relation "#{link[:from]}::depends_on::#{link[:to]}",
           :relation_name => 'DependsOn',
           :from_resource => link[:from],
           :to_resource => link[:to],
           :attributes => {"flex" => false, "min" => 1, "max" => 1}
end
