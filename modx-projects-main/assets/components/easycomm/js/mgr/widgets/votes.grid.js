easyComm.grid.Votes = function (config) {
    config = config || {};
    if (!config.id) {
        config.id = 'ec-grid-votes';
    }
    config.message = config.message || 0;
    this.sm = new Ext.grid.CheckboxSelectionModel();
    Ext.applyIf(config, {
        url: easyComm.config.connector_url,
        fields: this.getFields(config),
        columns: this.getColumns(config),
        tbar: this.getTopBar(config),
        sm: this.sm,
        baseParams: {
            action: 'Vote\\GetList',
            message: config.message
        },
        listeners: {

        },
        viewConfig: {
            forceFit: true,
            enableRowBody: true,
            autoFill: true,
            showPreview: true,
            scrollOffset: 0,
            getRowClass: function (rec, ri, p) {
                var result = [];
                return  result.join(' ');
            }
        },
        paging: true,
        remoteSort: true,
        autoHeight: true
    });
    easyComm.grid.Votes.superclass.constructor.call(this, config);

    // Clear selection on grid refresh
    this.store.on('load', function () {
        if (this._getSelectedIds().length) {
            this.getSelectionModel().clearSelections();
        }
    }, this);
};
Ext.extend(easyComm.grid.Votes, MODx.grid.Grid, {
    windows: {},

    getMenu: function (grid, rowIndex) {
        var ids = this._getSelectedIds();

        var row = grid.getStore().getAt(rowIndex);
        var m = [];
        if (ids.length > 1) {
            m.push({text: '<i class="x-menu-item-icon icon icon-remove"></i>'+_('ec_remove_multiple'),handler: this.removeVote});
        } else {
            m.push({text: '<i class="x-menu-item-icon icon icon-remove"></i>'+_('ec_remove'),handler: this.removeVote});
        }

        this.addContextMenuItem(m);
    },

    removeVote: function (act, btn, e) {
        var ids = this._getSelectedIds();
        if (!ids.length) {
            return false;
        }
        MODx.msg.confirm({
            title: ids.length > 1
                ? _('ec_remove_multiple')
                : _('ec_remove'),
            text: ids.length > 1
                ? _('ec_remove_multiple_confirm')
                : _('ec_remove_confirm'),
            url: this.config.url,
            params: {
                action: 'Vote\\Multiple',
                actionMethod: 'Remove',
                ids: Ext.util.JSON.encode(ids)
            },
            listeners: {
                success: {
                    fn: function (r) {
                        this.refresh();
                    }, scope: this
                }
            }
        });
        return true;
    },

    getFields: function (config) {
        return ['id', 'message', 'value', 'ip', 'session', 'createdon', 'createdby', 'updatedon'];
    },

    getColumns: function (config) {
        return [
            this.sm,
            {
                header: _('ec_vote_id'),
                dataIndex: 'id',
                sortable: true,
                width: 50,
                hidden: true
            }, {
                header: _('ec_vote_message'),
                dataIndex: 'message',
                sortable: true,
                width: 70,
                hidden: config.message > 0
            }, {
                header: _('ec_vote_value'),
                dataIndex: 'value',
                sortable: true,
                width: 70
            }, {
                header: _('ec_vote_ip'),
                dataIndex: 'ip',
                sortable: true,
                width: 100
            }, {
                header: _('ec_vote_session'),
                dataIndex: 'session',
                sortable: true,
                width: 120
            }, {
                header: _('ec_vote_createdon'),
                dataIndex: 'createdon',
                sortable: true,
                width: 70
            }, {
                header: _('ec_vote_createdby'),
                dataIndex: 'createdby',
                sortable: true,
                width: 70
            }, {
                header: _('ec_vote_updatedon'),
                dataIndex: 'updatedon',
                sortable: true,
                width: 70
            }
        ];
    },

    getTopBar: function (config) {
        return [
            /*'->',
            {
                xtype: 'textfield',
                name: 'query',
                width: 200,
                id: config.id + '-search-field',
                emptyText: _('ec_grid_search'),
                listeners: {
                    render: {
                        fn: function (tf) {
                            tf.getEl().addKeyListener(Ext.EventObject.ENTER, function () {
                                this._doSearch(tf);
                            }, this);
                        }, scope: this
                    }
                }
            }, {
                xtype: 'button',
                id: config.id + '-search-clear',
                text: '<i class="icon icon-times"></i>',
                listeners: {
                    click: {fn: this._clearSearch, scope: this}
                }
            }*/];
    },

    /*onClick: function (e) {
        var elem = e.getTarget();
        if (elem.nodeName == 'BUTTON') {
            var row = this.getSelectionModel().getSelected();
            if (typeof(row) != 'undefined') {
                var action = elem.getAttribute('action');
                if (action == 'showMenu') {
                    var ri = this.getStore().find('id', row.id);
                    return this._showMenu(this, ri, e);
                }
                else if (typeof this[action] === 'function') {
                    this.menu.record = row.data;
                    return this[action](this, e);
                }
            }
        }
        return this.processEvent('click', e);
    },*/

    _getSelectedIds: function () {
        var ids = [];
        var selected = this.getSelectionModel().getSelections();

        for (var i in selected) {
            if (!selected.hasOwnProperty(i)) {
                continue;
            }
            ids.push(selected[i]['id']);
        }

        return ids;
    },

    _doSearch: function (tf, nv, ov) {
        this.getStore().baseParams.query = tf.getValue();
        this.getBottomToolbar().changePage(1);
        this.refresh();
    },

    _clearSearch: function (btn, e) {
        this.getStore().baseParams.query = '';
        Ext.getCmp(this.config.id + '-search-field').setValue('');
        this.getBottomToolbar().changePage(1);
        this.refresh();
    }
});
Ext.reg('ec-grid-votes', easyComm.grid.Votes);