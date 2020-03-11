# Practica 1

## Crear maquina virtual con vagrant

```rb
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
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
awk -F':' '{ print $7 }' /etc/passwd | sort | uniq -c | sort -nr
```

## Procesos

### Encuentra usando find y perm los programas con el setuid activado.

```sh
find / -xdev -perm -4000 -type f 2> /dev/null
```

### Identificar los 3 procesos que se ejecutan con permisos de root que requieren más memoria.

```sh
ps -o comm= -u root -U root --sort -pmem | head -3
```

### Monitorizar (con watch) la memoria libre. Deberá de mostrarse cada 10 segundos la actual memoria libre (únicamente ese valor, sin ningún texto adicional).

```sh
watch -n 10 "awk -F':' '/MemFree/ { print \$2 }' /proc/meminfo"
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

### Identificar tres archivos y explicar su contenido.

- `/proc/modules`
  - Nos informa sobre los módulos del núcleo que han sido cargados hasta el momento
- `/proc/net`
  - Nos informa sobre el estado de los protocolos de red
- `/proc/filesystems`
  - Nos informa sobre los sistemas de archivos que el kernel soporta

### Identificar al menos dos archivos que permitan escritura.

- /proc/sys/kernel/hostname

  - Modifica el hostname

- /proc/sys/net/ipv4/ip_forward
  - Modifica el binario ip_forward

## Bash scripting

### Realizar un programa que permita cambiar el nombre de los archivo de un directorio

```sh
#!/bin/sh

DIRECTORY="${1%/}"
PAD_FORMAT="%05g"

[[ -d $DIRECTORY ]] || { echo "🚨  The argument should be an directory"; exit 2; }

sequence=0

for file in `find $DIRECTORY -type f -maxdepth 1`; do
  filename=$(basename -- "$file")
  extension="${filename##*.}"
  filename="${file%.*}"
  newname="$DIRECTORY/`seq -f $PAD_FORMAT $sequence $sequence`.$extension"
  mv "$file" "$newname"
  let sequence=sequence+1
done

```

### Se pide realizar un programa que realice una copia de los directorios que cuelguen de `/importante/` en `media/backup`

```sh
#!/bin/sh

DIR_PATH="/importante"
DIR_BACKUP="/media/backup"

for dir in `find $DIR_PATH -type d -maxdepth 1 ! -path "."`; do
  dirname=$(basename -- "$dir")
  compressname="$DIR_BACKUP/$dirname`date "+_%Y%m%d"`.tgz"
  tar -czvf $compressname $dir
done
```

### Proponer una modificación al programa anterior, de tal modo de que para cada directorio se guarden sólo los 5 últimos ficheros

```sh
#!/bin/sh

DIR_PATH="/importante"
DIR_BACKUP="/media/backup"

for dir in `find $DIR_PATH -type d -maxdepth 1 ! -path "."`; do
  dirname=$(basename -- "$dir")
  FOUND=`find $DIR_BACKUP -name "$dirname""_*.tgz" | sort`
  COPIES=`echo $FOUND | wc -l`
  [[ COPIES -eq 5 ]] && rm -f `echo $FOUND | head -1`
  compressname="$DIR_BACKUP/$dirname`gdate "+_%Y%m%d" --date="+10 day"`.tgz"
  tar -czvf $compressname $dir
done

```

### Utilizar el crontab para ejecutar el programa de backup cada día a las 5 de la mañana

```sh
echo $(crontab -l ; echo '0 5 * * * /path/to/backup_only_five.sh') | crontab -
```
