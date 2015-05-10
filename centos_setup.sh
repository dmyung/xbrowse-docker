# Source: https://github.com/macarthur-lab/xbrowse/blob/master/deploy/ec2/README-ec2.md

yum update -y
yum install git wget unzip -y
#rpm -Uvh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
#rpm -Uvh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
#rpm -Uvh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-11.noarch.rpm
rpm -Uvh http://yum.puppetlabs.com/el/7/products/x86_64/puppetlabs-release-7-11.noarch.rpm
yum -y -q install puppet
