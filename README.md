# Practica 1

## Crear maquina virtual con vagrant

```rb
Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu1804"
  config.vm.network "forwarded_port", guest: 80, host: 80

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y apache2
  SHELL
end
```

## Comandos Basicos
### Mostrar todos los archivos txt del sistema.

```sh
find / -name '*.txt'
```

### Modificar el ejercicio anterior para que no se muestren los errores de acceso

```sh
find / -name '*.txt' 2> /dev/null
```

### Mostrar el número de archivos txt del sistema.

```sh
find / -name '*.txt' 2> /dev/null | wc -l
```

### Mostrar cuantos usuarios no pueden iniciar sesión

```sh
grep 'nologin\|false' /etc/passwd -c
```

### Mostrar el tipo de inicio de sesión de los usuarios

```sh
awk -F':' '{ print $7}' /etc/passwd | sort | uniq -c
```