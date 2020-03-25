# Practica 2
## Instalación de máquinas virtuales mediante Vagrant.

```sh
$script = <<-SHELL
  apt-get update
  apt-get install -y nmap
  echo "192.168.2.101 vm1\n192.168.2.102 vm2\n192.168.2.103 vm3" >> /etc/hosts
SHELL

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.provision "shell", inline: $script
  (1..3).each do |i|
    config.vm.define "vm#{i}" do |node|
      node.vm.hostname = "vm#{i}"
      node.vm.network "private_network", ip: "192.168.2.10#{i}"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "vm#{i}"
        vb.memory = 512
        vb.cpus = 1
        vb.gui = false
      end
    end
  end
end
```

## Visibilidad de las máquinas 

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
