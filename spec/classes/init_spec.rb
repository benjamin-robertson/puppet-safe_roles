require 'spec_helper'
describe 'safe_roles' do
  context 'with default values for all parameters' do
    it { should contain_class('safe_roles') }
  end
end
