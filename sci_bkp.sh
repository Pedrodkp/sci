#crontab sci bkp
#00-59/5 * * * * /sci/sci_bkp.sh >> /tmp/sci_bkp.log 2>&1

#comandos
cd /tmp
rm sci_development.sql
mysqldump -u root sci_development > sci_development.sql
rm sci.zip
rm -rf /sci/log/*
zip -r sci.zip /sci
