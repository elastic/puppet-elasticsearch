require 'json'
require 'helpers/acceptance/tests/manifest_shared_examples'

shared_examples 'basic acceptance tests' do |instances|
  include_examples 'manifest application', instances

  describe package('elasticsearch') do
    it { should be_installed }
  end

  %w[
    /usr/share/elasticsearch/templates_import
    /usr/share/elasticsearch/scripts
  ].each do |dir|
    describe file(dir) do
      it { should be_directory }
    end
  end

  instances.each do |instance, config|
    describe "resources for instance #{instance}" do
      describe service("elasticsearch-#{instance}") do
        it { should be_enabled }
        it { should be_running }
      end

      describe file(pid_for(instance)) do
        it { should be_file }
        its(:content) { should match(/[0-9]+/) }
      end

      describe file("/etc/elasticsearch/#{instance}/elasticsearch.yml") do
        it { should be_file }
        it { should contain "name: #{config['node.name']}" }
        it { should contain "/var/lib/elasticsearch/#{instance}" }
      end

      describe file("/var/lib/elasticsearch/#{instance}") do
        it { should be_directory }
      end

      describe file("/etc/elasticsearch/#{instance}/scripts") do
        it { should be_symlink }
      end

      describe port(config['http.port']) do
        it 'open', :with_retries do
          should be_listening
        end
      end

      describe server :container do
        describe http("http://localhost:#{config['http.port']}/_nodes/_local") do
          it 'serves requests', :with_retries do
            expect(response.status).to eq(200)
          end

          it 'uses the default data path' do
            json = JSON.parse(response.body)['nodes'].values.first
            expect(
              json['settings']['path']
            ).to include(
              'data' => "/var/lib/elasticsearch/#{instance}"
            )
          end
        end
      end
    end
  end
end