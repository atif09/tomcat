# Class: tomcat
# ===========================
#
# Full description of class tomcat here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'tomcat':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name Mohammed Jawad Hussain 
#
# Copyright
# ---------
# Copyright 2018 Mohammed Jawad Hussain 
#
class tomcat {
   file {'/tmp/jdk-8u161-linux-x64.rpm':
        source => 'puppet:///modules/tomcat/jdk-8u161-linux-x64.rpm',
       }
   package {'jdk-8u161-linux-x64.rpm':
        ensure => 'present',
        provider => 'rpm',
        source => '/tmp/jdk-8u161-linux-x64.rpm',
       }
   user {'tom':
        ensure => 'present',
        home => '/home/tom',
        shell => '/bin/bash',
       }
   file {'/home/tom':
        ensure => 'directory',
        owner => 'tom',
        group => 'tom',
        mode => '0755',
        recurse => 'true',
        source => 'puppet:///modules/tomcat/apache-tomcat-6.0.44',
       }
   exec {'/home/tom/bin/startup.sh':
       user => 'tom',
       path => '/usr/java/jdk1.8.0_161/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin:/root/bin:/root/bin:/home/tom/bin',
       unless => 'ps -ef|grep -i catalina|grep -v grep',
       } 
}
