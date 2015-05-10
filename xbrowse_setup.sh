# Source: https://github.com/macarthur-lab/xbrowse/blob/master/deploy/ec2/README-ec2.md
echo "4. create subdirectories"
cd /mnt
mkdir -p code/xbrowse-settings data/reference_data data/projects mongodb

echo "5. Clone xbrowse"
cd /mnt/code
git clone https://github.com/xbrowse/xbrowse.git

echo "6. Download necessary reference data from xBrowse and external sources."

cd /mnt/data/reference_data
#TODO FIX
#wget ftp://atguftp.mgh.harvard.edu/xbrowse-resource-bundle.tar.gz; tar -xzf xbrowse-resource-bundle.tar.gz
#wget ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b142_GRCh37p13/VCF/00-All.vcf.gz
#wget ftp://dbnsfp:dbnsfp@dbnsfp.softgenetics.com/dbNSFPv2.9.zip; unzip -d dbNSFP dbNSFPv2.9.zip
#wget ftp://ftp.ncbi.nih.gov/pub/clinvar/vcf_GRCh37/clinvar.vcf.gz*
#wget ftp://ftp.broadinstitute.org/pub/ExAC_release/release0.3/ExAC.r0.3.sites.vep.vcf.gz

cd /mnt/data/projects
#wget ftp://atguftp.mgh.harvard.edu/1kg_project.tar.gz; tar -xzf 1kg_project.tar.gz

echo "7. Run Puppet to provision this machine for xBrowse. This takes a while (~2 hours) and performs a bulk of the provisioning."
puppet apply /mnt/code/xbrowse/deploy/ec2/ec2_provision.pp --modulepath=/mnt/code/xbrowse/deploy/puppet/modules

echo "8. Install Perl dependencies"
curl -L http://cpanmin.us | perl - --sudo App::cpanminus
cpanm Archive::Extract CGI Time::HiRes Archive::Zip Archive::Tar

echo "9. VEP setup"
cd /mnt
wget https://github.com/Ensembl/ensembl-tools/archive/release/78.zip
unzip 78.zip
mv ensembl-tools-release-78/scripts/variant_effect_predictor .
rm -rf 78.zip ensembl-tools-release-78
cd variant_effect_predictor
perl INSTALL.pl --AUTO acf --CACHEDIR ../vep_cache_dir --SPECIES homo_sapiens --ASSEMBLY GRCh37 --CONVERT

echo "10. Set pythonpath"
export PYTHONPATH=/mnt/code/xbrowse:/mnt/code/xbrowse-settings:$PYTHONPATH

echo "12. initialize database"
cd /mnt/code/xbrowse
python2.7 manage.py migrate
echo "12. Load reference data"
python2.7 manage.py load_resources
echo "13. Create superuser"
python2.7 manage.py createsuperuser


