/**
 * MySQL Database model
 */

Ext.define('MySQLDatabaseTree', {
  extend: 'Ext.data.Model',
  fields: [
    {name: 'id', type: 'integer'},
    {name: 'name', type: 'string'}
  ]
});

Ext.define('MySQLDatabase', {
  extend: 'Ext.data.Model',
  fields: [
    {name: 'id', type: 'integer'},
    {name: 'name', type: 'string'},
    {name: 'engine', type: 'string'},
    {name: 'numRows', type: 'integer'},
    {name: 'avgRowLen', type: 'integer'}
  ]
});
