(function (global, undefined) {
    var demo = {};

    function populateValue() {
        $get(demo.label).innerHTML = $get(demo.textBox).value;
        //the RadWindow's content template is an INaming container and the server code block is needed
        $find(demo.contentTemplateID).close();
    }

    function openWinContentTemplate() {
        $find(demo.templateWindowID).show();
    }
    function openWinNavigateUrl() {
        $find(demo.urlWindowID).show();
    }

    global.$windowContentDemo = demo;
    global.populateValue = populateValue;
    global.openWinContentTemplate = openWinContentTemplate;
    global.openWinNavigateUrl = openWinNavigateUrl;

    var tileList = null;
    var ddlSelectTile = null;
    var telerikDemo = global.telerikDemo = {

        tileListClientLoad: function (sender, args) {
            tileList = sender;
        },

        selectClientLoad: function (sender, args) {
            ddlSelectTile = sender;
        },

        updateDropDown: function (sender, args) {
            var tile = args.get_tile();
            if (tile.get_selected()) {
                ddlSelectTile.findItemByText(tile.get_name()).select();
            }
        },

        updateTileList: function (sender) {
            var tileNameToSelect = sender.get_selectedItem().get_text();
            tileList.get_tileByName(tileNameToSelect).set_selected(true);
        }
    };
})(window);