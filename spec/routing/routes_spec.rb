require 'spec_helper'

describe 'routing to signup' do
  it 'routes /signup to users#news' do
    { :get => '/signup' }.should route_to(
      :controller => 'users',
      :action => 'new')
  end
end
