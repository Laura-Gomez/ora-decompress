sudo apt-get update
sudo apt-get install mailutils

#Durante la instalación de mailutils, el sistema te pedirá seleccionar la configuración de postfix.
#Selecciona la opción “Sitio de Internet” para que postfix funcione como un cliente SMTP.


sudo nano /etc/postfix/main.cf

# Agrega las siguientes líneas al final del archivo para configurar el servidor SMTP:


relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
smtp_use_tls = yes


# configurar contraseña
sudo nano /etc/postfix/sasl_passwd

#en el sig formato
#[smtp.gmail.com]:587 tu_usuario@gmail.com:tu_contraseña

# Protege el archivo de contraseñas cambiando sus permisos:
sudo chmod 600 /etc/postfix/sasl_passwd


# Genera el archivo de formato postfix para el archivo de contraseñas:
sudo postmap /etc/postfix/sasl_passwd

cat /etc/ssl/certs/thawte_Primary_Root_CA.pem | sudo tee -a /etc/postfix/cacert.pem

 echo "Este es un mensaje de prueba" | mail -s "Asunto de prueba" lgomez@inmegen.gob.mx
