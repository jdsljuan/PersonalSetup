# **Guia de Instalacion del Stack LAMP en Fedora**

Los siguientes comandos han sido provados en las versiones 33, 34, 35 y 36 de Fedora.
Primero y antes de empezar a instalar los paquetes que componen la Pila vamos a instalar los siguientes programas.

> sudo dnf install -y micro bash-completion 

##  **Desactivar SELinux**

Verificamos el estado actual de los permisos del Gestor SELinux tecleando:

> sudo sestatus

si esta encendido lo podemos cambiar a un de los siguientes estados

### ***SELinux Modo Permisivo***

>sudo setenforce 0

>sudo sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

### ***SELinux Modo Desactivado***

>sudo setenforce 0

>sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config


De ahora en adelante solo es instalar y encender servicios, para configuraciones mas avanzadas usar los archivos configuracion que se indican con el comando micro.

## **Instalar y Configurar Apache Server**

>sudo dnf -y install httpd

>micro /etc/httpd/conf/httpd.conf

>sudo systemctl start httpd

>sudo systemctl enable httpd

### ***Añadir los Servicios Apache a las Restricciones del Firewall***

>sudo firewall-cmd --add-service={http,https} --permanent

>sudo firewall-cmd --reload

## **Instalar y Configurar PHP **

>sudo dnf -y install php php-cli php-php-gettext php-mbstring php-mcrypt php-mysqlnd php-pear php-curl php-gd php-xml php-bcmath php-zip

>micro /etc/php.ini

## **Instalar y Configurar MySQL Server**

>sudo dnf install mariadb-server

>sudo systemctl start mariadb

>sudo systemctl enable mariadb

>sudo mysql_secure_installation 


### ***Añadir los Servicios MySQL a las Restricciones del Firewall***

>sudo firewall-cmd --add-service=mysql --permanent

>sudo firewall-cmd --reload

