/**
 * MySQL Database Viewer
 */
Ext.define( 'MySQLDatabaseViewer', {
  extend: "Ext.grid.Panel",
  config: {
    layout: 'fit',
    closable: true
  },
  constructor: function( config ){

    Ext.apply( this,config );

    this.title = config.database.get( 'name' ); 
    this.store_name = "mysql_db_view_store_"+ config.database.get( 'id' );

    this.store = Ext.create('Ext.data.Store', {
      id: this.store_name,
      model: 'MySQLDatabase',
      autoLoad: true,
      proxy: {
        type: 'ajax',
        url: "/mysql/"+ config.database.get( 'name' )+".json",
        reader: {
          type: 'json',
          root: 'data'
        },
        writer: {
          type: 'json'
        }
      },
      folderSort: true,
      listeners: {
        write: function( store,op ){
          var record = op.getRecords()[0];
          //console.log( record );
        }
      }
    });

    var database = config.database;
    var store_name = this.store_name;

    Ext.apply( this,{
      iconCls: 'icon-user',
      columns: [{
        text: 'id',
        width: 40,
        sortable: true,
        dataIndex: 'id',
        renderer: function(v){
          if (Ext.isEmpty(v)) {
            v = '&#160;';
          }
          return v;
        }
      }, {
        text: 'Name',
        flex: 1,
        sortable: true,
        dataIndex: 'name',
      }, {
        header: 'Engine',
        sortable: true,
        dataIndex: 'engine'
      }, {
        header: 'Avg Row Len',
        sortable: true,
        dataIndex: 'avgRowLen'
      }, {
        header: 'Num Rows',
        sortable: true,
        dataIndex: 'numRows'
      }], 

      dockedItems: [{
        xtype: 'toolbar',
        items: [{
          text: "Refresh",
          iconCls: 'pgan-refresh',
          handler: function(){ 
            this.store.load();
          },scope: this
        }]
      }] // docked

    });
            
    return this.callParent();
  }
}); // DataElementManager

