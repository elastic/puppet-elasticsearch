require 'spec_helper'

describe 'elasticsearch', :type => 'class' do

  let :params do {
    :config => { 'node' => { 'name' => 'test' }  }
  } end

  context "On Debian OS" do

    let :facts do {
      :operatingsystem => 'Debian'
    } end
   
    # init.pp
    it { should contain_class('elasticsearch::package') }
    it { should contain_class('elasticsearch::config') }
    it { should contain_class('elasticsearch::service') }

    # package.pp
    it { should contain_package('elasticsearch') }

    # service.pp
    it { should contain_service('elasticsearch') }

    # config.pp

  end

  context "On Ubuntu OS" do

    let :facts do {
      :operatingsystem => 'Ubuntu'
    } end

    # init.pp
    it { should contain_class('elasticsearch::package') }
    it { should contain_class('elasticsearch::config') }
    it { should contain_class('elasticsearch::service') }

    # package.pp
    it { should contain_package('elasticsearch') }

    # service.pp
    it { should contain_service('elasticsearch') }

    # config.pp
  
  end

  context "On CentOS OS" do

    let :facts do {
      :operatingsystem => 'CentOS'
    } end

    # init.pp
    it { should contain_class('elasticsearch::package') }
    it { should contain_class('elasticsearch::config') }
    it { should contain_class('elasticsearch::service') }

    # package.pp
    it { should contain_package('elasticsearch') }

    # service.pp
    it { should contain_service('elasticsearch') }

    # config.pp
   
  end

  context "On RedHat OS" do

    let :facts do {
      :operatingsystem => 'Redhat'
    } end

    # init.pp
    it { should contain_class('elasticsearch::package') }
    it { should contain_class('elasticsearch::config') }
    it { should contain_class('elasticsearch::service') }

    # package.pp
    it { should contain_package('elasticsearch') }

    # service.pp
    it { should contain_service('elasticsearch') }

    # config.pp
    
  end

  context "On Fedora OS" do

    let :facts do {
      :operatingsystem => 'Fedora'
    } end

    # init.pp
    it { should contain_class('elasticsearch::package') }
    it { should contain_class('elasticsearch::config') }
    it { should contain_class('elasticsearch::service') }

    # package.pp
    it { should contain_package('elasticsearch') }

    # service.pp
    it { should contain_service('elasticsearch') }

    # config.pp
  
  end

  context "On Scientific OS" do

    let :facts do {
        :operatingsystem => 'Scientific'
    } end

    # init.pp
    it { should contain_class('elasticsearch::package') }
    it { should contain_class('elasticsearch::config') }
    it { should contain_class('elasticsearch::service') }

    # package.pp
    it { should contain_package('elasticsearch') }

    # service.pp
    it { should contain_service('elasticsearch') }

    # config.pp
   
  end

  context "On Amazon OS" do

    let :facts do {
      :operatingsystem => 'Amazon'
    } end

    # init.pp
    it { should contain_class('elasticsearch::package') }
    it { should contain_class('elasticsearch::config') }
    it { should contain_class('elasticsearch::service') }

    # package.pp
    it { should contain_package('elasticsearch') }

    # service.pp
    it { should contain_service('elasticsearch') }

    # config.pp
   
  end

  context "On an unknown OS" do

    let :facts do {
      :operatingsystem => 'Darwin'
    } end
 
    it { expect { should raise_error(Puppet::Error) } }

  end

  context "install using an alternative package source" do

    context "with a debian package" do

      let :facts do {
        :operatingsystem => 'Debian'
      } end

      let :params do {
        :pkg_source => 'puppet:///path/to/package.deb',
        :config => { 'node' => { 'name' => 'test' }  }
      } end

      it { should contain_file('/tmp/package.deb').with(:source => 'puppet:///path/to/package.deb') }

      it { should contain_package('elasticsearch').with(:source => '/tmp/package.deb', :provider => 'dpkg') }

    end

    context "with a redhat package" do

      let :facts do {
        :operatingsystem => 'CentOS'
      } end

      let :params do {
        :pkg_source => 'puppet:///path/to/package.rpm',
        :config => { 'node' => { 'name' => 'test' }  }
      } end

      it { should contain_file('/tmp/package.rpm').with(:source => 'puppet:///path/to/package.rpm') }

      it { should contain_package('elasticsearch').with(:source => '/tmp/package.rpm', :provider => 'rpm') }

    end

    context "with a redhat package" do

      let :facts do {
        :operatingsystem => 'CentOS'
      } end

      let :params do {
        :pkg_source => 'puppet:///path/to/package.yaml',
        :config => { 'node' => { 'name' => 'test' }  }
      } end

      it { expect { should raise_error(Puppet::Error) } }

    end

  end

  context "install java" do

    let :params do {
      :java_install => true,
      :config => { 'node' => { 'name' => 'test' }  }
    } end

    context "On a Debian OS" do

      let :facts do {
        :operatingsystem => 'Debian'
      } end

      it { should contain_package('openjdk-6-jre-headless') }

    end

    context "On an Ubuntu OS" do

      let :facts do {
        :operatingsystem => 'Ubuntu'
      } end

      it { should contain_package('openjdk-6-jre-headless') }

    end

    context "On a CentOS OS " do

      let :facts do {
        :operatingsystem => 'CentOS'
      } end

      it { should contain_package('java-1.6.0-openjdk') }

    end

    context "On a RedHat OS " do

      let :facts do {
        :operatingsystem => 'Redhat'
      } end

      it { should contain_package('java-1.6.0-openjdk') }

    end

    context "On a Fedora OS " do

      let :facts do {
        :operatingsystem => 'Fedora'
      } end

      it { should contain_package('java-1.6.0-openjdk') }

    end

    context "On a Scientific OS " do

      let :facts do {
        :operatingsystem => 'Scientific'
      } end

      it { should contain_package('java-1.6.0-openjdk') }

    end

    context "On a Amazon OS " do

      let :facts do {
        :operatingsystem => 'Amazon'
      } end

      it { should contain_package('java-1.6.0-openjdk') }

    end

    context "On an unknown OS" do

      let :facts do {
        :operatingsystem => 'Darwin'
      } end

      it { expect { should raise_error(Puppet::Error) } }

    end

    context "Custom java package" do

      let :facts do {
        :operatingsystem => 'CentOS'
      } end

      let :params do {
        :java_install => true,
        :java_package => 'java-1.7.0-openjdk',
        :config => { 'node' => { 'name' => 'test' }  }
      } end

      it { should contain_package('java-1.7.0-openjdk') }

    end

  end

  context "test restarts on configuration change" do

    let :facts do {
      :operatingsystem => 'CentOS'
    } end

    context "does not restart when restart_on_change is false" do
      let :params do {
        :config            => { 'node' => { 'name' => 'test' }  },
        :restart_on_change => false,
      } end

      it { should contain_file('/etc/elasticsearch/elasticsearch.yml').without_notify }
    end

    context "restarts when restart_on_change is true" do
      let :params do {
        :config            => { 'node' => { 'name' => 'test' }  },
        :restart_on_change => true,
      } end

      it { should contain_file('/etc/elasticsearch/elasticsearch.yml').with_notify("Class[Elasticsearch::Service]") }
    end

  end

  context "test content of config file" do

    let :facts do {
      :operatingsystem => 'CentOS'
    } end

    context "set a value" do

      let :params do {
        :config => { 'node' => { 'name' => 'test' }  }
      } end

      it { should contain_file('/etc/elasticsearch/elasticsearch.yml').with_content("### MANAGED BY PUPPET ###\n---\nnode: \n  name: test\n") }

    end

    context "set a value to true" do

      let :params do {
        :config => { 'node' => { 'master' => true }  }
      } end

      it { should contain_file('/etc/elasticsearch/elasticsearch.yml').with_content("### MANAGED BY PUPPET ###\n---\nnode: \n  master: true\n") }

    end

    context "set a value to false" do

      let :params do {
        :config => { 'node' => { 'data' => false }  }
      } end

      it { should contain_file('/etc/elasticsearch/elasticsearch.yml').with_content("### MANAGED BY PUPPET ###\n---\nnode: \n  data: false\n") }
    end

    context "deeper hash and multiple keys" do

      let :params do {
        :config => { 'index' => { 'routing' => { 'allocation' => { 'include' => 'tag1', 'exclude' => 'tag2' } } }, 'node' => { 'name' => 'somename' } }
      } end

      it { should contain_file('/etc/elasticsearch/elasticsearch.yml').with_content("### MANAGED BY PUPPET ###\n---\nindex: \n  routing: \n    allocation: \n      exclude: tag2\n      include: tag1\nnode: \n  name: somename\n") }
    end

  end

end
