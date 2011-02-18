ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home"
  map.logout '/logout', :controller => "session", :action => "destroy"
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.session '/auth/:provider/callback', :controller => 'session', :action => 'create'
  map.session '/auth/failure', :controller => 'home'
end
