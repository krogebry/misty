/**
 * Data Element manager.
 */
Ext.define( 'MySQLManager', {

  extend: "Ext.tree.Panel",
  config: {
    layout: 'fit',
  },

  constructor: function( config ){

    //Ext.apply( this.config,config );
    //console.log( config.service_id );

    this.store = Ext.create('Ext.data.TreeStore', {
      id: 'mysql_db_tree_store',
      model: 'MySQLDatabaseTree',
      proxy: {
        type: 'ajax',
        url: "/mysql/tree.json"
      },
      folderSort: true
    });

    this.service_id = config.service_id;

    //var tree = Ext.create('Ext.tree.Panel', {
    Ext.apply( this,{
      title: 'MySQL Databases',
      //store: store,
      useArrows: true,
      collapsible: true,
      rootVisible: false,
      multiSelect: false,
      singleExpand: true,

      listeners: {
        selectionchange: function( m,r ){
          if(r.length == 0)
            return true
          var center = Ext.getCmp( "center_container" );
          var table_view = Ext.create( "MySQLDatabaseViewer",{ database: r[0] });
          center.add( table_view ).show();
        },scope: this
      },

      tbar: [{
        text: "New",
        iconCls: "icon-add",
        handler: function(){
            //console.log( this.service_id );
            var data_element_form = new DataElementForm({
              store_name: 'de_tree_store',
              service_id: this.service_id
            });
            var win = new Ext.Window({
              title: "Create new data element",
              closable: true,
              height: 400, width: 500,
              items: [data_element_form]
            });
            win.show();
        },scope: this
      },{
        iconCls: "icon-refresh",
        text: "Refresh",
        handler: function(){
          Ext.getStore( 'mysql_db_tree_store' ).load(); 
        }
      }],

      columns: [{
        text: 'Name',
        flex: 1,
        xtype: 'treecolumn', 
        sortable: true,
        dataIndex: 'name'
      }]

    });

    return this.callParent();
  }
}); // MySQLManager

