require 'spec_helper'

listen_port = 80

# gitがインストールされているか確認
describe package('git') do
  it { should be_installed }
end

# rubyが指定のバージョンでインストールされているか確認
describe command('ruby -v') do
  let(:path) { '/home/ec2-user/.rbenv/shims:$PATH' }
  its(:stdout) { should match /ruby 3.2.3/ }
end

# Nginxがインストールされているか確認
describe package('nginx') do
  it { should be_installed }
end

# Nginxが起動されているか確認
describe service('nginx') do
  it { should be_running }
end

# listen_port(80番ポ－ト)がlistenしているか確認
describe port(listen_port) do
  it { should be_listening }
end

# curlで200が返ってくるか確認 
describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end
