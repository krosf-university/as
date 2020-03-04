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
awk -F':' '{ print $7}' /etc/passwd | sort | uniq -c | sort -nr
```

## Procesos

### Encuentra usando find y perm los programas con el setuid activado.

```sh
find / -xdev \( -perm -4000 \) -type f
```

### Identificar los 3 procesos que se ejecutan con permisos de root que requieren más memoria.

```sh
ps -o comm= -m -u root | head -3
```

### Monitorizar (con watch) la memoria libre. Deberá de mostrarse cada 10 segundos la actual memoria libre (únicamente ese valor, sin ningún texto adicional).

```sh
watch -n 10 "awk -F':' '/MemFree/ { print $2 }' /proc/meminfo"
```

## Gestión de usuarios

### Crear un usuario llamado con nuestras iniciales. El usuario tendrá home, bash y podrá iniciar sesión

```sh
sudo useradd -m -s /bin/bash crsf
```

### Crear un usuario llamado webuser sin bash, ni home y que no pueda iniciar sesión

```sh
sudo useradd -M -s /usr/sbin/nologin webuser
```

### Crear un usuario llamado antonio que se pueda identificar como webuser (usando sudo) pero no como root

```sh
sudo useradd -G root antonio
```

## /proc
