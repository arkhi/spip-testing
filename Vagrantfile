# Install the working environment based on fine grained provisioners.

Vagrant.configure("2") do |config|
  config.vm.define "spip-testing"

  config.vm.box = "bento/ubuntu-18.04"
  config.vm.host_name = "localhost"
  config.vm.hostname = "spip-testing"

  config.ssh.forward_agent = true

  config.vm.network "private_network", ip: "192.168.50.4"
  config.vm.synced_folder "./", "/vagrant",
    id: "vagrant-root",
    owner: "vagrant",
    group: "www-data",
    mount_options: ["dmode=755", "fmode=644"],
    nfs: false

  config.vm.provider :virtualbox do |vb|
    vb.name = "spip-testing"
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

  # Provision with root user.
  # ===========================================================================
  config.vm.provision 'os',
    type: :shell,
    path: "vagrant/root-os.sh"

  # Provision with vagrant user.
  # ===========================================================================
  config.vm.provision 'spip',
    type: :shell,
    privileged: false,
    path: "vagrant/user-spip.sh"

  # Finishing up
  # ===========================================================================
  # Clean the machine of unnecessary clutter.
  config.vm.provision 'clean',
    type: :shell,
    inline: <<-SHELL
      echo "
      `date '+%H:%M'`: Cleaning up the machine…
      ========================================================================"

      apt-get autoremove -y
      apt-get autoclean -y
      apt-get clean -y
    SHELL

  # Ding!
  # And whatever one likes to happen at the end of every `vagrant up`.
  config.vm.provision 'done',
    type: :shell,
    run: "always",
    inline: <<-SHELL
    echo -e "
    `date '+%H:%M'`: Done! \a
    You can access the box with http://192.168.50.4/.

    NB: From time to time, it wouldn’t hurt to do a \\\`vagrant ssh\\\`,
        then \\\`sudo apt upgrade\\\` to upgrade all
    packages.
    =========================================================================="
    SHELL
end

