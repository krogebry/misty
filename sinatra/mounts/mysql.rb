##
# Mount points
#
# @author
# @copyright
class Misty < Sinatra::Base

  get '/mysql/tree.json' do
    #pp params

    cfg = JSON::parse(File.read( "config/databases.json" ))
    #pp cfg

    data = []

    table_id = 0

    cfg["databases"].each do |dbCfg|
      db = Sequel.connect( "mysql2://%s:%s@%s:%i/information_schema" % [
        dbCfg["username"],
        dbCfg["password"],
        dbCfg["hostname"],
        dbCfg["port"]
      ])

      db.loggers << Logger.new( STDOUT )

      databases = []

      db[:schemata].each do |row|
        ALog.debug( "DBRow: %s" % row[:SCHEMA_NAME] )
        db_node = {
          :id => (table_id += 1),
          :cls => "icon-database",
          :leaf => true,
          :name => row[:SCHEMA_NAME]
        }

        ## check for tables
        if( false )
        tables = db[:tables].where( :table_schema => row[:SCHEMA_NAME] )
        if( tables.count > 0)
          db_node[:leaf] = false
          db_node[:children] = tables.map{|table| { 
            :id => (table_id+=1), 
            :cls => "icon-table",
            :leaf => true,
            :name => table[:TABLE_NAME]
          }}
        end
        end
        databases.push( db_node )
      end

      data.push({
        :id => (table_id += 1),
        :leaf => false,
        :name => dbCfg["hostname"],
        :children => databases
      })
    end

    response.headers['Content-Type'] = "application/json; charset=utf-8"
    return data.to_json
  end ## tree

  get '/mysql/:dbName.json' do
    dbSrvId = 0
    dbCfg = JSON::parse(File.read( "config/databases.json" ))["databases"][dbSrvId]

    db = Sequel.connect( "mysql2://%s:%s@%s:%i/information_schema" % [
      dbCfg["username"],
      dbCfg["password"],
      dbCfg["hostname"],
      dbCfg["port"]
    ])

    db.loggers << Logger.new( STDOUT )

    rowId = 0

    data = { :success => true, :data => [] }

    db[:tables].where( :TABLE_SCHEMA => params[:dbName] ).each do |row|
      #ALog.debug( "DBRow: %s" % row.inspect )
      data[:data].push({
        :id => (rowId += 1),
        :name => row[:TABLE_NAME],
        :engine => row[:ENGINE],
        :numRows => row[:TABLE_ROWS],
        :avgRowLen => row[:AVG_ROW_LENGTH]
      })
    end

    #pp data[:data]
    
    response.headers['Content-Type'] = "application/json; charset=utf-8"
    return data.to_json
  end


end
