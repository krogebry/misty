/**
 * MySQL Database model
 */

Ext.define('MySQLDatabase', {
  extend: 'Ext.data.Model',
  fields: [
    {name: 'id', type: 'integer'},
    {name: 'name', type: 'string'}
  ]
});

