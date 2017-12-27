SCI
================

Sistema de Comunicação Inteligente

Problemas
-------------

Precisa de ajuda? infra@ecomex.com.br

Ruby on Rails
-------------

- Ruby 2.2.5
- Rails 4.2.6

Deploy
-------------

Com usuário ecomex (senha com infra@ecomex.com.br) logar na maquina XORN hospedada na NSI.
1) Mudar para usuario root: 
- sudo su -
2) Matar todos os processos usando (kill -9 xxx) que encontrar com:

   ps aux | grep rails
3) Fazer backup da pasta SCI:

   mv sci sci_bkp
4) Copie projeto do GITHUB:

   git clone https://github.com/Pedrodkp/sci.git   
5) Apague pastas e arquivos de imagens e configurações do deploy:
- rm -rf /sci/public/assets
- rm /sci/config/secrets.yml
6)Copie pastas e arquivos de imagens e configurações do backup:

  cp -r /sci_bkp/public/assets /sci/public
  cp -r /sci_bkp/public/ckeditor_assets /sci/public
  cp /sci_bkp/config/secrets.yml /sci/config
7) Entre na pasta do projeto e atualize o DB e gems:

  cd /sci
  bundle install
  bundle exec rake db:migrate
8) Inicie o rails:

  nohup rails s -b 0.0.0.0 -p 80 &

Backup
-------------

Não existe backup por falta de espaço em disco nos servidores NSI.

Criado script (sci_bkp.sh) para backup (DB e APP) rodando no crontab e salvando no /tmp diariamente para comodidade de backup manual.

Projeto
-------------

Controle do projeto:
https://drive.google.com/drive/folders/0B5_vgGrDUC10VHVVMzh6MHlCR3c?usp=sharing

TO-DO
-------------

Este projeto foi interrompido com 50% de conclusão e entregue como está, não haverão melhorias até segunda ordem.

Bugs podem ser tratados por chamado com infra@ecomex.com.br