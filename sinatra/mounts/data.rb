##
# Data mounts
#
# @author
# @copyright
class Misty < Sinatra::Base

  DB = Sequel.connect( "mysql2://debian-sys-maint:NVwQnaUovMtZwv3XOoUQ@localhost/misty_production" )

  def json( data )
    response.headers['Content-Type'] = "application/json; charset=utf-8"
    data.to_json
  end

  post '/data/:bag_name' do
    json({ :success => true, :data => [] })
  end

  post '/data/:bag_name/*.*' do
    json({ :success => true, :data => [] })
  end

  get '/data/:bag_name' do
    pp params
    data = DB[:services].where({ :name => params[:bag_name] })
    pp data
    json ({ :success => true, :data => data })
  end ## tree

  get '/data/:bag_name/:path/?' do
    pp params
    data = []
    service = DB[:services].where({ :name => params[:bag_name] }).first
    pp service
    elements = DB[:data_elements].where({ :service_id => service[:id], :name => params[:bag_name] })
    json ({ :success => true, :data => data })
  end ## tree

end
