remote_file "#{Chef::Config[:file_cache_path]}/FIT224989_mac10.10_.zip" do
    source "http://download.support.xerox.com/pub/drivers/550_560_DCP/drivers/macosx1010/pt_BR/FIT224989_mac10.10_.zip"
    owner node['current_user']
    not_if ::File.exists?("#{Chef::Config[:file_cache_path]}/FIT224989_mac10.10_.zip")
end

execute "unzip the xerox550 driver" do
    command "unzip -j -u #{Chef::Config[:file_cache_path]}/FIT224989_mac10.10_.zip -d #{Chef::Config[:file_cache_path]}/"
    user node['current_user']
    not_if ::File.exists?("#{Chef::Config[:file_cache_path]}/XC_Integrated550_560_v1_1R_EFIGSBpDX_FD47_v1.dmg")
end

dmg_package 'Fiery Printer Driver' do
    action :install
    type 'pkg'
    dmg_name 'XC_Integrated550_560_v1_1R_EFIGSBpDX_FD47_v1'
end

execute 'Install Xerox-550' do
    command "lpadmin -p 'Xerox-550' -L 'Xerox-550' -E -v lpd://#{node['drivers']['xerox']} -P '/Library/Printers/PPDs/Contents/Resources/en.lproj/Xerox 550-560 Integrated Fiery' -o printer-is-shared=false"
    not_if 'lpstat -v | grep -q "Xerox-550"'
end
