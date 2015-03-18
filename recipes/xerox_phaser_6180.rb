dmg_package '6180 Print Installer' do
    source "http://download.support.xerox.com/pub/drivers/6180/drivers/macosx109/pt_BR/Phaser_6180_OS_10.9_Print_Installer.dmg"
    action :install
    type 'pkg'
    volume 'Phaser 6180 Print Installer'
    dmg_name 'Phaser_6180_OS_10.9_Print_Installer'
end

cookbook_file "Xerox_Phaser_6180MFP.ppd" do
  path "#{Chef::Config[:file_cache_path]}/Xerox_Phaser_6180MFP.ppd"
  action :create_if_missing
end

node['drivers']['xerox_phaser_6180'].each do |xerox|
  execute "Install Samsung printer: #{xerox['name']}" do
      command "lpadmin -p '#{xerox['name']}' -L '#{xerox['location']}' -E -v lpd://#{xerox['ip']} -P \"#{Chef::Config[:file_cache_path]}/Xerox_Phaser_6180MFP.ppd\" -o printer-is-shared=false"
      not_if "lpstat -v | grep -q '#{xerox['name']}'"
  end
end
