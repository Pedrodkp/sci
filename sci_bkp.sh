cd /tmp
rm sci_development.sql
mysqldump -u root sci_development > sci_development.sql
rm sci.zip
rm -rf /sci/log/*
zip -r sci.zip /sci
