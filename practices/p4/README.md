## Autores:
   * Felix Rodriguez Pericacho
   * Carlos Rodrigo Sanabria Flores

## Instalación de la máquina 

Mediante el Vagrantfile iniciaremos la maquina, con su ip privada (192.168.10.2), con apache y php ya instalado:

```rb
Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network", ip: "192.168.10.2"

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y apache2 libapache2-mod-php php apache2-utils
  SHELL
end
```
## Configuración básica de apache 

### manolorg.uca.es

Primero creamos el /var/www/manolorg.

![Captura 1](./img/Captura.PNG)

A continuacion configuramos manolorg.uca.es.conf

![Captura 2](./img/Captura2.PNG)

### manolorg.uca.es/docs

Creamos la dirección /docs mediante:

```rb
sudo mkdir docs
```

A continuacion volvemos a configurar manolorg.uca.es.conf:

![Captura 2](./img/Captura4.PNG)

### manolorg.uca.es/software

Creamos la dirección /software mediante:

```rb
sudo mkdir software
```

A continuacion volvemos a configurar manolorg.uca.es.conf:

![Captura 2](./img/Captura3.PNG)

### manolorg.uca.es/sci2s

Creamos la dirección /sci2s mediante:

```rb
sudo mkdir sci2s
```

A continuacion volvemos a configurar manolorg.uca.es.conf:

![Captura 2](./img/Captura5.PNG)

### /var/www/lab1

```rb
sudo mkdir /var/www/lab1
```

A continuacion configuramos lab1.manolorg.conf:

![Captura 2](./img/Captura6.PNG)

Y activamos lab1.manolorg mediante:

```rb
sudo a2ensite lab1.manolorg.conf
```

### /var/www/lab2

```rb
sudo mkdir /var/www/lab2
```

A continuacion configuramos lab2.manolorg.conf:

![Captura 2](./img/Captura7.PNG)

Y activamos lab2.manolorg mediante:

```rb
sudo a2ensite lab2.manolorg.conf
```

Dejandonos con la siguiente web:

![Captura 2](./img/Captura8.PNG)
![Captura 2](./img/Captura9.PNG)
![Captura 2](./img/Captura10.PNG)

## Caché

## Redirección

## Balanceo de carga