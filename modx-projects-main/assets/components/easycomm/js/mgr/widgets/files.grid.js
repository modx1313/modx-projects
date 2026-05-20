easyComm.grid.Files = function (config) {
    config = config || {};
    if (!config.id) {
        config.id = 'ec-grid-files';
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
            action: 'File\\GetList',
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
                let result = [];
                return  result.join(' ');
            }
        },
        paging: true,
        remoteSort: true,
        autoHeight: true
    });
    easyComm.grid.Files.superclass.constructor.call(this, config);

    // Clear selection on grid refresh
    this.store.on('load', function () {
        if (this._getSelectedFiles().length) {
            this.getSelectionModel().clearSelections();
        }
    }, this);
};
Ext.extend(easyComm.grid.Files, MODx.grid.Grid, {
    windows: {},

    getMenu: function (grid, rowIndex) {
        var ids = this._getSelectedFiles();

        var row = grid.getStore().getAt(rowIndex);
        var m = [];
        if (ids.length > 1) {
            m.push({text: '<i class="x-menu-item-icon icon icon-remove"></i>'+_('ec_remove_multiple'),handler: this.removeFile});
        } else {
            m.push({text: '<i class="x-menu-item-icon icon icon-remove"></i>'+_('ec_remove'),handler: this.removeFile});
        }

        this.addContextMenuItem(m);
    },

    uploadFiles: function (btn, e) {
        if (!this.uploader) {
            this.uploader = new MODx.util.MultiUploadDialog.Dialog({
                title: _('upload'),
                url: this.config.url,
                base_params: {
                    action: 'File\\Upload',
                    message: this.config.message
                },
                cls: 'modx-upload-window'
            });
            this.uploader.on('hide', this.refresh, this);
            this.uploader.on('close', this.refresh, this);
        }

        // Automatically open picker
        this.uploader.show(btn);
        //this.uploader.buttons[0].input_file.dom.click();
    },

    removeFile: function (act, btn, e) {
        let files = this._getSelectedFiles();
        if (!files.length) {
            return false;
        }
        MODx.msg.confirm({
            title: files.length > 1
                ? _('ec_remove_multiple')
                : _('ec_remove'),
            text: files.length > 1
                ? _('ec_remove_multiple_confirm')
                : _('ec_remove_confirm'),
            url: this.config.url,
            params: {
                action: 'File\\Remove',
                message: this.message,
                files: Ext.util.JSON.encode(files)
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
        return ['preview', 'name', 'name_original', 'extension', 'size', 'size_formatted', 'path', 'url'];
    },

    getColumns: function (config) {
        return [
            this.sm,
            {
                header: _('ec_file_preview'),
                dataIndex: 'preview',
                sortable: false,
                renderer: easyComm.utils.renderFilePreview,
                width: 40
            }, {
                header: _('ec_file_name_original'),
                dataIndex: 'name_original',
                sortable: false,
                width: 70
            }, {
                header: _('ec_file_name'),
                dataIndex: 'name',
                sortable: false,
                renderer: easyComm.utils.renderFileName,
                width: 70
            }, {
                header: _('ec_file_extension'),
                dataIndex: 'extension',
                sortable: false,
                width: 30
            }, {
                header: _('ec_file_size'),
                dataIndex: 'size_formatted',
                sortable: false,
                width: 40
            }, {
                header: _('ec_file_path'),
                dataIndex: 'path',
                sortable: false,
                width: 40,
                hidden: true
            }
            , {
                header: _('ec_file_url'),
                dataIndex: 'url',
                sortable: false,
                width: 40,
                hidden: true
            }
        ];
    },

    getTopBar: function (config) {
        let result = [];
        result.push({
            text: '<i class="icon icon-plus"></i> ' + _('ec_file_upload'),
            handler: this.uploadFiles,
            scope: this
        });
        return result;
    },

    _getSelectedFiles: function () {
        let files = [];
        let selected = this.getSelectionModel().getSelections();

        for (let i in selected) {
            if (!selected.hasOwnProperty(i)) {
                continue;
            }
            files.push(selected[i]['data']['path']);
        }

        return files;
    }
});
Ext.reg('ec-grid-files', easyComm.grid.Files);