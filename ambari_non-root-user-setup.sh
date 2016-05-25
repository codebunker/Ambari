#!/bin/bash
#Define Ambari non root user, example here considers ambari-qa as non-root user
non_root_user=ambari-qa
#Edit /etc/ambari-agent/conf/ambari-agent.ini file to change < user
sed -i -e 's/run_as_user=root/run_as_user=$non_root_user/' /etc/ambari-agent/conf/ambari-agent.ini
# Script to configure sudoers permission for Ambari non-root-user. Run me with root user or superuser privileges
echo '' >> /etc/sudoers
echo 'Adding entries to configure ambari service to run as non-root user' >> /etc/sudoers
echo '# Ambari Customizable Users' >> /etc/sudoers
echo '$non_root_user ALL=(ALL) NOPASSWD:SETENV: /bin/su hdfs *,/bin/su ambari_server_qa *,/bin/su ranger_qa *,/bin/su zookeeper_qa *,/bin/su knox_qa *,/bin/su falcon_qa *,/bin/su ams_qa *, /bin/su flume_qa *,/bin/su hbase_qa *,/bin/su spark_qa *,/bin/su hive_qa *,/bin/su hcat_qa *,/bin/su kafka_qa *,/bin/su mapred_qa *,/bin/su oozie_qa *,/bin/su sqoop_qa *,/bin/su storm_qa *,/bin/su tez_qa *,/bin/su atlas_qa *,/bin/su yarn_qa *,/bin/su kms_qa *,/bin/su accumulo_qa *' >> /etc/sudoers
echo '' >> /etc/sudoers
echo '# Ambari Non-Customizable Users' >> /etc/sudoers
echo '$non_root_user ALL=(ALL) NOPASSWD:SETENV: /bin/su mysql *' >> /etc/sudoers
echo '' >> /etc/sudoers
echo '# Ambari Commands' >> /etc/sudoers
echo '$non_root_user ALL=(ALL) NOPASSWD:SETENV: /usr/bin/yum,/usr/bin/zypper,/usr/bin/apt-get, /bin/mkdir, /usr/bin/test, /bin/ln, /bin/chown, /bin/chmod, /bin/chgrp, /usr/sbin/groupadd, /usr/sbin/groupmod, /usr/sbin/useradd, /usr/sbin/usermod, /bin/cp, /usr/sbin/setenforce, /usr/bin/test, /usr/bin/stat, /bin/mv, /bin/sed, /bin/rm, /bin/kill, /bin/readlink, /usr/bin/pgrep, /bin/cat, /usr/bin/unzip, /bin/tar, /usr/bin/tee, /bin/touch, /usr/bin/hdp-select, /usr/bin/conf-select, /usr/hdp/current/hadoop-client/sbin/hadoop-daemon.sh, /usr/lib/hadoop/bin/hadoop-daemon.sh, /usr/lib/hadoop/sbin/hadoop-daemon.sh, /sbin/chkconfig gmond off, /sbin/chkconfig gmetad off, /etc/init.d/httpd *, /sbin/service hdp-gmetad start, /sbin/service hdp-gmond start, /usr/sbin/gmond, /usr/sbin/update-rc.d ganglia-monitor *, /usr/sbin/update-rc.d gmetad *, /etc/init.d/apache2 *, /usr/sbin/service hdp-gmond *, /usr/sbin/service hdp-gmetad *, /sbin/service mysqld *, /usr/bin/python2.6 /var/lib/ambari-agent/data/tmp/validateKnoxStatus.py *, /usr/hdp/current/knox-server/bin/knoxcli.sh *' >> /etc/sudoers
echo '' >> /etc/sudoers
echo '# Ambari Ranger Commands' >> /etc/sudoers
echo '$non_root_user ALL=(ALL) NOPASSWD:SETENV: /usr/hdp/*/ranger-usersync/setup.sh, /usr/bin/ranger-usersync-stop, /usr/bin/ranger-usersync-start, /usr/hdp/*/ranger-admin/setup.sh *, /usr/hdp/*/ranger-knox-plugin/disable-knox-plugin.sh *, /usr/hdp/*/ranger-storm-plugin/disable-storm-plugin.sh *, /usr/hdp/*/ranger-hbase_qa-plugin/disable-hbase-plugin.sh *, /usr/hdp/*/ranger-hdfs-plugin/disable-hdfs-plugin.sh *,  /usr/hdp/current/ranger-admin/ranger_credential_helper.py, /usr/hdp/current/ranger-kms/ranger_credential_helper.py' >> /etc/sudoers
echo '' >> /etc/sudoers
echo '####Sudo Defaults' >> /etc/sudoers
echo 'Defaults exempt_group=$non_root_user' >> /etc/sudoers
echo 'Defaults !env_reset,env_delete-=PATH' >> /etc/sudoers
echo 'Defaults:$non_root_user !requiretty' >> /etc/sudoers
