ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home"
  map.logout '/logout', :controller => "session", :action => "destroy"
  map.game '/game', :controller => "game", :action => "index"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.session '/auth/:provider/callback', :controller => 'session', :action => 'create'
end
