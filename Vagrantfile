
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

### Configuration parameters ###
# Virtual machine name
VM_NAME = "vagrant-docker-python3"
# Virtual machine memory (MB)
VM_MEMORY_MB = "2048"
################################

Vagrant.configure("2") do |config|

  # Every Vagrant development environment requires a box.
  config.vm.box = "hashicorp/bionic64"
  # This is the name vagrant outputs on the console and logs.
  config.vm.define VM_NAME
  # This is the hostname inside the VM.
  config.vm.hostname = VM_NAME

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine.
  config.vm.network "forwarded_port", guest: 8888, host: 8888

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "virtualbox" do |vb|
    # This is the name VirtualBox uses for the VM.
    vb.name = VM_NAME
    # Set 2GB of RAM for the VM.
    vb.memory = VM_MEMORY_MB
  end

  # Enable provisioning with Docker and Docker Compose.
  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: "/vagrant/docker-compose.yml", run: "always"
  # Execute tmux shell script
  config.vm.provision "shell", path: "scripts/vagrant/tmux.sh"
  config.vm.provision "shell", path: "scripts/vagrant/motd.sh", run: "always"
  
  # Automatically chdir to /vagrant directory upon `vagrant ssh`
  config.ssh.extra_args = ["-t", "cd /vagrant; bash --login"] # warn: this breaks the ability to use the `vagrant ssh -- <command>` option

end
