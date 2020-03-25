# Practica 2
## Instalación de máquinas virtuales mediante Vagrant.

## Desde VM2 comprobar los puertos que VM1 tiene abiertos.

```sh
nmap -p- vm1
```

## Prohibir el acceso por ssh

```sh
sudo iptables -A INPUT -p tcp --dport 22 -j DROP
```

## Configuración minima

```sh
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
sudo iptables -P INPUT DROP
```

## Servidor HTTP/S

```sh
sudo iptables -A INPUT -m state --state NEW -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -m state --state NEW -p tcp --dport 443 -j ACCEPT
```
