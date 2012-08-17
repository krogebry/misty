/**
 * Data Element manager.
 */
Ext.define( 'MySQLManager', {

  extend: "Ext.Panel",
  config: {
    layout: 'fit',
  },

  constructor: function( config ){

    Ext.apply( this.config,config );
    //console.log( config.service_id );

    var store = Ext.create('Ext.data.TreeStore', {
      id: 'mysql_db_tree_store',
      model: 'MySQLDatabase',
      proxy: {
        type: 'ajax',
        url: "/mysql/tree.json"
      },
      folderSort: true
    });

    this.service_id = config.service_id;

    var tree = Ext.create('Ext.tree.Panel', {
      title: 'MySQL Databases',
      width: 550,
      //height: 300,
      //flex: 1,
      collapsible: true,
      useArrows: true,
      rootVisible: false,
      store: store,
      multiSelect: true,
      listeners: {
        selectionchange: function( m,r ){
          if(r.length == 0)
            return true

          var path = this.get_path( r[0], [] ).sort(function(a,b){return b-a}).join( "/" );
          //console.log();

          var de_view = new DataElementView({ 
            path: path,
            data_element: r[0], 
            service_id: this.service_id 
          });
          tab_panel.add( de_view).show();
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
        iconCls: "pgan-refresh",
        text: "Refresh",
        handler: function(){
          Ext.getStore( 'de_tree_store' ).load(); 
        }
      }],
      singleExpand: true,
      columns: [{
        xtype: 'treecolumn', //this is so we know which column will show the tree
        text: 'Name',
        flex: 2,
        sortable: true,
        dataIndex: 'name'
      }
      /** {
        text: 'Id',
        flex: 1,
        dataIndex: 'id',
        sortable: true
      } */
      ]
    });

    var tab_panel = Ext.create( 'Ext.tab.Panel',{
      flex: 1,
      items: [{
        title: "Dashboard",
        html: "blah"
      }]
    });

    this.items = [new Ext.Panel({
      height: 600,
      layout: { 
        pack: 'start', 
        type: 'hbox', 
        align: 'stretch' 
      },
      items: [ tree, tab_panel ]
    })]

    return this.callParent();
  }
}); // MySQLManager

