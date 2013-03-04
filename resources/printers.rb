actions :install

attribute :name, :kind_of => String
attribute :location, :kind_of => String
attribute :ip, :kind_of => String
attribute :driver, :kind_of => String

def initialize(name, run_context=nil)
  super
  @action = :install
end
